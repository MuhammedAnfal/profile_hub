import 'package:dio/dio.dart';
import 'package:profile_hub/core/api/api_exceptions.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Content-Type': 'application/json', 'Accept': 'application/json'});
    print('Request: ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response: ${response.statusCode} ${response.data}');

    // Don't throw exceptions in onResponse, let the error handler handle it
    if (response.statusCode == 401) {
      handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        ),
      );
      return;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('DioError: ${err.type} - ${err.message}');

    ApiException apiException;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        apiException = ApiException(message: 'Request timeout', statusCode: 408);
        break;
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 500;
        final message = _getErrorMessage(err.response?.data) ?? 'Server error';
        apiException = ApiException(
          message: message,
          statusCode: statusCode,
          responseData: err.response?.data?.toString(),
        );
        break;
      case DioExceptionType.cancel:
        apiException = ApiException(message: 'Request cancelled', statusCode: -1);
        break;
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        apiException = ApiException(message: 'No internet connection', statusCode: 0);
        break;
      default:
        apiException = ApiException(message: 'Network error', statusCode: -1);
    }

    handler.reject(err.copyWith(error: apiException));
  }

  String? _getErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data['error']?.toString();
    }
    return null;
  }
}
