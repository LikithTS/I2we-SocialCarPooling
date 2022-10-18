import 'package:common/network/interceptors/logging_interceptor.dart';
import 'package:dio/dio.dart';


class APIClient {
  APIClient._privateConstructor();

  static final APIClient _instance = APIClient._privateConstructor();
  static const baseUrl = 'http://13.233.179.186/';
  static const headerValue = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzMjM2MDU2MjY3YTg1NTgxNGU5OTlhOCIsImlhdCI6MTY2NTk4NTExMSwiZXhwIjoxNjY2MDcxNTExfQ.V2KjB8vmjN64OIDlLzw7yGxmu3EppI94sENnmy899gI';
  var headers = {'Authorization':'Bearer $headerValue'};

  factory APIClient() {
    return _instance;
  }

  Dio getDioInstance() {
    final Dio _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: headers,
          connectTimeout: 5000,
          receiveTimeout: 3000,
          // responseType: ResponseType,
        )
    );
    _dio.interceptors.add(LoggingInterceptors());
    return _dio;
  }


}
