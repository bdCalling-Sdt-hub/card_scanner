

import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Profile/IneerWidget/custom_container_button.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_images.dart';

class ShareProfileCardScreen extends StatelessWidget {
  ShareProfileCardScreen({super.key});

  String link ="https://cf88BYf=name-card-scanner" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(
                      onTap: (){
                        Get.back();
                        },
                  ),
                  CustomText(
                    text: AppStrings.shareCard,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w,)
                ],
              ),
              SizedBox(height: 50.h),
              ///<<<================= QR Code ========================>>>
              Image.asset(AppImages.qr1Img, width: 180.w, height: 180.h,),
              SizedBox(height: 20.h),
              CustomText(
                text: AppStrings.pointYourCamera,
                color: AppColors.black_400,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 40.h,),

              ///<<<================ Share Card Button ======================>>>

              CustomElevatedButton(
                  onTap: (){
                    Share.share(link) ;
                  },
                borderRadius: 24,
                text: AppStrings.share,
                backgroundColor: AppColors.black_500,
                height: 54.h,
                width: 162.w,
              ),
              SizedBox(height: 24.h,),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black_50,
                  borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: link,
                      fontSize: 16,
                    ),

                    ///<<<=============== Qr Code Link Copy Icon ==============>>>

                    InkWell(
                        onTap: (){
                          Get.snackbar("Share link copied", "");
                        },
                        child: Icon(Icons.content_copy_outlined))
                  ],
                ),
              ),
              SizedBox(height: 54.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  InkWell(
                    onTap: () {
                      Get.snackbar("Qr code downloaded", "");
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8.h, right: 4.w, left: 4.w),
                      height: 76.h,
                      width: 76,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.black_50,
                          border: Border.all(color: AppColors.green_600)),
                      child: Column(
                        children: [
                          Icon(Icons.file_download_outlined, size: 30,),
                          SizedBox(height: 4.h,),
                          CustomText(
                            text: "Download",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.snackbar("Qr code downloaded", "");
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8.h, right: 4.w, left: 4.w),
                      height: 76.h,
                      width: 76,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.black_50,
                          border: Border.all(color: AppColors.green_600)),
                      child: Column(
                        children: [
                          Icon(Icons.email_outlined, size: 30,),
                          SizedBox(height: 4.h,),
                          CustomText(
                            text: "Email",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
