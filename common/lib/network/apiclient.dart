import 'dart:developer';

import 'package:common/network/interceptors/logging_interceptor.dart';
import 'package:common/network/repository/RefreshRepository.dart';
import 'package:common/utils/storageutil.dart';
import 'package:dio/dio.dart';

class APIClient {
  APIClient._privateConstructor();

  static final APIClient _instance = APIClient._privateConstructor();
  // static const baseUrl =
  //     'http://I2weebackend-env.eba-fa7sbxxg.ap-south-1.elasticbeanstalk.com/';
  static const baseUrl = 'https://backend.i2we.community/';
  factory APIClient() {
    return _instance;
  }

  Dio getDioInstance() {
    final Dio _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: getHeaders(),
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.json,
    ));
    _dio.interceptors.add(LoggingInterceptors());
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, errorInterceptorHandler) async {
        log("Status code in api client ${error.response?.statusCode}");
        if (error.response?.statusCode == 403 ||
            error.response?.statusCode == 401) {
          await RefreshRepository().refreshAccessToken();
          _retry(_dio, error.requestOptions);
        } else {
          errorInterceptorHandler.resolve(Response(
              requestOptions: error.requestOptions,
              data: error.response?.data,
              statusCode: error.response?.statusCode));
        }
      },
    ));
    log("return dio");
    return _dio;
  }

  Dio getRefreshDioInstance() {
    final Dio _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: getRefreshTokenHeaders(),
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.json,
    ));
    _dio.interceptors.add(LoggingInterceptors());
    return _dio;
  }

  getHeaders() {
    var headers = <String, dynamic>{};
    var authToken = PreferencesUtil.getString("user_auth_token");
    log("Auth token $authToken");
    headers["Authorization"] = "Bearer $authToken";
    return headers;
  }

  getRefreshTokenHeaders() {
    var headers = <String, dynamic>{};
    var authToken = PreferencesUtil.getString("user_auth_refersh_token");
    log("Refresh token $authToken");
    headers["Authorization"] = "Bearer $authToken";
    return headers;
  }

  Future<Response<dynamic>> _retry(
      Dio dio, RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: getHeaders(),
    );
    log("Retrying request");
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
