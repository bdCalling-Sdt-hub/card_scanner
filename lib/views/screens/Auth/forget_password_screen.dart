
import 'package:card_scanner/controllers/auth/forgotPasswordController.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60.h, width: Get.width),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomText(
                    text: AppStrings.signUpNOw,
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomText(
                    text: AppStrings.fillTheDetails,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.black_400,
                  ),


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

                  ///<<<================= Contact Number field==============================>>>
                  CustomText(

                  ),
                  CustomTextField(
                    // textEditingController: forgotPasswordController.passwordController,
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
                  SizedBox(
                    height: 24.h,
                  ),

                  SizedBox(height: 8.h),
                  SizedBox(height: 54.h,),
                  CustomElevatedButton(
                    height: 42.h,
                    width: 158.w,
                    isFillColor: false,
                    onTap: () {},
                    borderRadius: 12,
                    borderColor: AppColors.black_500,
                    text: AppStrings.getOtp,
                    textColor: AppColors.black_500,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            ),
          ),
    );
  }
}
