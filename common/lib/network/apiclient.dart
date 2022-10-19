import 'package:common/network/interceptors/logging_interceptor.dart';
import 'package:common/utils/storageutil.dart';
import 'package:dio/dio.dart';


class APIClient {
  APIClient._privateConstructor();

  static final APIClient _instance = APIClient._privateConstructor();
  static const baseUrl = 'http://13.233.179.186/';

  factory APIClient() {
    return _instance;
  }

  Dio getDioInstance() {
    final Dio _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: getHeaders(),
          connectTimeout: 5000,
          receiveTimeout: 3000,
          responseType: ResponseType.json,
        )
    );
    _dio.interceptors.add(LoggingInterceptors());
    return _dio;
  }

  getHeaders() {
    var headers = <String, dynamic>{};
    var authToken = PreferencesUtil.getString("user_auth_token");
    headers["Authorization"] = "Bearer $authToken";
    return headers;
  }


}
