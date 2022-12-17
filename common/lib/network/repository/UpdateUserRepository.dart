import 'dart:developer';

import 'package:common/network/repository/ApiRepository.dart';
import 'package:common/network/repository/RefreshRepository.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:common/network/response/user/ProfileImageUpload.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:dio/dio.dart';
import 'package:socialcarpooling/view/profile/model/UpdateUserDetails.dart';

import '../ApiConstant.dart';
import '../apiclient.dart';
import '../model/error_response.dart';
import '../response/SuccessResponse.dart';
import '../response/user/UserProfileData.dart';

class UpdateUserRepository extends ApiRepository {
  Future<dynamic> updateUserDetails({required UserProfileData api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.UPDATE_USER, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
      if (response is ErrorResponse) {
        return response;
      } else {
        return SuccessResponse();
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> getUserDetails() async {
    try {
      Response userData =
          await APIClient().getDioInstance().get(ApiConstant.GET_USER);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        return updaterUserApiFromJson(response);
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> getUserProfileDetails() async {
    try {
      Response userData =
          await APIClient().getDioInstance().get(ApiConstant.GET_USER);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        return UserProfileData.fromJson(response[0]);
      }
    } on DioError catch (onError) {
      if (onError.response?.statusCode == ApiConstant.HTTP_UNAUTHORIZED_ERROR) {
        RefreshRepository refreshRepository = RefreshRepository();
        Future<dynamic> future = refreshRepository.refreshAccessToken();
        future.then((value) => {handleResponseData(value)});
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

  Future<dynamic> getUserProfileUrl() async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .get(ApiConstant.GET_USER_PROFILE_URL);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return "";
      } else {
        return ProfileImageUpload.fromJson(response[0]);
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}
