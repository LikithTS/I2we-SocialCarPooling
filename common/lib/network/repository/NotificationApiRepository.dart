import 'package:common/network/apiclient.dart';
import 'package:common/network/model/NotificationDetails.dart';
import 'package:common/network/repository/ApiRepository.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';

class NotificationApiRepository extends ApiRepository {
  Future<List<NotificationDetails>> getAllNotifications() async {
    try {
      Response notificationData =
          await APIClient().getDioInstance().get(ApiConstant.GET_NOTIFICATIONS);
      dynamic response = handleAPIResponseData(notificationData);
      if (response is ErrorResponse) {
        return List.empty();
      } else {
        List<NotificationDetails> notificationList =
            List<NotificationDetails>.from(
                response.map((i) => NotificationDetails.fromJson(i)));
        return notificationList;
      }
    } on DioError catch (onError) {
      throw getErrorResponse(onError);
    }
  }
}
