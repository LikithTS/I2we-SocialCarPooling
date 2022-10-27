import 'dart:developer';

import 'package:dio/src/response.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/SuccessResponse.dart';

class ApiRepository {

  handleAPIResponseData(Response<dynamic> responseData) {
    if (responseData.statusCode == ApiConstant.STATUS_CODE_SUCCESS ||
        responseData.statusCode == ApiConstant.STATUS_CODE_SUCCESS_ONE) {
      try {
        log("response: ${responseData.data.toString()}");
        var successResponse = SuccessResponse.fromJson(responseData.data);
        if (successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS ||
            successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS_ONE) {
          if (successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS) {
            log("success response data ${successResponse.data}");
            return successResponse.data;
          }
          else {
            log("success response $successResponse");
            return successResponse;
          }
        } else {
          log("error response ${responseData.data}");
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