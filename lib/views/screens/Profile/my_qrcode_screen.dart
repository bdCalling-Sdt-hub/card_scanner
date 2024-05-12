
import 'dart:io';

import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Helpers/prefs_helper.dart';
import '../../../controllers/qr_scanner_controller.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class MyQrCodeScreen extends StatelessWidget {
  MyQrCodeScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());
  QrScannerController qrScannerController = Get.put(QrScannerController());

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
                  image: PrefsHelper.profileImagePath.isEmpty
                      ? DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AppImages.blankProfileImage))
                      : DecorationImage(
                      fit: BoxFit.fill,
                      image: FileImage(File(PrefsHelper.profileImagePath))),
                ),
              ),
              SizedBox(height: 20.h),
              CustomText(
                maxLines: 2,
                textAlign: TextAlign.left,
                text: profileController.nameController.text.isEmpty? "Name: null" : profileController.nameController.text,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.green_900,
              ),
              CustomText(
                maxLines: 2,
                textAlign: TextAlign.left,
                text: profileController.designationController.text.isEmpty? "Designation: null" : profileController.designationController.text,
                color: AppColors.black_400,
                fontSize: 16,
              ),
              SizedBox(height: 4.h),
              CustomText(
                maxLines: 2,
                textAlign: TextAlign.left,
                text: profileController.companyController.text.isEmpty? "Company Name: null" : profileController.companyController.text,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.black_400,
              ),
              SizedBox(height: 12.h),
              QrImageView(
                data: "${profileController.nameController.text}/${profileController.designationController.text}/${profileController.companyController.text}/${profileController.emailController.text}/${profileController.phoneController.text}/${profileController.addressController.text} ",
                version: QrVersions.auto,
                size: 200,
                gapless: false,
                // embeddedImage: FileImage(File(selectedContact.imageUrl)),
                embeddedImageStyle: QrEmbeddedImageStyle(
                    size: Size(100, 100)
                ),
                errorStateBuilder: (context, error) {
                  return Center(
                    child: Text(
                      "Uh oh! Something went wrong...",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
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
                            qrScannerController.qrScanner();
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
