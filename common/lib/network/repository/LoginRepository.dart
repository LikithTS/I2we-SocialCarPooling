import 'package:common/network/apiclient.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/request/loginapi.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import 'ApiRepository.dart';

class LoginRepository extends ApiRepository {
  Future<dynamic> login({required LoginApi api}) async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.LOGIN_API_PATH, data: api.toJson());
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var authResponse = AuthResponse.fromJson(response[0]);
        return authResponse;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> logout() async {
    try {
      Response userData =
          await APIClient().getDioInstance().post(ApiConstant.LOGOUT_API_PATH);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var successResponse = SuccessResponse(statusCode: userData.statusCode);
        return successResponse;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
