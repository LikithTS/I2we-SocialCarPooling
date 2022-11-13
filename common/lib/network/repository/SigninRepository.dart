import 'dart:developer';

import 'package:common/network/request/SendOtpApi.dart';
import 'package:common/network/request/ValidOtpApi.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:dio/dio.dart';
import 'package:common/network/apiclient.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../request/signinapi.dart';
import 'ApiRepository.dart';

class SigninRepository extends ApiRepository {

  Future<dynamic> signIn({required SignInApi api}) async {
    Response userData = await APIClient()
        .getDioInstance()
        .post(ApiConstant.SIGN_IN_API_PATH, data: api.toJson());
    dynamic response = handleAPIResponseData(userData);
    if (response is ErrorResponse) {
      return response;
    } else {
      var successResponse = response;
      return successResponse;
    }
  }

  Future<dynamic> sendOtp({required SendOtpApi api}) async {
    Response sendOtpData = await APIClient()
        .getDioInstance()
        .post(ApiConstant.SEND_OTP_API_PATH, data: api.toJson());
    dynamic response = handleAPIResponseData(sendOtpData);
    if (response is ErrorResponse) {
      return response;
    } else {
      var successResponse = response;
      return successResponse;
    }
  }

  Future<dynamic> validOtp({required ValidOtpApi api}) async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.VERIFY_OTP_API_PATH, data: api.toJson());
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var authResponse = AuthResponse.fromJson(response[0]);
        log("Auth Response from json $authResponse");
        return authResponse;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}
