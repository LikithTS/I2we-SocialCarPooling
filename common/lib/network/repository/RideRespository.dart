
import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/model/UpcomingRides.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/ApiRepository.dart';
import 'package:common/network/request/RideStatusApi.dart';
import 'package:common/network/request/newRideApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';

class RideRepository extends ApiRepository {

  Future<dynamic> postNewRide({required NewRideApi api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.NEW_RIDE, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
      if (response is ErrorResponse) {
        return response;
      } else {
        return SuccessResponse();
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<List<UpcomingRides>> getUpcomingRides() async {
    try {
      Response carData =
      await APIClient().getDioInstance().get(ApiConstant.UPCOMING_RIDE);
      dynamic response = handleAPIResponseData(carData);
      if (response is ErrorResponse) {
        return List.empty();
      } else {
        log("Response ride $response");
        if(response is SuccessResponse) {
          if(response.data != null && response.data!.isEmpty) {
              return List.empty();
          }
        }
        List<UpcomingRides> upcomingRidesList = List<UpcomingRides>.from(
            response.map((i) => UpcomingRides.fromJson(i)));
        // var carResponse = CarDetailsResponse.fromJson(response);
        log("Upcoming ride response ${upcomingRidesList.length}");
        return upcomingRidesList;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<List<dynamic>> getAvailableRides() async {
    try {
      Response carData =
      await APIClient().getDioInstance().get(ApiConstant.AVAILABLE_RIDES);
      dynamic response = handleAPIResponseData(carData);
      if (response is ErrorResponse) {
        return List.empty();
      } else {
        log("Response available rides $response");
        List<UpcomingRides> upcomingRidesList = List<UpcomingRides>.from(
            response.map((i) => UpcomingRides.fromJson(i)));
        // var carResponse = CarDetailsResponse.fromJson(response);
        log("available ride response ${upcomingRidesList.length}");
        return upcomingRidesList;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> updateRideStatus({required RideStatusApi api, required String apiPath}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(apiPath, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
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