import 'package:common/network/request/FirebaseTokenApi.dart';

import 'package:common/network/apiclient.dart';
import 'package:dio/dio.dart';

import '../ApiConstant.dart';
import '../model/error_response.dart';
import '../response/SuccessResponse.dart';
import 'ApiRepository.dart';

class FirebaseRepository extends ApiRepository {
  Future<dynamic> updateFirebaseToken({required FirebaseTokenApi api}) async {
    try {
      Response userData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.FIREBASE_API_PATH, data: api.toJson());
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
