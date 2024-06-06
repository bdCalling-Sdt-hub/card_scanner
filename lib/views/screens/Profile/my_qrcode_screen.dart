
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/Helpers/screen_shot_helper.dart';
import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../Helpers/prefs_helper.dart';
import '../../../controllers/qr_scanner_controller.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class MyQrCodeScreen extends StatelessWidget {
  MyQrCodeScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());
  QrScannerController qrScannerController = Get.put(QrScannerController());
  ScreenshotController screenshotController = ScreenshotController();
  OCRCreateCardController ocrCreateCardController = Get.put(OCRCreateCardController());
  ScreenShotHelper screenShotHelper = ScreenShotHelper();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("${PrefsHelper.profileImagePath} /${profileController.nameController.text}/${profileController.designationController.text}/${profileController.companyController.text}/${profileController.emailController.text}/${profileController.phoneController.text}/${profileController.telephoneController.text}/${profileController.faxController.text}/${profileController.websiteController.text}/${profileController.addressController.text} ");
    }

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
                    text: AppStrings.myQrCode.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(height: 20.h),
              CachedNetworkImage(
                imageUrl: PrefsHelper.profileImagePath,
                imageBuilder: (context, imageProvider) => Container(
                  height: 150.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: PrefsHelper.isProfilePhotoShow? DecorationImage(
                      fit: BoxFit.fill,
                      image: imageProvider,
                    ) : null,
                  ),
                ),
                placeholder: (context, url) => Container(
                    height: 150.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Container(
                  height: 150.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(100.r),
                      color: AppColors.green_600
                  ),
                  child: Icon(Icons.error),
                ),
              ),
              SizedBox(height: 20.h),
              CustomText(
                maxLines: 2,
                textAlign: TextAlign.left,
                text: profileController.nameController.text.isEmpty? "Name: ".tr : profileController.nameController.text,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.green_900,
              ),
              CustomText(
                maxLines: 2,
                textAlign: TextAlign.left,
                text: profileController.designationController.text.isEmpty? "Designation: ".tr : profileController.designationController.text,
                color: AppColors.black_400,
                fontSize: 16,
              ),
              SizedBox(height: 4.h),
              CustomText(
                maxLines: 2,
                textAlign: TextAlign.left,
                text: profileController.companyController.text.isEmpty? "Company Name: ".tr : profileController.companyController.text,
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.black_400,
              ),
              SizedBox(height: 12.h),
              Screenshot(
                controller: screenshotController,
                child: Container(
                  height: 200.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor
                  ),
                  child: Center(
                    child: QrImageView(
                      data: "${PrefsHelper.profileImagePath} /${profileController.nameController.text} /${profileController.designationController.text} /${profileController.companyController.text} /${profileController.emailController.text} /${profileController.phoneController.text} /${profileController.telephoneController.text} /${profileController.faxController.text} /${profileController.websiteController.text} /${profileController.addressController.text} ",
                      version: QrVersions.auto,
                      gapless: false,
                      // embeddedImage: FileImage(File(selectedContact.imageUrl)),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(100, 100)
                      ),
                      errorStateBuilder: (context, error) {
                        return Center(
                          child: Text(
                            "Oh! Something went wrong...".tr,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              CustomText(text: AppStrings.nameCardScanner.tr, fontSize: 12,),
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  children: [
                    Column(
                      children: [
                        GetBuilder<OCRCreateCardController>(builder: (ocrCreateCardController) {
                          return ocrCreateCardController.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : InkWell(
                            onTap: () async {
                              await qrScannerController.qrScanner().then((value) {
                                ocrCreateCardController.textFormatRepo(extractedText: value);
                              });
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
                          );
                        },),
                        SizedBox(height: 8.h,),
                        CustomText(
                          text: AppStrings.scanQrCode.tr,
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            screenShotHelper.captureAndSaveImage(screenshotController: screenshotController);
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
                          text: AppStrings.saveImage.tr,
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
