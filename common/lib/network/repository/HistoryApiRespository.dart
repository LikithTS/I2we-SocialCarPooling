import 'package:common/network/apiclient.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/HistoryResponse.dart';
import 'ApiRepository.dart';

class HistoryApiRepository extends ApiRepository {
  Future<dynamic> getAllRides() async {
    try {
      Response historyData =
          await APIClient().getDioInstance().get(ApiConstant.HISTORY);
      dynamic response = handleAPIResponseData(historyData);
      if (response is ErrorResponse) {
        return response;
      } else {
        var responseData = HistoryResponse.fromJson(historyData.data);
        return responseData;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}
