import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    log("Headers:");
    options.headers.forEach((k, v) => log('$k: $v'));
    if (options.queryParameters != null) {
      log("queryParameters:");
      options.queryParameters.forEach((k, v) => log('$k: $v'));
    }
    if (options.data != null) {
      log("Body: ${options.data}");
    }
    log(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    handler.next(options);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    log(
        "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response?.requestOptions.baseUrl) : 'URL')}");
    log(
        "${dioError.response != null ? dioError.response?.data : 'Unknown Error'}");
    log("<-- End error");
    super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
        "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    log("Headers:");
    response.headers.forEach((k, v) => log('$k: $v'));
    log("Response: ${response.data}");
    log("<-- END HTTP");
    super.onResponse(response, handler);
  }
}
