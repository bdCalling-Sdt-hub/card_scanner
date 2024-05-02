

import 'package:card_scanner/controllers/payment_controller.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/ocr_create_card_controller.dart';
import '../controllers/qr_scanner_controller.dart';
import '../controllers/storage_controller.dart';

class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => StorageController(), fenix: true);
    Get.lazyPut(() => OCRCreateCardController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => QrScannerController(), fenix: true);
  }
}