import 'dart:convert';

import 'package:dio/dio.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'BaseURL',
            connectTimeout: 5000,
            receiveTimeout: 3000,
            responseType: ResponseType.json,
          ),
        );

  late final Dio _dio;

// HTTP request methods will go here
/*  Future<Response> sendLoginQuery({required int phone}) async {
    try {
      final response = await _dio.post('/custmrRegis',queryParameters: {"first_name": "Ayush kumar",
        "email": "kr63@gmail.com",
        "password": "12345678",
        "device_token": "1235",
        "phone": phone,
        "device_id": "12356",
        "device_type": "android",
        "login_by": "manual"});
      return response.data;
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }*/
/*
 Future<Response> sendLoginQuery({required int phone}) async {
    try {
      Response response = await _dio.post('/custmrRegis',
          queryParameters: {"first_name": "viji",
        "email": "vijiglenmary28@gmail.com",
        "password": "12345678",
        "device_token": "1235",
        "phone": phone,
        "device_id": "12356",
        "device_type": "android",
        "login_by": "manual"});
      //returns the successful user data json object
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load');
      }
    }on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      throw errorMessage;
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }*/

}
