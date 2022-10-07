import 'package:common/network/interceptors/logging_interceptor.dart';
import 'package:dio/dio.dart';


class APIClient {
  APIClient._privateConstructor();

  static final APIClient _instance = APIClient._privateConstructor();
  static const baseUrl = '';

  factory APIClient() {
    return _instance;
  }

  Dio getDioInstance() {
    final Dio _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: 5000,
          receiveTimeout: 3000,
          responseType: ResponseType.json,
        )
    );
    _dio.interceptors.add(LoggingInterceptors());
    return _dio;
  }


}
