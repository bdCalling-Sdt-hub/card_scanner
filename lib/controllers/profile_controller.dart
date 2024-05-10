
import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_colors.dart';

class ProfileController extends GetxController{


  RxBool isStyle = false.obs;
  RxBool isInformation = true.obs;

  RxInt selectedColorIndex = 50.obs;

  String? image;
  String? cameraImage;
  List captureImage = [];

  List cardColorList = [
    AppColors.ashColor,
    AppColors.deepAshColor,
    AppColors.greenColor,
    AppColors.deepRedColor,
    AppColors.blackColor,
    AppColors.whitishColor
  ];

  final companyLogoController = ValueNotifier<bool>(false);

  final profilePhotoController = ValueNotifier<bool>(false);

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

  setColor({required int index}){
    PrefsHelper.colorIndex = index;
    PrefsHelper.setInt("colorIndex", index);
    update();
    selectedColorIndex.value = PrefsHelper.colorIndex;
  }
  setCompanyLogo({required bool value}){
    PrefsHelper.isLogoShow = value;
    PrefsHelper.setBool("isLogoShow", value);
    update();
  }

  setProfilePhoto({required bool value}){
    PrefsHelper.isProfilePhotoShow = value;
    PrefsHelper.setBool("isProfilePhotoShow", value);
    update();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    selectedColorIndex.value = PrefsHelper.colorIndex;
    super.onInit();
  }

}