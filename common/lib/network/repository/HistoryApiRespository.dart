import 'package:common/network/apiclient.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/HistoryResponse.dart';
import 'ApiRepository.dart';

class HistoryApiRepository extends ApiRepository {
  Future<dynamic> getAllRides() async {
    try {
      Response carData =
          await APIClient().getDioInstance().get(ApiConstant.ALL_RIDE);
      dynamic response = handleAPIResponseData(carData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var responseData = HistoryResponse.fromJson(response[0]);
        return responseData;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}
