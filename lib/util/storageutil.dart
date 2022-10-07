import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static PreferencesUtil? _prefUtil;
  static SharedPreferences? _preferences;

  static Future<PreferencesUtil?> getInstance() async {
    if (_prefUtil == null) {
      var secureStorage = PreferencesUtil._();
      await secureStorage._init();
      _prefUtil = secureStorage;
    }
    return _prefUtil;
  }

  PreferencesUtil._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences?.getString(key) ?? defValue;
  }

  // put string
  static Future<bool>? putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences?.setString(key, value);
  }
}
