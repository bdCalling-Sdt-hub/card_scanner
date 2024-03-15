
import 'package:card_scanner/controllers/auth/forgotPasswordController.dart';
import 'package:card_scanner/views/screens/Auth/otp_screen.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/customButton/custom_elevated_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
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
                  text: AppStrings.forgotPassword,
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
                    text: AppStrings.enterYourEmail,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.black_400,
                  ),
                ),
                SizedBox(height: 24.h,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: AppStrings.email,
                    color: AppColors.black_500,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h,),

                ///<<<====================Email Field=================================>>>

                CustomTextField(
                  // textEditingController: signUpController.emailController,
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
                  height: 24.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: AppColors.black_900,
                      width: 135.w,
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: CustomText(
                        text: AppStrings.or,
                        color: AppColors.black_500,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      color: AppColors.black_900,
                      width: 135.w,
                      height: 1.h,
                    )
                  ],
                ),

                ///<<<================= Contact Number field==============================>>>
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: AppStrings.contactNumber,
                    color: AppColors.black_500,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h,),

                CustomTextField(
                  // textEditingController: forgotPasswordController.passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppStrings.fieldCantBeEmpty.tr;
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  hintText: AppStrings.enterMobileNumber.tr,
                  hintStyle: GoogleFonts.prompt(
                      fontSize: 16.h,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_300),
                  inputTextStyle: GoogleFonts.prompt(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.h,
                      color: AppColors.black_500),
                  fieldBorderRadius: 8,
                  // prefixIcon: Icon(
                  //   Icons.lock_outlined,
                  //   size: 24.h,
                  //   color: AppColors.black_400,
                  // ),
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
            Get.to(OtpScreen());
          },
          borderRadius: 12,
          backgroundColor: AppColors.black_500,
          text: AppStrings.getOtp,
          textColor: AppColors.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
