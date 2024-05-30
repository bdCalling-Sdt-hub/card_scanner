import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/Helpers/screen_shot_helper.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Profile/IneerWidget/custom_container_button.dart';
import 'package:card_scanner/views/screens/Profile/edit_profile_screen.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ViewECardScreen extends StatelessWidget {
  ViewECardScreen({super.key});

  ScreenshotController screenshotController = ScreenshotController();
  ProfileController profileController = Get.put(ProfileController());
  ScreenShotHelper screenShotHelper = ScreenShotHelper();
  File? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(
                      icon: Icons.arrow_back,
                      onTap: () {
                        Get.back();
                      }),
                  CustomText(
                    text: AppStrings.eCard.tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomBackButton(
                    width: 50,
                      icon: Icons.file_download_outlined,
                      iconSize: 22,
                      onTap: () async {
                        await screenShotHelper.captureAndSaveImage(screenshotController);
                      }),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Screenshot(
                controller: screenshotController,
                child: Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: profileController.cardColorList[PrefsHelper.colorIndex],
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        ///<<<================= Name card Logo ================>>>
                        Positioned(
                          top: 170,
                          child: Container(
                            height: 170.h,
                            width: 170.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: PrefsHelper.isLogoShow? DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(AppImages.nameCardLogo),
                                  colorFilter: PrefsHelper.colorIndex == 3 || PrefsHelper.colorIndex == 4? ColorFilter.mode(
                                    AppColors.green_500.withOpacity(0.65), // Adjust the color and opacity
                                    BlendMode.srcATop,
                                  ) : null,
                                  opacity: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? 0.15 :  0.4) : null,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            ///<<<================= Profile Picture ================>>>
                            SizedBox(height: 16.h),
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

                            Padding(
                              padding:
                              EdgeInsets.only(left: 32.w, top: 16.h, bottom: 16.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          text: profileController.nameController.text,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                                        ),
                                        CustomText(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          text: profileController.designationController.text,
                                          fontSize: 16,
                                          fontWeight:  FontWeight.w500,
                                          color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                                        ),
                                        CustomText(
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          text: profileController.companyController.text,
                                          fontSize: 18,
                                          fontWeight:  FontWeight.w500,
                                          color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  customInfoRow(infoIcon: Icons.phone_iphone_outlined, infoText: profileController.phoneController.text),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  customInfoRow(infoIcon: Icons.call, infoText: profileController.telephoneController.text),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  customInfoRow(infoIcon: Icons.fax, infoText: profileController.faxController.text),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  customInfoRow(infoIcon: Icons.email_outlined, infoText: profileController.emailController.text),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  customInfoRow(infoIcon: Icons.language_outlined ,infoText: profileController.websiteController.text),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  customInfoRow(infoIcon: Icons.location_on_outlined, infoText: profileController.addressController.text)
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(),
            ),
            SizedBox(height: 48.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                children: [
                  ///<<<=================== Edit Button ===================>>>

                  CustomContainerButton(
                    onTap: () {
                      Get.to(EditProfileScreen());
                    },
                    text: AppStrings.edit.tr,
                    height: 48,
                    width: 110,
                    iconSize: 20,
                    fontSize: 16,
                    ifBorder: true,
                    backgroundColor: AppColors.black_500,
                    textColor: AppColors.black_500,
                    iconColor: AppColors.black_500,
                    farWidth: 8,
                    radius: 25,
                  ),
                  Spacer(),

                  ///<<<================= Share Card Button ================>>>

                  CustomContainerButton(
                    onTap: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if(image != null){
                        Share.shareXFiles([image]);
                      }
                    },
                    text: AppStrings.shareCard.tr,
                    ifImage: true,
                    svgIcon: AppIcons.sendIcon,
                    height: 48,
                    width: 180,
                    imageHeight: 20,
                    imageWidth: 20,
                    radius: 25,
                    fontSize: 16,
                    iconColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                    farWidth: 8,
                    backgroundColor: AppColors.black_500,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Row customInfoRow({required IconData infoIcon, required String infoText}) {
    return Row(
      children: [
        infoText.isEmpty? SizedBox() : CustomBackButton(
          onTap: () {},
          icon: infoIcon,
          radius: 100,
          color: AppColors.black_500,
          height: 25,
          width: 25,
        ),
        SizedBox(
          width: 8.w,
        ),
        CustomText(
          textAlign: TextAlign.left,
          text: infoText,
          color: PrefsHelper.colorIndex == 2 || PrefsHelper.colorIndex == 5? AppColors.blackColor : AppColors.green_50,
          fontSize: 18,
          fontWeight:  FontWeight.w500,
        )
      ],
    );
  }
}
