import 'dart:developer';

import 'package:common/network/apiclient.dart';
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
}
