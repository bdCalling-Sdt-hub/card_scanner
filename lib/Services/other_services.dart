
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_utils.dart';


class OtherService {
  static bool isFirst = true;

  static checkConnection() {
    Connectivity().onConnectivityChanged.listen((event) {
      checkInternet();
    });
  }

  static checkInternet() async {
    List<ConnectivityResult> connectivityResult =
    await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      Utils.toastMessage(
          message: "You are currently offline. Check your internet connection please".tr, icon: Icons.wifi_off);
    } else {
      if (isFirst) {
        if (connectivityResult.contains(ConnectivityResult.none)) {
          Utils.toastMessage(message: "You are currently offline. Check your internet connection please".tr, icon: Icons.wifi_off);
        }
      } else {
        Utils.toastMessage(message: "Internet connection has been restored".tr, icon: Icons.wifi);
      }
    }
    isFirst = false ;

  }
}