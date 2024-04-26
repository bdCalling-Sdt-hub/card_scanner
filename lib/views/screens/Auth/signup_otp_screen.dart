



import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Auth/reset_password_screen.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Helpers/prefs_helper.dart';
import '../../../core/routes/app_routes.dart';

class SignupOtpScreen extends StatelessWidget {
  SignupOtpScreen({super.key});

 AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
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
            Image.asset(AppImages.otpScreenImg),
            SizedBox(height: 24.h,),
            Row(
              children: [
                const Icon(Icons.arrow_back_ios, size: 16,),
                CustomText(
                  text: AppStrings.enterOtpCode,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_500,
                )
              ],
            ),

            SizedBox(height: 32.h,),

            ///<<<====================Otp pin code field==========================>>>
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: PinCodeTextField(
                autoDisposeControllers: false,
                // controller: controller.otpController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType:
                const TextInputType.numberWithOptions(signed: true),
                textInputAction: TextInputAction.done,
                cursorColor: Colors.black,
                appContext: (context),
                validator: (value) {
                  if (value!.length != 6) {
                    return "Please enter the OTP code.";
                  }
                },
                autoFocus: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(4),
                  fieldHeight: 48.h,
                  fieldWidth: 48.w,
                  activeFillColor: AppColors.primaryColor,
                  selectedFillColor: AppColors.primaryColor,
                  inactiveFillColor: AppColors.primaryColor,
                  borderWidth: 0.1,
                  errorBorderColor: AppColors.black_400,
                  selectedColor: AppColors.black_400,
                  activeColor: AppColors.black_400,
                  inactiveColor: AppColors.black_400,
                ),
                length: 6,
                enableActiveFill: true,
              ),
            ),

            Align(
                alignment: Alignment.centerLeft,
                child: CustomText(text: AppStrings.didNotReceiveOtp,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("00:29"),
                CustomElevatedButton(
                  onTap: (){
                    Get.snackbar("OTp is resent", "");
                  },
                  text: AppStrings.resendCode,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  isFillColor: false,
                  borderColor: AppColors.black_500,
                  textColor: AppColors.black_500,
                  height: 32.h,
                  width: 112.w,
                )
              ],
            ),
          ],
        ),
      ),

      ///<<<================== Submit Button ======================>>>

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: CustomElevatedButton(
          onTap: (){
            Get.toNamed(AppRoutes.homeScreen);
            Get.snackbar("Your new account has been created", "");
            authController.ifSignIn.value = true;
            PrefsHelper.setBool(AppStrings.signedIn, true);
            PrefsHelper.signedIn = true;
          },
          text: AppStrings.submitBtn,
          backgroundColor: AppColors.black_500,
          isFillColor: true,
        ),
      ),
    );
  }
}
