
import 'dart:convert';

import 'package:card_scanner/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/contacts_model.dart';



class PrefsHelper extends GetxController {


  static String token = "";
  static bool isInformation = false;
  static bool isStyle = false;
  static String localizationLanguageCode = 'en';
  static String localizationCountryCode = 'US';
  static String cameraImage = '';
  static bool signedIn = false;

  static String userName = "";
  static String userMail = "";
  static String userPhone = "";
  static String userDesignation = "";
  static String userCompany = "";
  static String userAddress = "";
  static String userTelephone = "";
  static String userFax = "";
  static String userWebsite = "";

  static String profileImagePath = "";
  static String myCardImage = "";

  static int colorIndex = 0;
  static int unGroupedContacts = 0;
  static bool isLogoShow = true;
  static bool isProfilePhotoShow = true;
  static List<ContactGroup>groupedContactsList = [];

  ///<<<======================== Get All Data Form Shared Preference ==============>

  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    signedIn = preferences.getBool(AppStrings.signedIn) ?? false;

    userName = preferences.getString("userName") ?? "";
    userMail = preferences.getString("userMail") ?? "";
    userPhone = preferences.getString("userPhone") ?? "";
    userDesignation = preferences.getString("userDesignation") ?? "";
    userCompany = preferences.getString("userCompany") ?? "";
    userAddress = preferences.getString("userAddress") ?? "";
    userTelephone = preferences.getString("userTelephone") ?? "";
    userFax = preferences.getString("userFax") ?? "";
    userWebsite = preferences.getString("userWebsite") ?? "";

    profileImagePath = preferences.getString("profileImagePath") ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png";
    myCardImage = preferences.getString("myCardImage") ?? "";

    cameraImage = preferences.getString("cameraImage") ?? "";
    colorIndex = preferences.getInt("colorIndex") ?? 0;
    unGroupedContacts = preferences.getInt("unGroupedContacts") ?? 0;
    isLogoShow = preferences.getBool("isLogoShow") ?? true;
    isProfilePhotoShow = preferences.getBool("isProfilePhotoShow") ?? true;
    isProfilePhotoShow = preferences.getBool("isProfilePhotoShow") ?? true;
    groupedContactsList = await getGroupedList();
    localizationLanguageCode = preferences.getString("localizationLanguageCode") ?? "en";
    localizationCountryCode = preferences.getString("localizationCountryCode") ?? "US";
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
    unGroupedContacts  = preferences.getInt("unGroupedContacts") ?? 0;
    return preferences.getInt(key) ?? (0);
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

  // To load the list from shared preferences
  static Future<List<ContactGroup>> getGroupedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? serializedJson = prefs.getString('contactsList');
    if (serializedJson != null) {
      List<dynamic> decodedList = json.decode(serializedJson);
      return decodedList.map((json) => ContactGroup.fromJson(json)).toList();
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
    if (kDebugMode) {
      print(stringList);
    }
  }

  static void saveGroupedList(List<ContactGroup> groupedContactsList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> serializedList = groupedContactsList.map((group) => group.toJson()).toList();
    String serializedJson = json.encode(serializedList);

    await prefs.setString('contactsList', serializedJson);
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