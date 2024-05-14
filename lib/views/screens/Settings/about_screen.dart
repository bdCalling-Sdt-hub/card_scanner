
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
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
                    text: AppStrings.aboutUs.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(height: 40.h),
              Center(child: Image.asset(AppImages.nameCardLogo, height:300.h)),
              SizedBox(height: 8.h),
              Divider(),

              CustomText(
                maxLines: 10,
                text: "At Name Card Scanner, we simplify business networking. Our app digitizes contacts effortlessly with advanced OCR tech, ensuring accuracy. Seamlessly integrate with Google Drive for secure storage and access anywhere. Customize tags for smart organization and share details with ease. Even offline, stay connected. Your privacy is our priority; we employ robust encryption. Embrace a clutter-free, digital approach to networking. Download Name Card Scanner now for seamless connectivity.",),

              SizedBox(height: 20.h),

            ],
          ),
        ),
      ),
    );
  }
}
