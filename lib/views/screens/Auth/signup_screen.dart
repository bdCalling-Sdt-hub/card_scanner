import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Auth/forgot_password_screen.dart';
import 'package:card_scanner/views/screens/Auth/signin_screen.dart';
import 'package:card_scanner/views/screens/Auth/signup_otp_screen.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_text_field/custom_text_field.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 48.h, width: Get.width),

              ///<<<============= Logo ======================>>>
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 170.h,
                  width: 170.w,
                  child: SvgPicture.asset(
                    AppImages.logo,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              CustomText(
                text: AppStrings.signUpNOw,
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
              CustomText(
                text: AppStrings.fillTheDetails,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.black_400,
              ),

              ///<<<=============== Social Account Login =====================>>>
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 72.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: const ShapeDecoration(
                          shape: CircleBorder(side: BorderSide.none),
                          color: AppColors.black_400),
                      child: Center(
                          child: SvgPicture.asset(
                        AppIcons.fbIcon,
                        height: 25.h,
                        width: 25.w,
                      )),
                    ),
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: const ShapeDecoration(
                          shape: CircleBorder(side: BorderSide.none),
                          color: AppColors.black_400),
                      child: Center(
                          child: SvgPicture.asset(
                        AppIcons.googleIcon,
                        height: 25.h,
                        width: 25.w,
                      )),
                    ),
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: const ShapeDecoration(
                          shape: CircleBorder(side: BorderSide.none),
                          color: AppColors.black_400),
                      child: Center(
                          child: SvgPicture.asset(
                        AppIcons.linkedinIcon,
                        height: 25.h,
                        width: 25.w,
                      )),
                    ),
                  ],
                ),
              ),


              ///<<<==================== Name Field ============================>>>

              CustomTextField(
                textEditingController: authController.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.enterFullName.tr;
                  }
                  else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                hintText: AppStrings.name.tr,
                hintStyle: GoogleFonts.prompt(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_300),
                inputTextStyle: GoogleFonts.prompt(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.h,
                    color: AppColors.black_500),
                fieldBorderColor: AppColors.black_500,
                fieldBorderRadius: 8,
                isPrefixIcon: false,
              ),
              SizedBox(height: 8.h,),

              ///<<<====================Email Field=================================>>>

              CustomTextField(
                textEditingController: authController.emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.enterEmail.tr;
                  } else if (!AppStrings.emailRegexp.hasMatch("")) {
                    return AppStrings.enterValidEmail;
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
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
                height: 8.h,
              ),

              ///<<<=================Password field==============================>>>

              CustomTextField(
                textEditingController: authController.passwordController,
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
                hintText: AppStrings.password.tr,
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
                height: 8.h,
              ),

              ///<<<=================== Re-enter password field========================>>>

              CustomTextField(
                textEditingController:
                    authController.confirmPasswordController,
                validator: (value) {
                  if (value != authController.passwordController.text) {
                    return AppStrings.passDoesNotMatch.tr;
                  } else {
                    return null;
                  }
                },
                isPassword: true,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                hintText: AppStrings.confirmPassword.tr,
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

              SizedBox(height: 60.h,),

              ///<<<================== Sign In Texts =======================>>>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 CustomElevatedButton(
                   height: 42.h,
                   width: 158.w,
                   isFillColor: false,
                   onTap: () {
                     Get.to(SignInScreen());
                   },
                   borderRadius: 12,
                   borderColor: AppColors.black_500,
                   text: AppStrings.backToSignInBtn,
                   textColor: AppColors.black_500,
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                 ),
                 SizedBox(
                   height: 42.h, // Set the height
                   width: 74.w, // Set the width
                   child: ElevatedButton(
                     onPressed: () {
                       // Add your button's onPressed logic here
                       Get.to(SignupOtpScreen());
                       Get.snackbar("Otp sent to your email", "");
                     },
                     style: ButtonStyle(
                       backgroundColor: const MaterialStatePropertyAll(AppColors.black_500),
                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(12.0), // Set the radius
                         ),
                       ),
                     ),
                     child: SvgPicture.asset(AppIcons.rightArrow),
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
