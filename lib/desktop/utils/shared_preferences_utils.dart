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