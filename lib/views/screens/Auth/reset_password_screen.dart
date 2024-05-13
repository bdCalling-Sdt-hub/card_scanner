
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/customButton/custom_elevated_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../../widgets/custom_text_field/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 32.h,
                  width: 32.w,
                  decoration: BoxDecoration(
                      color: AppColors.black_400,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: const Icon(Icons.arrow_back_ios_rounded, color: AppColors.whiteColor, size: 14,),
                ),
              ),
            ),
            SizedBox(height: 54.h, width: Get.width),
            CustomText(
              text: AppStrings.resetPassword.tr,
              fontWeight: FontWeight.w600,
              fontSize: 28,
              color: AppColors.black_500,
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: CustomText(
                maxLines: 2,
                text: AppStrings.passwordLength.tr,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.black_400,
              ),
            ),
            SizedBox(height: 32.h,),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: AppStrings.password.tr,
                color: AppColors.black_500,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(
              height: 8.h,
            ),

            ///<<<=================Password field==============================>>>

            CustomTextField(
              // textEditingController: signUpController.passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.fieldCantBeEmpty.tr;
                } else if (value.length < 6) {
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
            SizedBox(
              height: 16.h,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text: AppStrings.confirmPassword.tr,
                color: AppColors.black_500,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),

            ///<<<=================== Re-enter password field========================>>>

            CustomTextField(
              // textEditingController: signUpController.confirmPasswordController,
              validator: (value) {
                if (value != "signUpController.passwordController.text") {
                  return AppStrings.passDoesNotMatch.tr;
                } else {
                  return null;
                }
              },
              isPassword: true,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              hintText: AppStrings.confirmNewPassword.tr,
              hintStyle: GoogleFonts.prompt(
                  fontSize: 16.h,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_300),
              inputTextStyle: GoogleFonts.prompt(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.h,
                  color: AppColors.black_500),
              fieldBorderColor: AppColors.black_400,
              fieldBorderRadius: 8,
              isPrefixIcon: false,
              suffixIconColor: AppColors.black_400,
              // prefixIcon: Icon(
              //   Icons.lock_outlined,
              //   size: 24.h,
              //   color: AppColors.black_400,
              // ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              height: 24.h,
            ),

            SizedBox(height: 8.h),
            SizedBox(height: 54.h,),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: CustomElevatedButton(
          height: 50.h,
          width: Get.width,
          isFillColor: true,
          onTap: () {
            Get.toNamed(AppRoutes.homeScreen);
            Get.snackbar("Password reset successfully".tr, "");
          },
          borderRadius: 12,
          backgroundColor: AppColors.black_500,
          text: AppStrings.resetBtn.tr,
          textColor: AppColors.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
