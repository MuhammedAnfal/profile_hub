import 'package:dio/dio.dart';
import 'package:profile_hub/core/api/api_interceptors.dart';
import 'package:profile_hub/core/utils/constants/api_constants.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseApi,
        connectTimeout: Duration(milliseconds: 10000),
        sendTimeout: Duration(milliseconds: 10000),
      ),
    );
    dio.interceptors.add(ApiInterceptors());
  }
}
