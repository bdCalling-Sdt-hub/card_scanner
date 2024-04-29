
import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{

  OCRCreateCardController ocrCreateCardController = Get.find<OCRCreateCardController>();

  RxBool isStyle = false.obs;
  RxBool isInformation = true.obs;

  RxInt selectedColor = 50.obs;
  String? image;
  String? cameraImage;
  List captureImage = [];

  selectImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages != null) {
      image = getImages.path;
      update();
    }
  }

  selectImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages != null) {
      cameraImage = getImages.path;
      captureImage.add(cameraImage);
      update();
      ocrCreateCardController.processImage(cameraImage!);

    }
  }

}