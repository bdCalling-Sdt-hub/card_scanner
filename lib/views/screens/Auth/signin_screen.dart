
import 'package:card_scanner/controllers/auth/sign_in_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/customButton/custom_elevated_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../../widgets/custom_text_field/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 4),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h, width: Get.width),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 150.h,
                  width: 150.w,
                  child: SvgPicture.asset(
                    AppImages.logo,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomText(
                text: AppStrings.signInNow,
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomText(
                text: AppStrings.signForExperience,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.black_400,
              ),
              SizedBox(height: 20.h,),

              ///<<<====================Email Field ============================>>>

              CustomTextField(
                textEditingController: signInController.emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.enterEmail.tr;
                  } else if (!AppStrings.emailRegexp.hasMatch("")) {
                    return AppStrings.enterValidEmail;
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                hintText: AppStrings.email,
                hintStyle: GoogleFonts.kumbhSans(
                    fontSize: 16.h,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_300),
                inputTextStyle: GoogleFonts.prompt(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.h,
                    color: AppColors.black_500),
                fieldBorderRadius: 8,
                isPrefixIcon: false,
                // prefixIcon: Icon(
                //   Icons.mail_outline,
                //   size: 24.h,
                //   color: AppColors.black_400,
                // ),
              ),
              SizedBox(
                height: 12.h,
              ),

              ///<<<=================Password field==============================>>>

              CustomTextField(
                textEditingController: signInController.passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppStrings.fieldCantBeEmpty.tr;
                  } else if (value.length < 8) {
                    return AppStrings.passMustContainBoth.tr;
                  } else if (!AppStrings.passRegExp.hasMatch(value)) {
                    return AppStrings.passMustContainBoth.tr;
                  } else {
                    return null;
                  }
                },
                isPassword: true,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                hintText: AppStrings.newPassword.tr,
                hintStyle: GoogleFonts.prompt(
                    fontSize: 16.h,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_300),
                inputTextStyle: GoogleFonts.prompt(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.h,
                    color: AppColors.black_500),
                fieldBorderRadius: 8,
                isPrefixIcon: false,
                suffixIconColor: AppColors.black_400,
                // prefixIcon: Icon(
                //   Icons.lock_outlined,
                //   size: 24.h,
                //   color: AppColors.black_400,
                // ),
              ),

              SizedBox(height: 140.h,),
              CustomElevatedButton(
                height: 50.h,
                width: Get.width,
                isFillColor: true,
                onTap: () {
                  Get.toNamed(AppRoutes.homeScreen);
                },
                borderRadius: 12,
                borderColor: AppColors.black_500,
                text: AppStrings.signInBtn,
                backgroundColor: AppColors.black_500,
                textColor: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppStrings.doNotHaveYouAccount,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.black_400,
                  ),
                  SizedBox(width: 8.w,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: CustomText(
                      text: AppStrings.signUp,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black_500,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
