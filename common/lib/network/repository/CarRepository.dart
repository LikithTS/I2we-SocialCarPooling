import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/request/addCarApi.dart';
import 'package:common/network/request/deleteCarApi.dart';
import 'package:common/network/request/drivingStatusApi.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/CarDetailsResponse.dart';
import '../response/SuccessResponse.dart';
import '../response/car/AddCarResponse.dart';
import '../response/user/ProfileImageUploadUrl.dart';
import 'ApiRepository.dart';

class CarRepository extends ApiRepository {
  Future<List<dynamic>> carDetails() async {
    try {
      Response carData =
          await APIClient().getDioInstance().get(ApiConstant.CAR_API_PATH);
      dynamic response = handleAPIResponseData(carData);
      if (response is ErrorResponse) {
        return List.empty();
      } else {
        log("Response car $response");
        List<CarDetailsResponse> carResponseList =
            List<CarDetailsResponse>.from(
                response.map((i) => CarDetailsResponse.fromJson(i)));
        // var carResponse = CarDetailsResponse.fromJson(response);
        log("Car details response ${carResponseList.length}");
        return carResponseList;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> carDrivingStatusUpdate(
      {required DrivingStatusApi api}) async {
    try {
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
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> addNewCar({required AddCarApi api}) async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.ADD_NEW_CAR, data: api.toJson());
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        return SuccessResponse();
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<List<AddCarResponse>> getCarUrls(int count) async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .get(ApiConstant.GET_CAR_UPLOAD_URL + "$count/");
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return List.empty();
      } else {
        List<AddCarResponse> availableRideList = List<AddCarResponse>.from(
            response.map((i) => AddCarResponse.fromJson(i)));
        return availableRideList;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> getRcUploadURL() async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .get(ApiConstant.GET_USER_PROFILE_URL);
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return "";
      } else {
        return ProfileImageUpload.fromJson(response[0]);
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> deleteCar({required DeleteCarApi api}) async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .delete(ApiConstant.DELETE_CAR, data: api.toJson());
      dynamic response = handleAPIResponseData(userData);
      if (response is ErrorResponse) {
        return response;
      } else {
        return SuccessResponse();
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}
