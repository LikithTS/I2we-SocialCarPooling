
import 'dart:collection';
import 'dart:convert';

import 'package:common/utils/storageutil.dart';

import '../model/direction.dart';

class CPSessionManager{
  //Auth Token
  final String AUTH_TOKEN = "user_auth_token";
  final String USER_NAME = "user_name";
  final String AUTH_REFRESH_TOKEN = "user_auth_refersh_token";
  final String INTRO_PAGE_VISITED = "intro_page_visited";
  final String CAR_DETAILS_AVAILABLE = "car_details_available";
  final String DIRECTION_OBJECT = "direction_object";

  static final CPSessionManager _instance = CPSessionManager._internal();

  factory CPSessionManager() {
    return _instance;
  }

  CPSessionManager._internal() {

  }

  Set<String> categoryIds = HashSet();

  void saveSelectedCategoryIds(String id, bool selected) {
    selected ? categoryIds.add(id) : categoryIds.remove(id);
  }

  bool isCategoryItemsSelected(String id) {
    return categoryIds.contains(id);
  }

  void clearAllSelectedCategoryData(){
    categoryIds.clear();
  }

  String getAuthToken() {
    return PreferencesUtil.getString(AUTH_TOKEN);
  }

  void setAuthToken(String auth_token) {
    PreferencesUtil.putString(AUTH_TOKEN, auth_token);
  }

  String getUserName() {
    return PreferencesUtil.getString(USER_NAME);
  }

  void setUserName(String user_name) {
    PreferencesUtil.putString(USER_NAME, user_name);
  }

  String getAuthRefreshToken() {
    return PreferencesUtil.getString(AUTH_REFRESH_TOKEN);
  }

  void setAuthRefreshToken(String auth_token) {
    PreferencesUtil.putString(AUTH_REFRESH_TOKEN, auth_token);
  }

  bool isUserLoggedIn() {
    String authToken = getAuthToken();
    return authToken.isNotEmpty;
  }

  void onIntroPageVisited(bool value) {
    PreferencesUtil.putBoolean(INTRO_PAGE_VISITED, value);
  }

  bool isIntroPageVisited() {
    return PreferencesUtil.getBoolean(INTRO_PAGE_VISITED);
  }

  void handleUserLogout() {
    setAuthToken("");
    setAuthRefreshToken("");
  }
  
  bool getIfCarDetailsAdded() {
    return PreferencesUtil.getBoolean(CAR_DETAILS_AVAILABLE);
  }
  
  void setIfCarDetailsAdded(bool value) {
    PreferencesUtil.putBoolean(CAR_DETAILS_AVAILABLE, value);
  }

  void setDirectionObject(String direction) {
    PreferencesUtil.putString(DIRECTION_OBJECT, direction);
  }

  Direction getDirectionObject() {
    Map<String, dynamic> json = jsonDecode(PreferencesUtil.getString(DIRECTION_OBJECT));
    var direction = Direction.fromJson(json);
    return direction;
  }

}