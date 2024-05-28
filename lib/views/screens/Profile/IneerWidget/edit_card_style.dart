import 'dart:io';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/CustomBackButton/custom_back_button.dart';
import '../../../widgets/customButton/custom_elevated_button.dart';
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
          Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  color: profileController.cardColorList[PrefsHelper.colorIndex],
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [

                  ///<<<================= Name card Logo ================>>>
                  Positioned(
                    top: 150,
                    child: Container(
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
                            opacity: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? 0.15 :  0.4) : null,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ///<<<================= Profile Picture ================>>>
                      SizedBox(height: 16.h),
                      Container(
                        height: 150.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: PrefsHelper.isProfilePhotoShow? DecorationImage(
                            fit: BoxFit.fill,
                            image: FileImage(
                                File(PrefsHelper.profileImagePath)),
                          ) : null,
                        ),
                      ),

                      Padding(
                        padding:
                        EdgeInsets.only(left: 32.w, top: 16.h, bottom: 16.h),
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
                                    text: profileController.nameController.text,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                                  ),
                                  CustomText(
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    text: profileController.designationController.text,
                                    fontSize: 16,
                                    fontWeight:  FontWeight.w500,
                                    color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                                  ),
                                  CustomText(
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    text: profileController.companyController.text,
                                    fontSize: 18,
                                    fontWeight:  FontWeight.w500,
                                    color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            customInfoRow(infoIcon: Icons.phone_iphone_outlined, infoText: profileController.phoneController.text),
                            SizedBox(
                              height: 4.h,
                            ),
                            customInfoRow(infoIcon: Icons.call, infoText: profileController.telephoneController.text),
                            SizedBox(
                              height: 4.h,
                            ),
                            customInfoRow(infoIcon: Icons.fax, infoText: profileController.faxController.text),
                            SizedBox(
                              height: 4.h,
                            ),
                            customInfoRow(infoIcon: Icons.email_outlined, infoText: profileController.emailController.text),
                            SizedBox(
                              height: 4.h,
                            ),
                            customInfoRow(infoIcon: Icons.language_outlined ,infoText: profileController.websiteController.text),
                            SizedBox(
                              height: 4.h,
                            ),
                            customInfoRow(infoIcon: Icons.location_on_outlined, infoText: profileController.addressController.text)
                          ],
                        ),
                      ),
                    ],
                  )

                ],
              ),
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
                  text: "Display name card logo".tr,
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


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.w),
            child: CustomElevatedButton(
              onTap: (){
                PrefsHelper.userName = profileController.nameController.text;
                PrefsHelper.userMail = profileController.emailController.text;
                PrefsHelper.userPhone = profileController.phoneController.text;
                PrefsHelper.userDesignation = profileController.designationController.text;
                PrefsHelper.userCompany = profileController.companyController.text;
                PrefsHelper.userAddress = profileController.addressController.text;
                PrefsHelper.setString("userName", profileController.nameController.text);
                PrefsHelper.setString("userMail", profileController.emailController.text);
                PrefsHelper.setString("userPhone", profileController.phoneController.text);
                PrefsHelper.setString("userDesignation", profileController.designationController.text);
                PrefsHelper.setString("userCompany", profileController.companyController.text);
                PrefsHelper.setString("userAddress", profileController.addressController.text);

                Get.offAllNamed(AppRoutes.profileScreen);
              },
              width: Get.width,
              height: 42.h,
              text: AppStrings.saveAndPreview.tr,
              backgroundColor: AppColors.black_500,
            ),
          ),
          SizedBox(height: 40.h,),

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

  Row customInfoRow({required IconData infoIcon, required String infoText}) {
    return Row(
                            children: [
                              infoText.isEmpty? SizedBox() : CustomBackButton(
                                onTap: () {},
                                icon: infoIcon,
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
                                text: infoText,
                                color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                                fontSize: 18,
                                fontWeight:  FontWeight.w500,
                              )
                            ],
                          );
  }
}
