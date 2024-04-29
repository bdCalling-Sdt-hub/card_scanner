

import 'package:get/get.dart';

import '../controllers/ocr_create_card_controller.dart';
import '../controllers/storage_controller.dart';

class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => StorageController(), fenix: true);
    Get.lazyPut(() => OCRCreateCardController(), fenix: true);
  }
}