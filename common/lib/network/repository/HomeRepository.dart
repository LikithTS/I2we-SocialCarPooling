import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/model/QuestionarieResponse.dart';
import 'package:common/network/repository/RefreshRepository.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:dio/dio.dart';

import '../../utils/CPSessionManager.dart';
import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../request/Postquestionarieapi.dart';
import '../response/HomeResponse.dart';
import '../response/SuccessResponse.dart';
import 'ApiRepository.dart';

class HomeRepository extends ApiRepository {
  Future<dynamic> home() async {
    try {
      log("Calling home api");
      Response userData =
          await APIClient().getDioInstance().get(ApiConstant.HOME_API_PATH);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var homeResponse = HomeResponse.fromJson(response[0]);
        log("Home response $homeResponse");
        return homeResponse;
      }
    } on DioError catch (onError) {
      if(onError.response?.statusCode == ApiConstant.HTTP_UNAUTHORIZED_ERROR) {
        RefreshRepository refreshRepository = RefreshRepository();
        Future<dynamic> future =  refreshRepository.refreshAccessToken();
        future.then((value) => {
          handleResponseData(value)
        });
      }
      throw getErrorResponse(onError);
    }
  }

  handleResponseData(value) {
    if (value is AuthResponse) {
      log("Refresh token is successful access token ${value.accessToken}");
      log("Refresh token is successful refresh token ${value.refreshToken}");
      CPSessionManager().setAuthToken(value.accessToken ?? "");
      CPSessionManager().setAuthRefreshToken(value.refreshToken ?? "");
    }
  }

  Future<dynamic> getQuestionarieData() async {
    try {
      Response questionData = await APIClient()
          .getDioInstance()
          .get(ApiConstant.QUESTIONARIE_API_PATH);
      dynamic response = handleAPIResponseData(questionData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var responseData = QuestionarieResponse.fromJson(questionData.data);
        return responseData;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> postQuestionarieData(Postquestionarieapi api) async {
    try {
      Response questionData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.QUESTIONARIE_API_PATH, data: api.toJson());
      dynamic response = handleAPIResponseData(questionData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var successResponse = SuccessResponse(statusCode: response.statusCode);
        return successResponse;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}
