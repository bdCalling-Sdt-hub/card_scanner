
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{


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

    }
  }

}