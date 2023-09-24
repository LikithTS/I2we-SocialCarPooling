
import 'package:common/network/ApiConstant.dart';
import 'package:common/network/repository/ApiRepository.dart';
import 'package:common/network/request/ChangePasswordApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:dio/dio.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:common/network/apiclient.dart';
import 'package:common/network/model/error_response.dart';

import '../request/ForgetPasswordApi.dart';

class ForgetPasswordRepository extends ApiRepository {
  Future<dynamic> forgetPassword({required ForgetPasswordApi api}) async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.FORGET_PASSWORD_API_PATH, data: api.toJson());
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
}