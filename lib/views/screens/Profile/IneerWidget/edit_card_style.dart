import 'dart:io';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/CustomBackButton/custom_back_button.dart';
import '../../../widgets/customText/custom_text.dart';

class EditCardStyle extends StatelessWidget {
  EditCardStyle({
    super.key,
  });

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            color: profileController.cardColorList[PrefsHelper.colorIndex],
            child: Stack(
              alignment: Alignment.center,
              children: [

                ///<<<================= Company Logo ================>>>
                Container(
                  height: 170.h,
                  width: 170.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: PrefsHelper.isLogoShow? DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(AppImages.nameCardLogo),
                        colorFilter: PrefsHelper.colorIndex == 3 || PrefsHelper.colorIndex == 4? ColorFilter.mode(
                          AppColors.green_500.withOpacity(0.65), // Adjust the color and opacity
                          BlendMode.srcATop,
                        ) : null,
                        opacity: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? 0.2 :  0.4) : null,
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
                              color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                            ),
                            CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              text: PrefsHelper.userDesignation,
                              fontSize: 16,
                              color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                            ),
                            CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              text: PrefsHelper.userCompany,
                              fontSize: 18,
                              color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
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
                            color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
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
                            icon: Icons.email_outlined,
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
                            color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
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
                            color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
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
                      image: PrefsHelper.isProfilePhotoShow? DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(
                            File(PrefsHelper.profileImagePath)),
                      ) : null,
                    ),
                  ),
                ),

              ],
            ),
          ),

          ///<<<=================== Background Color ====================>>>
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: CustomText(
              text: AppStrings.selectCardBackground.tr,
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
                itemCount: profileController.cardColorList.length,
                itemBuilder: (context, index) {
                  return Obx(() => GestureDetector(
                    onTap: () {
                      profileController.setColor(index: index);
                    },
                    child: Container(
                      width: 50,
                      margin: EdgeInsets.only(right: 12.w, bottom: 12.h),
                      // padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: profileController.cardColorList[index]),
                      child: profileController.selectedColorIndex.value == index
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
              text: AppStrings.moreSelect.tr,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              color: AppColors.black_300,
            ),
          ),

          ///<<<================== Display Company Logo======================>>>

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
                  text: AppStrings.displayCompany.tr,
                  fontSize: 16,
                ),
                Spacer(),
                AdvancedSwitch(
                  initialValue: PrefsHelper.isLogoShow,
                  onChanged: (value) {
                    profileController.setCompanyLogo(value: value);
                  },
                  thumb: ValueListenableBuilder(
                    valueListenable: profileController.companyLogoController,
                    builder: (_, value, __) {
                      return Icon(
                        value ? Icons.circle : Icons.circle_outlined,
                        size: 16,
                      );
                    },
                  ),
                  controller: profileController.companyLogoController,
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
                  text: AppStrings.displayProfilePhoto.tr,
                  fontSize: 16,
                ),
                Spacer(),
                AdvancedSwitch(
                  initialValue: PrefsHelper.isProfilePhotoShow,
                  onChanged: (value) {
                    profileController.setProfilePhoto(value: value);
                  },
                  thumb: ValueListenableBuilder(
                    valueListenable: profileController.profilePhotoController,
                    builder: (_, value, __) {
                      return Icon(
                        value ? Icons.circle : Icons.circle_outlined,
                        size: 16,
                      );
                    },
                  ),
                  controller: profileController.profilePhotoController,
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

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 42.w),
          //   child: CustomElevatedButton(
          //     onTap: () {
          //       Get.back();
          //     },
          //     width: Get.width,
          //     height: 42.h,
          //     text: AppStrings.preview,
          //     backgroundColor: AppColors.black_500,
          //   ),
          // )
        ],
      );
    },);
  }
}
