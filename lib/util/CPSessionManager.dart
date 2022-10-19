
import 'dart:collection';

import 'package:common/utils/storageutil.dart';

class CPSessionManager{
  //Auth Token
  final String AUTH_TOKEN = "user_auth_token";
  final String AUTH_REFRESH_TOKEN = "user_auth_refersh_token";
  final String INTRO_PAGE_VISITED = "intro_page_visited";

  static final CPSessionManager _instance = CPSessionManager._internal();

  factory CPSessionManager() {
    return _instance;
  }

  CPSessionManager._internal() {

  }

  Set<int> categoryIds = HashSet();

  void saveSelectedCategoryIds(int id, bool selected) {
    selected ? categoryIds.add(id) : categoryIds.remove(id);
  }

  bool isCategoryItemsSelected(int id) {
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

}