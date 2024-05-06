
import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/customButton/custom_elevated_button.dart';

class CardSyncScreen extends StatelessWidget {
  CardSyncScreen({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(onTap: (){
                    Get.back();
                  }),
                  CustomText(
                    text: AppStrings.smartSync,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w,),
                ],
              ),
              SizedBox(
                height: 36.h,
              ),

              ///<<<===================== Mobile Backup ======================>>>
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: CustomText(
                          maxLines: 5,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          text: AppStrings.sureToSaveInMobile,
                          color: AppColors.green_900,
                        ),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  onTap: (){
                                    Get.back();
                                  },
                                  text: "No",
                                  textColor: AppColors.black_500,
                                  isFillColor: false,
                                  borderColor: AppColors.black_500,
                                ),
                              ),
                              SizedBox(width: 12,),
                              Expanded(
                                child: CustomElevatedButton(
                                  onTap: (){
                                    Get.back();
                                    Get.snackbar("Your data backed up in your local storage", "");
                                  },
                                  text: "Yes",
                                  backgroundColor: AppColors.black_500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.green_900),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Image.asset(AppImages.mobileSmartSync, height: 130.h, width: 168.w,),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: AppStrings.mobileBackup,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: AppStrings.batchExportCards,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h,),

              ///<<<===================== Google backup ======================>>>

              GestureDetector(
                onTap: (){
                  // authController.googleSignInRepo();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: CustomText(
                            maxLines: 5,
                            text: AppStrings.sureToSaveInEmail,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.green_900,
                          ),
                        actions: [
                          CustomElevatedButton(onTap: () {
                            authController.googleSignInRepo();
                            },
                            svgIcon: AppIcons.googleColorfulIcon,
                            text: "Login",
                            backgroundColor: AppColors.black_500,
                            fontSize: 20,
                          ),
                          SizedBox(height: 8.h,),

                          TextButton(onPressed: (){
                            authController.googleSignOutRepo();
                          }, child: Text("Logout",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                            ),
                          )),
                        ],
                      );
                    },);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  width: Get.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.green_900),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Image.asset(AppImages.emailBackUpImg, height: 130.h, width: 168.w,),
                      SizedBox(height: 20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: AppStrings.emailBackup,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          textAlign: TextAlign.left,
                          text: AppStrings.dataBackupEmailsSecurely,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
