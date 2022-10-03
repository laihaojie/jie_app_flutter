import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// 本地存储
class SpUtil {
  SpUtil._internal();
  static final SpUtil _instance = SpUtil._internal();

  factory SpUtil() => _instance;

  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // ignore: avoid-dynamic
  Future<bool> localSet(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);

    return prefs!.setString(key, jsonString);
  }

  // ignore: avoid-dynamic
  dynamic localGet(String key) {
    String? jsonString = prefs?.getString(key);

    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setBool(String key, bool val) {
    return prefs!.setBool(key, val);
  }

  bool? getBool(String key) {
    return prefs!.getBool(key);
  }

  Future<bool> remove(String key) {
    return prefs!.remove(key);
  }
}
