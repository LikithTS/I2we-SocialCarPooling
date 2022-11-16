import 'package:common/network/repository/ApiRepository.dart';
import 'package:dio/dio.dart';
import 'package:socialcarpooling/view/profile/model/UpdateUserDetails.dart';

import '../ApiConstant.dart';
import '../apiclient.dart';
import '../model/error_response.dart';
import '../response/SuccessResponse.dart';

class UpdateUserRepository extends ApiRepository {
  Future<dynamic> updateUserDetails({required UpdaterUserApi api}) async {
    try {
      Response rideData = await APIClient()
          .getDioInstance()
          .post(ApiConstant.UPDATE_USER, data: api.toJson());
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
