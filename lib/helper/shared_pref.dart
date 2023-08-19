import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  //*******shared preferences
  late SharedPreferences shared;

  Future<bool> save({required String key, required String value}) async {
    shared = await SharedPreferences.getInstance();
    return shared.setString(key, value);
    // print("$key kaydedildi");
  }

  Future<String> get({required String key}) async {
    shared = await SharedPreferences.getInstance();
    String s = shared.getString(key) ?? "";
    // if (s != "") print("$key getirildi");
    return s;
  }
}
