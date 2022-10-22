import 'dart:developer';

import 'package:dio/src/response.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/SuccessResponse.dart';

class ApiRepository {

  handleAPIResponseData(Response<dynamic> responseData) {
    if (responseData.statusCode == ApiConstant.STATUS_CODE_SUCCESS) {
      try {
        log("response: ${responseData.data.toString()}");
        var successResponse = SuccessResponse.fromJson(responseData.data);
        if (successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS) {
          return successResponse.data;
        } else {
          return ErrorResponse.fromJson(responseData.data);
        }
      } catch (e) {
        log("Error:$e");
        return ErrorResponse.fromJson(responseData.data);
      }
    } else {
      log("Error:${responseData.data}");
      return ErrorResponse.fromJson(responseData.data);
    }
  }
}
