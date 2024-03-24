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
import 'package:get/get.dart';

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
                      text: AppStrings.myProfile,
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
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 4.h),
                        decoration: BoxDecoration(
                            color: profileController.isInformation.value
                                ? AppColors.green_500
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
                        PrefsHelper.setBool("isInformation", false);
                        PrefsHelper.setBool("isStyle", true).then((value) =>
                            profileController.isStyle.value =
                                PrefsHelper.isStyle);
                        profileController.isStyle.value = true;
                        print("${profileController.isStyle.value}");
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
              Column(
                children: [
                  Container(
                    height: 42.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.green_100
                    ),
                  )
                ],
              ),


              ///<<<=================== Card Style =========================>>>
               EditCardStyle(cardColorList: cardColorList, companyController: companyController, profilePhotoController: profilePhotoController),

            ],
          ),
        );
      }),
    );
  }
}


