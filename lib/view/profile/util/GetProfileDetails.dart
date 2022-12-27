import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/userdetails/UserDetail.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/AppPreference.dart';

class GetProfileDetails {
  GetProfileDetails(BuildContext context) {
    getUserApi(context);
  }

  void getUserApi(BuildContext context) {
    Future<dynamic> future = UpdateUserRepository().getUserDetail();
    future.then((value) => {handleResponseData(value, context)});
  }

  handleResponseData(value, BuildContext context) {
    print("User profile data $value");
    if (value is UserDetail) {
      AppPreference().userDetail = value;
      AppPreference().profileImageKey = value.profileImage ?? "";
    }
  }
}
