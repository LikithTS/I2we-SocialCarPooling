import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/request/drivingStatusApi.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/CarDetailsResponse.dart';
import 'ApiRepository.dart';

class CarRepository extends ApiRepository {
  Future<List<dynamic>> carDetails() async {
    Response carData =
        await APIClient().getDioInstance().get(ApiConstant.CAR_API_PATH);
    dynamic response = handleAPIResponseData(carData);
    if (response is ErrorResponse) {
      return response.toList();
    } else {
      log("Response car $response");
      List<CarDetailsResponse> carResponseList = List<CarDetailsResponse>.from(
          response.map((i) => CarDetailsResponse.fromJson(i)));
      // var carResponse = CarDetailsResponse.fromJson(response);
      log("Car details response ${carResponseList.length}");
      return carResponseList;
    }
  }

  Future<dynamic> carDrivingStatusUpdate({required DrivingStatusApi api}) async {
    Response userData = await APIClient()
        .getDioInstance()
        .post(ApiConstant.CAR_DRVING_STATUS, data: api.toJson());
    dynamic response = handleAPIResponseData(userData);
    if (response is ErrorResponse) {
      return response;
    } else {
      var authResponse = AuthResponse.fromJson(response[0]);
      return authResponse;
    }
  }

}
