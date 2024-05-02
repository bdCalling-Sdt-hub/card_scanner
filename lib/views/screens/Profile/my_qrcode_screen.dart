
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../QrCodeScanner/scan_qr_code_screen.dart';

class MyQrCodeScreen extends StatelessWidget {
  const MyQrCodeScreen({super.key});

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
                    onTap: (){Get.back();},
                    icon: Icons.arrow_back,
                  ),
                  CustomText(
                    text: AppStrings.myQrCode,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1711008338~exp=1711011938~hmac=3a05225c2a75c0c003c9f09d51c3fbb6cda1d0189f31e94c8f72555a28854f63&w=826")),
                ),
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: "Mustain Billah",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.green_900,
              ),
              CustomText(
                text: "Ui-Ux Designer",
                color: AppColors.black_400,
              ),
              SizedBox(
                  height: 4.h
              ),
              CustomText(
                text: "Sparktech.agency",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.black_400,
              ),
              SizedBox(height: 12.h),
              Image.asset(AppImages.qr1Img, height: 150, width: 150,),
              CustomText(text: AppStrings.nameCardScanner, fontSize: 12,),
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Get.to(ScanQrCodeScreen());
                          },
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.green_50
                            ),
                            child: Center(
                                child: SvgPicture.asset(
                                  AppIcons.barCodeScanIcon,
                                  height: 24,
                                  width: 24,
                                ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        CustomText(
                          text: AppStrings.scanQrCode,
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.snackbar("Qr code downloaded", "");
                          },
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.green_50
                            ),
                            child: Center(
                              child: Icon(
                                Icons.file_download_outlined,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        CustomText(
                          text: AppStrings.saveImage,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
