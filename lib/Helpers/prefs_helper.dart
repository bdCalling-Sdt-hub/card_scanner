
import 'dart:convert';

import 'package:card_scanner/utils/app_strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PrefsHelper extends GetxController {
  static String token = "";
  static bool isInformation = false;
  static bool isStyle = false;
  static String localizationLanguageCode = 'en';
  static String localizationCountryCode = 'US';
  static String cameraImage = '';
  static bool signedIn = false;

  ///<<<======================== Get All Data Form Shared Preference ==============>

  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    signedIn = preferences.getBool(AppStrings.signedIn) ?? false;
    cameraImage = preferences.getString("cameraImage") ?? "";
  }

  ///<<<======================== Get Data Form Shared Preference ==============>

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  static Future<List<dynamic>> getList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? stringList = prefs.getStringList(key);
    if (stringList != null) {
      final List<dynamic> list = stringList.map((item) => jsonDecode(item)).toList();
      return list;
    } else {
      return [];
    }
  }

  ///<<<=====================Save Data To Shared Preference=====================>

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  static Future<void> setList(String key, List<dynamic> list) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stringList = list.map((item) => item.toString()).toList();
    await prefs.setStringList(key, stringList);
    print(stringList);
  }


  ///<<<==========================Remove Value==================================>

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  ///<<<======================== Get All Data Form Shared Preference ============>
  static Future<void> removeAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    preferences.setString("clientId", "");
    preferences.setString("myEmail", "");
    preferences.setString("cameraImage", "");
    preferences.setBool("isProvider", false);
    preferences.setBool(AppStrings.signedIn, false);
    signedIn = false;
    token = "";
  }
}