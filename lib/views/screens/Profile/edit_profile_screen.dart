import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_icons.dart';
import 'IneerWidget/edit_card_style.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());
  List cardColorList = [
    AppColors.ashColor,
    AppColors.deepAshColor,
    AppColors.greenColor,
    AppColors.deepRedColor,
    AppColors.blackColor,
    AppColors.whitishColor
  ];

  final companyController = ValueNotifier<bool>(false);
  final profilePhotoController = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(
                        icon: Icons.arrow_back,
                        onTap: () {
                          Get.back();
                        },
                      ),
                      CustomText(
                        text: AppStrings.editProfile,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 30.w)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Row(
                    children: [
            
                      ///<<<=================== Card Information Button ===========>>>
            
                      GestureDetector(
                        onTap: () {
                          profileController.isStyle.value = false;
                          profileController.isInformation.value = true;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              color: profileController.isInformation.value
                                  ? AppColors.green_900
                                  : AppColors.transparentColor,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: AppColors.green_900)),
                          child: CustomText(
                            text: AppStrings.cardInformation,
                            color: profileController.isInformation.value
                                ? AppColors.whiteColor
                                : AppColors.black_500,
                          ),
                        ),
                      ),
                      Spacer(),
            
                      ///<<<===================== Card Style Button =============>>>
            
                      GestureDetector(
                        onTap: () {
                          profileController.isStyle.value = true;
                          profileController.isInformation.value = false;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: profileController.isStyle.value
                                  ? AppColors.green_900
                                  : AppColors.transparentColor,
                              border: Border.all(color: AppColors.green_900)),
                          child: CustomText(
                            text: AppStrings.cardStyle,
                            color: profileController.isStyle.value
                                ? AppColors.whiteColor
                                : AppColors.black_500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            
                ///<<<=================== Card Information =====================>>>
                if(profileController.isInformation.value)
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(AppImages.homePageLogo)),
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.green_100
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
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
                                                profileController.selectImageGallery();
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
                                                profileController.selectImageCamera();
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
                                      color: AppColors.black_500
                                  ),
                                  child: Icon(Icons.border_color_outlined, size: 20, color: AppColors.green_500,),
                                ),
                            ),
                        ),
                      ),
                      CustomText(
                        text: "${AppStrings.basicInfo}:",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green_900,
                      ),

                      ///<<<================ Full Name ========================>>>

                      TextFormField(
                        decoration: InputDecoration(
                            hintText: AppStrings.fullName,
                          hintStyle: TextStyle(
                            fontSize: 14
                          )
                        ),
                      ),
                      SizedBox(height: 12.h,),
            
                      CustomText(
                        text: "${AppStrings.contactInfo}:",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green_900,
                      ),

                      ///<<<=================== Mobile Number =================>>>

                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: AppStrings.mobileNumber,
                            hintStyle: TextStyle(
                                fontSize: 14
                            )
                        ),
                      ),

                      ///<<<================= Email Address ===================>>>

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppStrings.email,
                            hintStyle: TextStyle(
                                fontSize: 14
                            )
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      CustomText(
                        text: "${AppStrings.experience}:",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green_900,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: AppStrings.designation,
                            hintStyle: TextStyle(
                                fontSize: 14
                            )
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: AppStrings.companyName,
                            hintStyle: TextStyle(
                                fontSize: 14
                            )
                        ),
                      ),
                      SizedBox(height: 60.h,),
            
                      ///<<<================= Save and Preview Button =================>>>
            
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: CustomElevatedButton(
                          onTap: (){
                            Get.back();
                          },
                          width: Get.width,
                          height: 42.h,
                          text: AppStrings.saveAndPreview,
                          backgroundColor: AppColors.black_500,
                        ),
                      )
                    ],
                  ),
                ),
            
                ///<<<=================== Card Style =========================>>>
                if(profileController.isStyle.value)
                  EditCardStyle(cardColorList: cardColorList, companyController: companyController, profilePhotoController: profilePhotoController),
            
              ],
            ),
          ),
        );
      }),
    );
  }
}


