
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../utils/app_strings.dart';
import '../views/screens/CreateCard/create_edit_card_screen.dart';

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
              print('Scanned data: $result');
              qrText = result;
            }
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