import 'dart:io';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Profile/IneerWidget/custom_container_button.dart';
import 'package:card_scanner/views/screens/Profile/edit_profile_screen.dart';
import 'package:card_scanner/views/screens/Profile/share_profile_card_screen.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewECardScreen extends StatelessWidget {
  const ViewECardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                      }),
                  CustomText(
                    text: AppStrings.eCard,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w)
                ],
              ),
            ),
            SizedBox(height: 20.h),
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
                                color: PrefsHelper.colorIndex == 2? AppColors.green_700 : AppColors.green_50,
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
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(),
            ),
            SizedBox(height: 48.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                children: [
                  ///<<<=================== Edit Button ===================>>>

                  CustomContainerButton(
                    onTap: () {
                      Get.to(EditProfileScreen());
                    },
                    text: AppStrings.edit,
                    height: 48,
                    width: 110,
                    iconSize: 20,
                    fontSize: 16,
                    ifBorder: true,
                    backgroundColor: AppColors.black_500,
                    textColor: AppColors.black_500,
                    iconColor: AppColors.black_500,
                    farWidth: 8,
                    radius: 25,
                  ),
                  Spacer(),

                  ///<<<================= Share Card Button ================>>>

                  CustomContainerButton(
                    onTap: () {
                      Get.to(ShareProfileCardScreen());
                    },
                    text: AppStrings.shareCard,
                    ifImage: true,
                    svgIcon: AppIcons.sendIcon,
                    height: 48,
                    width: 180,
                    imageHeight: 20,
                    imageWidth: 20,
                    radius: 25,
                    fontSize: 16,
                    iconColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                    farWidth: 8,
                    backgroundColor: AppColors.black_500,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}