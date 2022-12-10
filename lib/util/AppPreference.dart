import 'package:common/network/response/user/UserProfileData.dart';

class AppPreference {
  static final AppPreference _singleton = AppPreference._internal();

  factory AppPreference() {
    return _singleton;
  }

  AppPreference._internal();

  UserProfileData? userProfileData;
}
