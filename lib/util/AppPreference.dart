import '../view/profile/model/UpdateUserDetails.dart';

class AppPreference {
  static final AppPreference _singleton = AppPreference._internal();

  factory AppPreference() {
    return _singleton;
  }

  AppPreference._internal();

  UserApi userDetails = UserApi();
}
