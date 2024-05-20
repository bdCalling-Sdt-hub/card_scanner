
import 'package:card_scanner/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../Profile/IneerWidget/custom_container_button.dart';

class RecommendNameCardScreen extends StatelessWidget {
  RecommendNameCardScreen({super.key});

  String recommendLink = "https://drive.google.com/drive/folders/12pj2lHcyCttzoLA6WVG0rhb_qhofQLow";

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

              QrImageView(
                data: recommendLink,
                version: QrVersions.auto,
                size: 200,
                gapless: false,
                // embeddedImage: FileImage(File(selectedContact.imageUrl)),
                embeddedImageStyle:
                QrEmbeddedImageStyle(size: Size(100, 100)),
                errorStateBuilder: (context, error) {
                  return Center(
                    child: Text(
                      "Oh! Something went wrong...".tr,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),

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
                      Share.share(recommendLink);
                    },
                    text: "Share Name Card".tr,
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
