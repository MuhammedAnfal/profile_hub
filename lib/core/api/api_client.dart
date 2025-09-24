import 'package:dio/dio.dart';
import 'package:profile_hub/core/api/api_exceptions.dart';
import 'package:profile_hub/core/api/api_response.dart';
import 'package:profile_hub/core/api/dio_client.dart';

class ApiClient {
  late final DioClient _dioClient;

  ApiClient() : _dioClient = DioClient();

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Options? options,
    T Function(dynamic data)? fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.dio.get(endpoint, queryParameters: queryParameters);

      return ApiResponse<T>.fromData(response.data, fromJson);
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _handleError(Object error) {
    if (error is ApiException) {
      return error;
    } else if (error is DioException) {
      throw ApiException(
        message: error.message ?? 'Unknown Dio error',
        statusCode: error.response?.statusCode ?? -1,
        responseData: error.response?.data,
      );
    } else {
      throw ApiException(message: 'Unexpected error occurred', statusCode: -1);
    }
  }
}
