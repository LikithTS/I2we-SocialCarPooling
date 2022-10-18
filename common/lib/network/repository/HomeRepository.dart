import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/AuthResponse.dart';
import '../response/HomeResponse.dart';
import 'ApiRepository.dart';

class HomeRepository extends ApiRepository{
  
  Future<dynamic> home() async {

    Response userData = await APIClient()
        .getDioInstance()
        .get(ApiConstant.HOME_API_PATH);
    dynamic response = handleAPIResponseData(userData);
    if (response is ErrorResponse) {
      return response;
    } else {
      var homeResponse = HomeResponse.fromJson(response[0]);
      log("Home response $homeResponse");
      return homeResponse;
    }
  }
}