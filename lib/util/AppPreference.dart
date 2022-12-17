import 'package:common/network/response/user/UserProfileData.dart';

class AppPreference {
  static final AppPreference _singleton = AppPreference._internal();

  factory AppPreference() {
    return _singleton;
  }

  AppPreference._internal();

  UserProfileData? userProfileData;
  String profileImageKey = "";
  String imageBaseUrl = "https://i2w-data.s3.ap-south-1.amazonaws.com/";
}
