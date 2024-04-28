
import 'dart:io';

import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/phone_storage_controller.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class CreateOrEditCardScreen extends StatelessWidget {
  CreateOrEditCardScreen({super.key, required this.screenTitle});

  ProfileController profileController = Get.put(ProfileController());
  PhoneStorageController phoneStorageController = Get.put(PhoneStorageController());
  OCRCreateCardController ocrCreateCardController = Get.put(OCRCreateCardController());
  
  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<PhoneStorageController>(
          builder: (phoneStorageController) {
          return phoneStorageController.isLoading
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
                      onTap: (){Get.back();},
                      icon: Icons.arrow_back,
                    ),
                    CustomText(
                      text: screenTitle,
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
                        image: phoneStorageController.imagePath != null && phoneStorageController.imagePath!.isNotEmpty
                            ? DecorationImage(image: FileImage(File("${phoneStorageController.imagePath}")), fit: BoxFit.cover)
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
                                backgroundColor: AppColors.green_700,
                                content: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                  height: 100.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          phoneStorageController.getGalleryImage();
                                          Get.back();
                                        },
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: AppColors.green_600,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.image_outlined),
                                              CustomText(text: "Gallery", fontSize: 16,)
                                            ],
                                          ),),
                                      ),
                                      SizedBox(width: 8,),
                                      InkWell(
                                        onTap: () {
                                          // controller.selectImageCamera();
                                          Get.back();
                                        },
                                        child: Container(
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
                                              CustomText(text: "Camera", fontSize: 16,)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8,),
                                      InkWell(
                                        onTap: () {

                                        },
                                        child: Container(
                                          height: 70,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: AppColors.green_600,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(AppIcons.linkedinIcon, height: 20, width: 20, color: AppColors.black_500, ),
                                              CustomText(text: "LinkedIn", fontSize: 16,)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                  controller: phoneStorageController.nameController,
                  decoration: InputDecoration(
                      hintText: AppStrings.fullName,
                    hintStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  controller: phoneStorageController.designationController,
                  decoration: InputDecoration(
                      hintText: AppStrings.designation,
                      hintStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  controller: phoneStorageController.companyController,
                  decoration: InputDecoration(
                      hintText: AppStrings.companyName,
                      hintStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  controller: phoneStorageController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: AppStrings.email,
                      hintStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  controller: phoneStorageController.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: AppStrings.contactNumber,
                      hintStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  controller: phoneStorageController.addressController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: AppStrings.address,
                      hintStyle: TextStyle(color: AppColors.black_200)
                  ),
                ),
                SizedBox(height: 100.h,),

                ///<<<================ Done Button ============================>>>

                Align(
                  alignment: Alignment.centerRight,
                  child: CustomElevatedButton(
                    onTap:( ){
                      if(screenTitle == AppStrings.editCard){
                        phoneStorageController.updateContact();
                      }else{
                        phoneStorageController.addContact();
                      }
                      phoneStorageController.imagePath = "";
                      phoneStorageController.id = "";
                      phoneStorageController.nameController.text = "";
                      phoneStorageController.designationController.text = "";
                      phoneStorageController.companyController.text = "";
                      phoneStorageController.emailController.text = "";
                      phoneStorageController.phoneController.text = "";
                      phoneStorageController.addressController.text = "";
                      Get.toNamed(AppRoutes.allCardsScreen);
                      // Get.to(AllCardsScreen());
                    },
                    text: AppStrings.done,
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
