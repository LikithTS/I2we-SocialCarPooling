import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:common/network/response/user/UserProfileData.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/util/AppPreference.dart';

class GetProfileDetails {
  GetProfileDetails(BuildContext context) {
    getUserApi(context);
  }

  void getUserApi(BuildContext context) {
    Future<dynamic> future = UpdateUserRepository().getUserProfileDetails();
    future.then((value) => {handleResponseData(value, context)});
  }

  handleResponseData(value, BuildContext context) {
    print("User profile data $value");
    if (value is UserProfileData) {
      AppPreference().userProfileData = value;
      AppPreference().profileImageKey = value.profileImage ?? "";
    }
  }
}
