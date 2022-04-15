import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  SharedPreferencesUtils._();

  static const _isFirstTimeOpenKey = 'is_first_time_open_key';

  /// Check is first time open app
  static Future<bool> isFirstTimeOpen() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isFirstTimeOpenKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Set first time open app
  static Future<bool> setFirstTimeOpen({bool isFirstTime = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(_isFirstTimeOpenKey, isFirstTime);
  }
}