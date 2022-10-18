import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:dio/dio.dart';

import '../model/error_response.dart';
import '../response/HomeResponse.dart';

class HomeRepository {
  
  Future<dynamic> home() async {
    Response homeData = await APIClient().getDioInstance().get("home");
    if(homeData.statusCode == 200) {
      try {
        // var successResponse = SuccessResponse.fromJson(homeData.data);
        // if (successResponse.status == 200) {
        //   var responseJson = successResponse.responseData![0];
        //   var homeResponse = HomeResponse.fromJson(responseJson);
        //   log("Home response: $homeResponse");
        //   return homeResponse;
        // }
        log("Home data ${homeData.data.toString()}");
        var homeResponse = HomeResponse.fromJson(homeData.data);
        log("Home response: $homeResponse");
        return homeResponse;
      } catch (e) {
        log("Error:$e");
      }
    }
  }
}