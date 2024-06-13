
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';


class QrScannerController extends GetxController{

  String qrText = "";

  Future<String> qrScanner()async {
    await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR)
        .then(
          (value) {
        try {
          String result = value.toString();
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