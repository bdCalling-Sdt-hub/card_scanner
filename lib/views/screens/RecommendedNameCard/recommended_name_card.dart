
import 'package:card_scanner/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

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
                    text: AppStrings.recommendNameCard,
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
                text: AppStrings.nameCardScanner,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: AppStrings.toInstallNameCardScanner,
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
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: AppColors.black_500,
                            borderRadius: BorderRadius.circular(12.r)
                        ),
                        child: Center(child: SvgPicture.asset(AppIcons.linkedinIcon)),
                      ),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: AppColors.black_500,
                            borderRadius: BorderRadius.circular(12.r)
                        ),
                        child: Center(child: SvgPicture.asset(AppIcons.fbIcon)),
                      ),
                      Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: AppColors.black_500,
                            borderRadius: BorderRadius.circular(12.r)
                        ),
                        child: Center(child: SvgPicture.asset(AppIcons.emailIcon, color: AppColors.green_50,)),
                      )
                    ],
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
