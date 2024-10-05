
import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/customButton/custom_elevated_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../../widgets/custom_text_field/custom_text_field.dart';
import 'forgot_password_screen.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  AuthController authController = Get.put(AuthController());
  StorageController storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: authController.ifSignIn.value? BottomNavBar(currentIndex: 4) : null,
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
                text: AppStrings.signInNow.tr,
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomText(
                text: AppStrings.signForExperience.tr,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.black_400,
              ),
              SizedBox(height: 20.h,),

              ///<<<====================Email Field ============================>>>

              CustomTextField(
                textEditingController: authController.emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.enterEmail.tr;
                  } else if (!AppStrings.emailRegexp.hasMatch("")) {
                    return AppStrings.enterValidEmail.tr;
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                hintText: AppStrings.email.tr,
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
                textEditingController: authController.passwordController,
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

              SizedBox(height: 8.h,),

              ///<<<================ Forgot Password ==========================>>>

              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: CustomText(
                    text: AppStrings.forgotPassword.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.black_400,
                  ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Obx(
              //           () => Column(
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               authController.isChecked.value =
              //               !authController.isChecked.value;
              //             },
              //             child: Row(
              //               children: [
              //                 Container(
              //                   width: 20.w,
              //                   height: 20.h,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(4.r),
              //                     border:
              //                     Border.all(color: AppColors.black_400),
              //                     color: authController.isChecked.value
              //                         ? AppColors.black_400
              //                         : AppColors.primaryColor,
              //                   ),
              //                   child: authController.isChecked.value
              //                       ? Center(
              //                     child: SvgPicture.asset(
              //                         AppIcons.checkMark,
              //                         fit: BoxFit.contain,
              //                         height: 10,
              //                         width: 10),
              //                   )
              //                       : const Text(""),
              //                   // child: Checkbox(
              //                   //   autofocus: false,
              //                   //   activeColor: AppColors.black_400,
              //                   //   side: const BorderSide(color: AppColors.black_400),
              //                   //   checkColor: AppColors.whiteColor,
              //                   //   value: signUpController.isChecked.value,
              //                   //   onChanged: (value) {
              //                   //     signUpController.isChecked.value = value!;
              //                   //   },
              //                   // ),
              //                 ),
              //                 SizedBox(
              //                   width: 2.w,
              //                 ),
              //                 CustomText(
              //                   text: AppStrings.rememberMe,
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 16,
              //                   color: AppColors.black_400,
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         Get.to(ForgotPasswordScreen());
              //       },
              //       child: CustomText(
              //         text: AppStrings.forgotPassword,
              //         fontWeight: FontWeight.w500,
              //         fontSize: 16,
              //         color: AppColors.black_400,
              //       ),
              //     )
              //   ],
              // ),

              SizedBox(height: 120.h,),

              ///<<<========================== Sign In Button ================>>>

              GetBuilder<AuthController>(builder: (authController) {
                return authController.isLoading? Center(child: CircularProgressIndicator()):CustomElevatedButton(
                  height: 50.h,
                  width: Get.width,
                  isFillColor: true,
                  onTap: () {
                    authController.signInRepo();
                    authController.ifSignIn.value = true;
                    PrefsHelper.setBool(AppStrings.signedIn, true);
                    PrefsHelper.signedIn = true;
                    storageController.loadContacts();
                  },
                  borderRadius: 12,
                  borderColor: AppColors.black_500,
                  text: AppStrings.signInBtn.tr,
                  backgroundColor: AppColors.black_500,
                  textColor: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                );
              },),
              SizedBox(height: 8.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: AppStrings.doNotHaveYouAccount.tr,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.black_400,
                  ),
                  SizedBox(width: 8.w,),

                  ///<<<================ Sign up Text =====================>>>

                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: CustomText(
                      text: AppStrings.signUp.tr,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black_500,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.h,),
              Align(
                alignment: Alignment.centerRight,

                ///<<<================== Skip Button =====================>>>

                child: CustomElevatedButton(

                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  borderRadius: 26.r,
                  isFillColor: false,
                  width: 75.w,
                  height: 40.h,
                  onTap: () {
                    Get.toNamed(AppRoutes.homeScreen);
                  },
                  text: AppStrings.skipBtn.tr,
                  textColor: AppColors.black_400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
