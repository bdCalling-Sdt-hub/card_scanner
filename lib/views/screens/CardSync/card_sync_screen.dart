
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardSyncScreen extends StatelessWidget {
  const CardSyncScreen({super.key});

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
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: CustomText(
                          maxLines: 2,
                          text: AppStrings.getService,
                          fontSize: 16,
                        )
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
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          content: CustomText(
                            maxLines: 2,
                            text: AppStrings.getService,
                            fontSize: 16,
                          )
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
