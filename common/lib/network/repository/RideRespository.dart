import 'dart:developer';

import 'package:common/network/apiclient.dart';
import 'package:common/network/model/AvailableRideResponse.dart';
import 'package:common/network/model/UpcomingRides.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/ApiRepository.dart';
import 'package:common/network/request/AvailableRideApi.dart';
import 'package:common/network/request/CurrentRideApi.dart';
import 'package:common/network/request/InviteRideApi.dart';
import 'package:common/network/request/JoinRideApi.dart';
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
        if (response is SuccessResponse) {
          if (response.data != null && response.data!.isEmpty) {
            return List.empty();
          }
        }
        List<UpcomingRides> upcomingRidesList = List<UpcomingRides>.from(
            response.map((i) => UpcomingRides.fromJson(i)));
        // var carResponse = CarDetailsResponse.fromJson(response);
        log("Upcoming rides list $upcomingRidesList");
        return upcomingRidesList;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<List<AvailableRidesResponse>> postAvailableRides(
      {required AvailableRideApi api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.AVAILABLE_RIDES, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
      if (response is ErrorResponse) {
        return List.empty();
      } else {
        if (response is SuccessResponse) {
          if (response.data != null && response.data!.isEmpty) {
            return List.empty();
          }
        }
        List<AvailableRidesResponse> availableRideList =
            List<AvailableRidesResponse>.from(
                response.map((i) => AvailableRidesResponse.fromJson(i)));
        return availableRideList;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> inviteRide(
      {required InviteRideApi api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.INVITE_RIDE, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
      if (response is ErrorResponse) {
        return response;
      } else if(response is SuccessResponse){
        return SuccessResponse();
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> joinRide(
      {required JoinRideApi api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.JOIN_RIDE, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
      if (response is ErrorResponse) {
        return response;
      } else if(response is SuccessResponse){
        return SuccessResponse();
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> inviteCancel(
      {required JoinRideApi api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.INVITE_CANCEL, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
      if (response is ErrorResponse) {
        return response;
      } else if(response is SuccessResponse){
        return SuccessResponse();
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

  Future<dynamic> updateRideStatus(
      {required RideStatusApi api, required String apiPath}) async {
    try {
      Response rideData =
          await APIClient().getDioInstance().post(apiPath, data: api.toJson());
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

  Future<dynamic> getCurrentRide(
      {required CurrentRideApi api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.CURRENT_RIDE, data: api.toJson());
      dynamic response = handleAPIResponseData(rideData);
      if (response is ErrorResponse) {
        return response;
      } else if(response is SuccessResponse){
        var responseData = UpcomingRides.fromJson(response.data?[0]);
        log("Current ride details ${responseData.rideType}");
        return responseData;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }

}
