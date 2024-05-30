
import 'dart:io';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/Services/image_bb_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_colors.dart';

class ProfileController extends GetxController{


  RxBool isStyle = false.obs;
  RxBool isInformation = true.obs;
  RxBool isTapped = false.obs;
  RxBool isLandPhone = false.obs;
  RxBool isFax = false.obs;
  RxBool isWebsite = false.obs;

  List formFieldsList = [
    "Land Phone".tr,
    "Fax".tr,
    "Website".tr,
  ];

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

  final companyLogoController = ValueNotifier<bool>(PrefsHelper.isLogoShow);

  final profilePhotoController = ValueNotifier<bool>(PrefsHelper.isProfilePhotoShow);

  TextEditingController nameController = TextEditingController(text: PrefsHelper.userName);
  TextEditingController designationController = TextEditingController(text: PrefsHelper.userDesignation);
  TextEditingController companyController = TextEditingController(text: PrefsHelper.userCompany);
  TextEditingController emailController = TextEditingController(text: PrefsHelper.userMail);
  TextEditingController phoneController = TextEditingController(text: PrefsHelper.userPhone);
  TextEditingController addressController = TextEditingController(text: PrefsHelper.userAddress);
  TextEditingController telephoneController = TextEditingController(text: PrefsHelper.userTelephone);
  TextEditingController faxController = TextEditingController(text: PrefsHelper.userFax);
  TextEditingController websiteController = TextEditingController(text: PrefsHelper.userWebsite);

  ImageBBService imageBBService = ImageBBService();
  bool isLoading = false;

  selectImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages != null) {
      isLoading = true;
      update();
      image = await imageBBService.uploadImage(imageFile: File(getImages.path));
      PrefsHelper.profileImagePath = image!;
      isLoading = false;
      update();
      PrefsHelper.setString("profileImagePath", image);
      update();
    }
  }

  selectImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages != null) {
      isLoading = true;
      update();
      image = await imageBBService.uploadImage(imageFile: File(getImages.path));
      PrefsHelper.profileImagePath = image!;
      isLoading = false;
      update();
      PrefsHelper.setString("profileImagePath", image);
      update();
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