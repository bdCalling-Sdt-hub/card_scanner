

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class QrScannerController extends GetxController{

  String qrText = "";

  Future<String> qrScanner()async {
    await BarcodeScanner.scan().then(
          (value) {
        try {
          String result = value.rawContent.toString();
          if (result.isNotEmpty) {
            if (kDebugMode) {
              print('Scanned data:===========================================>>> \n$result');
            }
            qrText = result;
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
    );
    return qrText;
  }
}