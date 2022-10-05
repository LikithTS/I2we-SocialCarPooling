import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:socialcarpooling/network/apiclient.dart';
import 'package:socialcarpooling/network/model/error_response.dart';
import 'package:socialcarpooling/network/request/loginapi.dart';
import 'package:socialcarpooling/network/response/LoginResponse.dart';
import 'package:socialcarpooling/network/response/SuccessResponse.dart';

class LoginRepository{

  Future<dynamic> login({required LoginApi api}) async {
    Response userData = await APIClient().getDioInstance()
        .post("/user/login", data: api.toJson());
    if (userData.statusCode == 200) {
      try {
        var successResponse = SuccessResponse.fromJson(userData.data);
        if (successResponse.status == 200) {
          var responseJson = successResponse.responseData![0];
          var loginResponse = LoginResponse.fromJson(responseJson);
          log("legionaries: $loginResponse");
          return loginResponse;
        } else {
          return ErrorResponse.fromJson(userData.data);
        }
      } catch (e) {
        log("Error:$e");
      }
    } else {
      return ErrorResponse.fromJson(userData.data);
    }
  }
}