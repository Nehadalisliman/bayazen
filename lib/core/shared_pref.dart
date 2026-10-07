import 'package:shared_preferences/shared_preferences.dart';

final userToken = SharedPrefHelper.getPref('token');
final userID = SharedPrefHelper.getPref('id');

class SharedPrefHelper {
  static late SharedPreferences sharedPref;

  static Future<void> init() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  static Future<bool> setStringPref(String key, String value) async {
    return await sharedPref.setString(key, value);
  }

  static Future<bool> setIntPref(String key, int value) async {
    return await sharedPref.setInt(key, value);
  }

  static getPref(String key) {
    return sharedPref.get(key);
  }

  static Future<bool> removePref(String key) async {
    return await sharedPref.remove(key);
  }

  static Future<bool> clear() async {
    return await sharedPref.clear();
  }
}
