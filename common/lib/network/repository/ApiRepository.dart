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
    log("Status code ${responseData.statusCode}");
    if (responseData.statusCode == ApiConstant.STATUS_CODE_SUCCESS ||
        responseData.statusCode == ApiConstant.STATUS_CODE_SUCCESS_ONE) {
      try {
        log("response: ${json.encode(responseData.data)}");
        var successResponse = SuccessResponse.fromJson(responseData.data);
        if (successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS ||
            successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS_ONE) {
          if (successResponse.statusCode == ApiConstant.STATUS_CODE_SUCCESS) {
            log("success response data ${successResponse.data}");
            return successResponse.data!.isNotEmpty
                ? successResponse.data
                : successResponse;
          } else {
            log("success response $successResponse");
            return successResponse;
          }
        } else {
          log("error response ${responseData.data}");
          return ErrorResponse.fromJson(responseData.data);
        }
      } catch (e) {
        log("Error 1 : $e");
        return ErrorResponse.fromJson(responseData.data);
      }
    } else {
      log("Error 2 : ${responseData.data}");
      final String parsed = json.encode(responseData.data);
      final Map parsed2 = json.decode(parsed);
      log("Parsed $parsed2");
      return ErrorResponse.fromJson(responseData.data);
    }
  }

  ApiException getErrorResponse(DioError onError) {
    var errorMessage = DioException.fromDioError(onError).errorMessage;
    return ApiException(ErrorResponse(
        statusCode: onError.response?.statusCode,
        message: errorMessage));
  }
}
