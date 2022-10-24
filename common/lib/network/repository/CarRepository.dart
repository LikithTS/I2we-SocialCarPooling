import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/request/addCarApi.dart';
import 'package:common/network/request/deleteCarApi.dart';
import 'package:common/network/request/drivingStatusApi.dart';
import 'package:common/network/response/AuthResponse.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/CarDetailsResponse.dart';
import '../response/SuccessResponse.dart';
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
      log("Success response json ${SuccessResponse}");
      return SuccessResponse();
    }
  }

  Future<dynamic> addNewCar({required AddCarApi api}) async {
    Response userData = await APIClient()
        .getDioInstance()
        .post(ApiConstant.ADD_NEW_CAR, data: api.toJson());
    dynamic response = handleAPIResponseData(userData);
    if (response is ErrorResponse) {
      return response;
    } else {
      return SuccessResponse();
    }
  }

  Future<dynamic> deleteCar({required DeleteCarApi api}) async {
    Response userData = await APIClient()
        .getDioInstance()
        .delete(ApiConstant.DELETE_CAR, data: api.toJson());
    dynamic response = handleAPIResponseData(userData);
    if (response is ErrorResponse) {
      return response;
    } else {
      return SuccessResponse();
    }
  }

}
