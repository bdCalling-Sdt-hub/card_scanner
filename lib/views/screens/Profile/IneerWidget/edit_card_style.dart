import 'dart:io';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/CustomBackButton/custom_back_button.dart';
import '../../../widgets/customButton/custom_elevated_button.dart';
import '../../../widgets/customText/custom_text.dart';
import 'profile_image.dart';

class EditCardStyle extends StatelessWidget {
  EditCardStyle({
    super.key,
    required this.cardColorList,
    required this.companyController,
    required this.profilePhotoController,
  });

  final List cardColorList;
  final ValueNotifier<bool> companyController;
  final ValueNotifier<bool> profilePhotoController;

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          color: AppColors.black_300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 170.h,
                width: 170.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AppImages.nameCardLogo),
                      opacity: 0.5),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 32.w, top: 32.h, bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            text: PrefsHelper.userName,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.green_50,
                          ),
                          CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            text: PrefsHelper.userDesignation,
                            color: AppColors.green_50,
                          ),
                          CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            text: PrefsHelper.userCompany,
                            fontSize: 18,
                            color: AppColors.green_50,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        CustomBackButton(
                          onTap: () {},
                          icon: Icons.phone_iphone_outlined,
                          radius: 100,
                          color: AppColors.black_500,
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: PrefsHelper.userPhone,
                          color: AppColors.green_500,
                          fontSize: 18,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        CustomBackButton(
                          onTap: () {},
                          icon: Icons.attach_email_outlined,
                          radius: 100,
                          color: AppColors.black_500,
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: PrefsHelper.userMail,
                          color: AppColors.green_500,
                          fontSize: 18,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        CustomBackButton(
                          onTap: () {},
                          icon: Icons.location_on_outlined,
                          radius: 100,
                          color: AppColors.black_500,
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        CustomText(
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          text: PrefsHelper.userAddress,
                          color: AppColors.green_500,
                          fontSize: 18,
                        )
                      ],
                    )
                  ],
                ),
              ),

              ///<<<================= Profile Picture ================>>>

              Positioned(
                top: 15,
                right: 20,
                child: Container(
                  height: 130.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: PrefsHelper.profileImagePath.isEmpty
                        ? DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AppImages.blankProfileImage),
                    )
                        : DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(
                          File(PrefsHelper.profileImagePath)),
                    ),
                  ),
                ),
              ),

              ///<<<================= Company Logo ================>>>
            ],
          ),
        ),

        ///<<<=================== Background Color ====================>>>
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: CustomText(
            text: AppStrings.selectCardBackground,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SizedBox(
            width: Get.width,
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cardColorList.length,
              itemBuilder: (context, index) {
                return Obx(() => GestureDetector(
                      onTap: () {
                        profileController.selectedColor.value = index;
                      },
                      child: Container(
                        width: 50,
                        margin: EdgeInsets.only(right: 12.w, bottom: 12.h),
                        // padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: cardColorList[index]),
                        child: profileController.selectedColor.value == index
                            ? Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: AppColors.green_500,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                      child: Icon(
                                    Icons.check,
                                    size: 16,
                                  )),
                                ),
                              )
                            : null,
                      ),
                    ));
              },
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomText(
            text: AppStrings.moreSelect,
            fontSize: 16,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Divider(
            color: AppColors.black_300,
          ),
        ),

        ///<<<================== Display Company ======================>>>

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 54.h,
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.green_600),
          child: Row(
            children: [
              CustomText(
                text: AppStrings.displayCompany,
                fontSize: 16,
              ),
              Spacer(),
              AdvancedSwitch(
                thumb: ValueListenableBuilder(
                  valueListenable: companyController,
                  builder: (_, value, __) {
                    return Icon(
                      value ? Icons.circle : Icons.circle_outlined,
                      size: 16,
                    );
                  },
                ),
                controller: companyController,
                activeColor: AppColors.green_900,
                inactiveColor: AppColors.black_200,
                borderRadius: BorderRadius.all(const Radius.circular(15)),
                width: 40.0,
                height: 22.0,
                enabled: true,
                disabledOpacity: 0.5,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),

        ///<<<================== Display Profile Photo =================>>>

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          height: 54.h,
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColors.green_600),
          child: Row(
            children: [
              CustomText(
                text: AppStrings.displayProfilePhoto,
                fontSize: 16,
              ),
              Spacer(),
              AdvancedSwitch(
                thumb: ValueListenableBuilder(
                  valueListenable: profilePhotoController,
                  builder: (_, value, __) {
                    return Icon(
                      value ? Icons.circle : Icons.circle_outlined,
                      size: 16,
                    );
                  },
                ),
                controller: profilePhotoController,
                activeColor: AppColors.green_900,
                inactiveColor: AppColors.black_200,
                borderRadius: BorderRadius.all(const Radius.circular(15)),
                width: 40.0,
                height: 22.0,
                enabled: true,
                disabledOpacity: 0.5,
              ),
            ],
          ),
        ),

        SizedBox(height: 48.h),

        ///<<<================= Save and Preview Button =================>>>

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.w),
          child: CustomElevatedButton(
            onTap: () {
              Get.back();
            },
            width: Get.width,
            height: 42.h,
            text: AppStrings.saveAndPreview,
            backgroundColor: AppColors.black_500,
          ),
        )
      ],
    );
  }
}
