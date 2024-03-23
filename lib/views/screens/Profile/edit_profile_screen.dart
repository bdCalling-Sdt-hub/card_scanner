import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
                    icon: Icons.arrow_back,
                      onTap: (){
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
              SizedBox(height: 50.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: AppColors.green_900)
                    ),
                    child: CustomText(
                      text: AppStrings.cardInformation,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: AppColors.green_900)
                    ),
                    child: CustomText(
                      text: AppStrings.cardStyle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
