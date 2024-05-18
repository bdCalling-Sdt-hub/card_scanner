
import 'dart:io';

import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/ContactsScreen/contacts_screen.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../ContactsScreen/all_cards_screen.dart';

class CreateOrEditCardScreen extends StatelessWidget {
  CreateOrEditCardScreen({super.key, required this.screenTitle});

  StorageController storageController = Get.put(StorageController());
  OCRCreateCardController ocrCreateCardController = Get.put(OCRCreateCardController());
  
  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<StorageController>(
          builder: (storageController) {
          return storageController.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                      onTap: (){
                        if(screenTitle == AppStrings.createCardTitle){
                          Get.toNamed(AppRoutes.homeScreen);
                        }else{
                          Get.toNamed(AppRoutes.allCardsScreen);
                        }
                      },
                      icon: Icons.arrow_back,
                    ),
                    CustomText(
                      text: screenTitle.tr,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    SizedBox(width: 30),
                  ],
                ),

                ///<<<=============== Profile Picture =========================>>>
                SizedBox(height: 20.h),
                Stack(
                  children: [
                    Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: StorageController.imagePath != null && StorageController.imagePath!.isNotEmpty
                            ? DecorationImage(image: FileImage(File("${StorageController.imagePath}")), fit: BoxFit.cover)
                            : DecorationImage(fit: BoxFit.cover,image: AssetImage("assets/images/blankProfileImage.png")),
                      ),
                    ),

                    ///<<<================ Edit Icon ==========================>>>

                    Positioned(
                      bottom: 5.h,
                      right: 5.w,
                      child: InkWell(
                        onTap: (){
                          showDialog(context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(4.w),
                                backgroundColor: AppColors.green_700,
                                content: Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            storageController.getGalleryImage();
                                            Get.back();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: AppColors.green_600,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.image_outlined),
                                                CustomText(text: "Gallery".tr, fontSize: 16,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        InkWell(
                                          onTap: () {
                                            storageController.getCameraImage();
                                            Get.back();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: AppColors.green_600,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(AppIcons.ocrCameraIcon, height: 20, width: 20,),
                                                CustomText(text: "Camera".tr, fontSize: 16,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.linkedInWebViewScreen);
                                            showDialog(context: context, builder: (context) {
                                              return AlertDialog(content: SizedBox(
                                                height: 200,
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                        child: CustomBackButton(onTap: (){Get.back();})),
                                                    SizedBox(height: 20,),
                                                    CustomText(
                                                      fontSize: 16,
                                                      maxLines: 5,
                                                      text: "Google & Apple SignIn doesn't support in web view, So don't try".tr,
                                                    ),
                                                    CustomText(
                                                      fontSize: 18,
                                                      text: "'Continue with Google & Sign in with Apple'".tr,
                                                      maxLines: 3,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.green_900,
                                                    )
                                                  ],
                                                ),
                                              ),);
                                            },);
                                            // Get.snackbar("Google Sign In does not support web view, So don't try 'Continue with Google'".tr, "",
                                            //   duration: Duration(seconds: 3),
                                            //   colorText: AppColors.green_900,
                                            // );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: AppColors.green_600,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(AppIcons.linkedinIcon, height: 20, width: 20, color: AppColors.black_500, ),
                                                CustomText(text: "LinkedIn".tr, fontSize: 16,)
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.googleWebViewScreen);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: AppColors.green_600,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(AppIcons.googleColorfulIcon, height: 20, width: 20, color: AppColors.black_500, ),
                                                CustomText(text: "Google".tr, fontSize: 16,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.green_300
                          ),
                          child: Icon(Icons.border_color_outlined, size: 20),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20.h,),

                TextFormField(
                  controller: StorageController.nameController,
                  decoration: InputDecoration(
                      // hintText: AppStrings.fullName,
                    // hintStyle: TextStyle(color: AppColors.black_200),
                    labelText: AppStrings.fullName.tr,
                    labelStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 4.h,),
                TextFormField(
                  controller: StorageController.designationController,
                  decoration: InputDecoration(
                    labelText:  AppStrings.designation.tr,
                    labelStyle: TextStyle(color: AppColors.black_200),
                  ),
                ),
                SizedBox(height: 4.h,),
                TextFormField(
                  controller: StorageController.companyController,
                  decoration: InputDecoration(
                      labelText: AppStrings.companyName.tr,
                      labelStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 4.h,),
                TextFormField(
                  controller: StorageController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: AppStrings.email.tr,
                      labelStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 4.h,),
                TextFormField(
                  controller: StorageController.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: AppStrings.contactNumber.tr,
                      labelStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 4.h,),
                TextFormField(
                  controller: StorageController.addressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: AppStrings.address.tr,
                      labelStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 36.h,),

                ///<<<================ Done Button ============================>>>

                Align(
                  alignment: Alignment.centerRight,
                  child: CustomElevatedButton(
                    onTap:( ){
                      if(screenTitle == AppStrings.editCard){
                        storageController.updateContact();
                      }else{
                        storageController.addContact();
                      }
                      StorageController.imagePath = "";
                      storageController.id = "";
                      StorageController.nameController.text = "";
                      StorageController.designationController.text = "";
                      StorageController.companyController.text = "";
                      StorageController.emailController.text = "";
                      StorageController.phoneController.text = "";
                      StorageController.addressController.text = "";
                      Get.toNamed(AppRoutes.allCardsScreen);
                      // Get.to(AllCardsScreen());
                    },
                    text: AppStrings.done.tr,
                    backgroundColor: AppColors.black_500,
                    width: 120,
                    height: 42,
                  ),
                ),
              ],
            ),
          );
        },),
      ),
    );
  }
}
