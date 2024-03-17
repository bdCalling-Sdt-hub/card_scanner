
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterpriseScreen extends StatelessWidget {
  const EnterpriseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green_900,
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu),
                        Icon(Icons.language),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Image.asset(AppImages.enterpriseImage)),
                    CustomText(
                      text: AppStrings.nameCardScanner.toUpperCase(),
                      color: AppColors.black_700,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                      child: CustomText(
                        maxLines: 4,
                        text: AppStrings.nameCardScannerEfficientlyDigitizes,
                        color: AppColors.black_600,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    CustomElevatedButton(
                      width: 165.h,
                      height: 42.w,
                      onTap: (){},
                      text: AppStrings.tryItFree,
                      backgroundColor: AppColors.black_500,
                      textColor: AppColors.green_50,
                    )

                  ],
                ),
              ),
              Container(
                color: AppColors.green_50,
                child: Column(
                  children: [

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
