import 'package:shared_preferences/shared_preferences.dart';

Future saveStringToSharedPreferences({
  String? key,
  String? value,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key ?? '', value ?? '');
}

Future<String?> getStringFromSharedPreferences({
  required String key,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future saveListStringToSharedPreferences({
  required String key,
  required List<String> value,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(key, value);
}

Future<List<String>?> getListStringFromSharedPreferences({
  required String key,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList(key);
}

Future saveBooleanToSharedPreferences({
  String? key,
  bool? value,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key ?? '', value ?? false);
}

Future<bool?> getBooleanFromSharedPreferences({
  required String key,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

Future clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}
