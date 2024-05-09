
import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{


  RxBool isStyle = false.obs;
  RxBool isInformation = true.obs;

  RxInt selectedColor = 50.obs;
  String? image;
  String? cameraImage;
  List captureImage = [];

  TextEditingController nameController = TextEditingController(text: PrefsHelper.userName);
  TextEditingController designationController = TextEditingController(text: PrefsHelper.userDesignation);
  TextEditingController companyController = TextEditingController(text: PrefsHelper.userCompany);
  TextEditingController emailController = TextEditingController(text: PrefsHelper.userMail);
  TextEditingController phoneController = TextEditingController(text: PrefsHelper.userPhone);
  TextEditingController addressController = TextEditingController(text: PrefsHelper.userAddress);

  selectImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages != null) {
      image = getImages.path;
      PrefsHelper.profileImagePath = getImages.path;
      update();
      PrefsHelper.setString("profileImagePath", getImages.path);
      update();
      Get.back();
    }
  }

  selectImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages != null) {
      image = getImages.path;
      PrefsHelper.profileImagePath = getImages.path;
      update();
      PrefsHelper.setString("profileImagePath", getImages.path);
      update();
      Get.back();
    }
  }

}