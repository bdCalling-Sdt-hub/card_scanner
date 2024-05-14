
import 'package:card_scanner/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../Profile/IneerWidget/custom_container_button.dart';

class RecommendNameCardScreen extends StatelessWidget {
  const RecommendNameCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.arrow_back,
                  ),
                  CustomText(
                    maxLines: 2,
                    text: AppStrings.recommendNameCard.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30),
                ],
              ),

              SizedBox(height: 40.h),

              Image.asset(AppImages.qr1Img, height: 220.h, width: 220.w,),

              SizedBox(height: 24.h),

              CustomText(
                text: AppStrings.nameCardScanner.tr,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: AppStrings.toInstallNameCardScanner.tr,
                fontSize: 16,
              ),

              SizedBox(height: 16.h),
              Container(
                width: Get.width,
                height: 90.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.green_100
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 15.h),
                  child: CustomContainerButton(
                    onTap: () {
                      // screenShotHelper.captureAndSaveImage(screenshotController);
                      Share.share("this is test share");
                    },
                    text: AppStrings.shareCard.tr,
                    ifImage: true,
                    svgIcon: AppIcons.sendIcon,
                    imageHeight: 20,
                    imageWidth: 20,
                    radius: 25,
                    fontSize: 16,
                    iconColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                    farWidth: 8,
                    backgroundColor: AppColors.black_500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
