import 'dart:developer';

import 'package:common/network/repository/ApiRepository.dart';
import 'package:common/network/repository/RefreshRepository.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:common/network/response/driver/DrivingLicenseUpdate.dart';
import 'package:common/network/response/profile/UpdateUserProfile.dart';
import 'package:common/network/response/user/IdentificationImageUpload.dart';
import 'package:common/network/response/user/ProfileImageUpdate.dart';
import 'package:common/network/response/userdetails/UserDetail.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../apiclient.dart';
import '../model/error_response.dart';
import '../response/SuccessResponse.dart';
import '../response/user/ProfileImageUploadUrl.dart';

class UpdateUserRepository extends ApiRepository {
  Future<dynamic> updateUserDetails({required UpdateUserProfile api}) async {
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

  Future<dynamic> updateProfilePhoto({required ProfileImageUpdate api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.POST_UPDATE_PROFILE_PHOTO, data: api.toJson());
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

  Future<dynamic> updateDrivingLicensePhoto(
      {required DrivingLicenseUpdate api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.POST_UPDATE_DL_PHOTO, data: api.toJson());
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

  Future<dynamic> getUserDetail() async {
    try {
      Response userData =
          await APIClient().getDioInstance().get(ApiConstant.GET_USER);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        return UserDetail.fromJson(response[0]);
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

  Future<dynamic> getUserIdentificationUrl() async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .get(ApiConstant.GET_IDENTIFICATION_URL);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return "";
      } else {
        return IdentificationImageUpload.fromJson(userData);
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> getUserDrivingLicenseUrl() async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .get(ApiConstant.GET_DRIVING_LICENSE_URL);
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
