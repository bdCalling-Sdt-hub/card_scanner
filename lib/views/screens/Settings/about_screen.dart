
import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    text: AppStrings.about,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: (){

                },
                child: CustomText(
                  text: AppStrings.followUs,
                  fontSize: 16,
                  color: AppColors.black_500,
                ),
              ),
              SizedBox(height: 8.h),
              Divider(),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: (){

                },
                child: CustomText(
                  text: AppStrings.contactUs,
                  fontSize: 16,
                  color: AppColors.black_500,
                ),
              ),
              SizedBox(height: 8.h),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
