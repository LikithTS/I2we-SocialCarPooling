

import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/ApiRepository.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:dio/dio.dart';
import 'package:socialcarpooling/util/CPSessionManager.dart';

import '../ApiConstant.dart';

class RefreshRepository extends ApiRepository {

  Future<void> refreshAccessToken() async {
    try {
      Response refreshData = await APIClient()
          .getRefreshDioInstance()
          .post(ApiConstant.REFRESH);
      dynamic response = handleAPIResponseData(refreshData);
      if (response is ErrorResponse) {
        //Do nothing
      } else {
        var authResponse = AuthResponse.fromJson(response[0]);
        log("Saving new refresh and access token");
        CPSessionManager().setAuthToken(authResponse.accessToken ?? "");
        CPSessionManager().setAuthRefreshToken(authResponse.refreshToken ?? "");
        log("After saving new refresh token data ");
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}