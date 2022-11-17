import 'dart:convert';
import 'dart:developer';

import 'package:common/network/exception/dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../ApiConstant.dart';
import '../exception/ApiException.dart';
import '../model/error_response.dart';
import '../response/SuccessResponse.dart';

class ApiRepository {

  handleAPIResponseData(Response<dynamic> responseData) {
    if (responseData.statusCode == ApiConstant.STATUS_CODE_SUCCESS ||
        responseData.statusCode == ApiConstant.STATUS_CODE_SUCCESS_ONE) {
      try {
        log("response: ${json.encode(responseData.data)}");
        var successResponse = SuccessResponse.fromJson(responseData.data);
        if (successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS ||
            successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS_ONE) {
          if (successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS) {
            log("success response data ${successResponse.data}");
            return successResponse.data!.isNotEmpty ? successResponse.data : successResponse;
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
      ErrorResponse(status: responseData.statusCode);
    }
  }

  ApiException getErrorResponse(DioError onError) {
    var errorMessage = DioException.fromDioError(onError).errorMessage;
    return ApiException(ErrorResponse(
        status: onError.response?.statusCode,
        errorMessage: errorMessage,
        errorCode: onError.response?.statusCode));
  }
}