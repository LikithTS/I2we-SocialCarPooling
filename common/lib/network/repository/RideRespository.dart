
import 'package:common/network/apiclient.dart';
import 'package:common/network/model/error_response.dart';
import 'package:common/network/repository/ApiRepository.dart';
import 'package:common/network/request/newRideApi.dart';
import 'package:common/network/response/SuccessResponse.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';

class RideRepository extends ApiRepository {

  Future<dynamic> postNewRide({required NewRideApi api}) async {
    Response rideData = await APIClient()
        .getDioInstance()
        .post(ApiConstant.NEW_RIDE, data: api.toJson());
    dynamic response = handleAPIResponseData(rideData);
    if (response is ErrorResponse) {
      return response;
    } else {
      return SuccessResponse();
    }
  }

}