

import 'package:get/get.dart';

import '../controllers/phone_storage_controller.dart';

class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => PhoneStorageController(), fenix: true);
  }
}