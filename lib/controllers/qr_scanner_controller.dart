
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../utils/app_strings.dart';
import '../views/screens/CreateCard/create_edit_card_screen.dart';
import '../views/screens/QrCodeScanner/scan_qr_code_screen.dart';

class QrScannerController extends GetxController{

  Future<void> qrScanner()async {
    await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR)
        .then(
          (value) {
        try {
          String result = value.toString();
          if (result.isNotEmpty) {
            if (kDebugMode) {
              print('Scanned data: $result');
            }
            List<String> parts = result.split('/');
            String name = parts[0];
            String designation = parts[1];
            String companyName = parts[2];
            String email = parts[3];
            String phoneNumber = parts[4];
            String address = parts[5];

            StorageController.nameController.text = name;
            StorageController.designationController.text = designation;
            StorageController.companyController.text = companyName;
            StorageController.emailController.text = email;
            StorageController.phoneController.text = phoneNumber;
            StorageController.addressController.text = address;

            if (kDebugMode) {
              print("$name, $designation, $companyName, $email, $phoneNumber, $address");
            }
            // Now you can use this data as needed
            Get.to(CreateOrEditCardScreen(screenTitle: AppStrings.createCard))?.then((value) {
              result = "";
            },);

          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
    );
  }
}