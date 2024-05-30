import 'dart:io';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../utils/app_icons.dart';
import 'IneerWidget/edit_card_style.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());
  ScrollController scrollController = ScrollController();

  addItems(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        },
                      ),
                      CustomText(
                        text: AppStrings.editProfile.tr,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: 30.w)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Row(
                    children: [

                      ///<<<=================== Card Information Button ===========>>>

                      GestureDetector(
                        onTap: () {
                          profileController.isStyle.value = false;
                          profileController.isInformation.value = true;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              color: profileController.isInformation.value
                                  ? AppColors.green_900
                                  : AppColors.transparentColor,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(color: AppColors.green_900)),
                          child: CustomText(
                            text: AppStrings.cardInformation,
                            color: profileController.isInformation.value
                                ? AppColors.whiteColor
                                : AppColors.black_500,
                          ),
                        ),
                      ),
                      Spacer(),

                      ///<<<===================== Card Style Button =============>>>

                      GestureDetector(
                        onTap: () {
                          profileController.isStyle.value = true;
                          profileController.isInformation.value = false;
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              color: profileController.isStyle.value
                                  ? AppColors.green_900
                                  : AppColors.transparentColor,
                              border: Border.all(color: AppColors.green_900)),
                          child: CustomText(
                            text: AppStrings.cardStyle.tr,
                            color: profileController.isStyle.value
                                ? AppColors.whiteColor
                                : AppColors.black_500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///<<<=================== Card Information =====================>>>
                if(profileController.isInformation.value)
                  GetBuilder<ProfileController>(builder: (controller) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100.h,
                            width: 100,
                            decoration: BoxDecoration(
                                image: PrefsHelper.profileImagePath.isEmpty
                                    ? DecorationImage(image: AssetImage(AppImages.blankProfileImage),fit: BoxFit.fill)
                                    : DecorationImage(image: NetworkImage(PrefsHelper.profileImagePath), fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.green_100
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: controller.isLoading? Center(child: CircularProgressIndicator(color: AppColors.green_600,)) : InkWell(
                                onTap: (){
                                  showDialog(context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.green_700,
                                        content: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                          height: 100.h,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                  profileController.selectImageGallery();
                                                },
                                                child: Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.green_600,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.image_outlined),
                                                      CustomText(text: "Gallery".tr, fontSize: 16,)
                                                    ],
                                                  ),),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                  profileController.selectImageCamera();
                                                },
                                                child: Container(
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: AppColors.green_600,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset(AppIcons.ocrCameraIcon, height: 20, width: 20,),
                                                      CustomText(text: "Camera".tr, fontSize: 16,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(width: 8,),
                                              // InkWell(
                                              //   onTap: () {
                                              //
                                              //   },
                                              //   child: Container(
                                              //     height: 70,
                                              //     width: 75,
                                              //     decoration: BoxDecoration(
                                              //       borderRadius: BorderRadius.circular(8),
                                              //       color: AppColors.green_600,
                                              //     ),
                                              //     child: Column(
                                              //       mainAxisAlignment: MainAxisAlignment.center,
                                              //       children: [
                                              //         SvgPicture.asset(AppIcons.linkedinIcon, height: 20, width: 20, color: AppColors.black_500, ),
                                              //         CustomText(text: "LinkedIn", fontSize: 16,)
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColors.black_500
                                  ),
                                  child: Icon(Icons.border_color_outlined, size: 20, color: AppColors.green_500,),
                                ),
                              ),
                            ),
                          ),
                          CustomText(
                            text: "${AppStrings.basicInfo.tr}:",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.green_900,
                          ),

                          Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///<<<================ Full Name ========================>>>

                              TextFormField(
                                controller: profileController.nameController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: AppStrings.fullName.tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14
                                    )
                                ),
                              ),

                              ///<<<=================== Mobile Number =================>>>

                              TextFormField(
                                controller: profileController.phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: AppStrings.mobile.tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14
                                    )
                                ),
                              ),

                              profileController.isLandPhone.value || profileController.telephoneController.text.isNotEmpty ? TextFormField(
                                controller: profileController.telephoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: "Telephone".tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                      fontWeight: FontWeight.w500
                                    )
                                ),
                              ) : SizedBox(),
                              profileController.isFax.value || profileController.faxController.text.isNotEmpty ? TextFormField(
                                controller: profileController.faxController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: "Fax".tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ) : SizedBox(),

                              ///<<<================= Email Address ===================>>>

                              TextFormField(
                                controller: profileController.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: AppStrings.email.tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14
                                    )
                                ),
                              ),
                              SizedBox(height: 12.h,),
                              CustomText(
                                text: "${AppStrings.workInfo.tr}:",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.green_900,
                              ),
                              TextFormField(
                                controller: profileController.designationController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: AppStrings.designation.tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14
                                    )
                                ),
                              ),
                              TextFormField(
                                controller: profileController.companyController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: AppStrings.companyName.tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14
                                    )
                                ),
                              ),

                              profileController.isWebsite.value || profileController.websiteController.text.isNotEmpty? TextFormField(
                                controller: profileController.websiteController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: "Website".tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ) : SizedBox(),

                              TextFormField(
                                controller: profileController.addressController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    labelText: AppStrings.address.tr,
                                    labelStyle: TextStyle(
                                        fontSize: 14
                                    )
                                ),
                              ),
                              SizedBox(height: 16.h,),
                            ],
                          )),

                          Obx(() => profileController.isTapped.value? Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              height: 120.h,
                              decoration: BoxDecoration(
                                  color: AppColors.green_600,
                                  borderRadius: BorderRadius.circular(4.r)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      profileController.isLandPhone.value = !profileController.isLandPhone.value;
                                    },
                                    child: CustomText(
                                      text: profileController.formFieldsList[0],
                                      color: AppColors.green_900,
                                      fontWeight: FontWeight.w500,
                                      bottom: 10,
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    height: 1.h,
                                    color: AppColors.green_900,),
                                  InkWell(
                                    onTap: () {
                                      profileController.isFax.value = !profileController.isFax.value;
                                    },
                                    child: CustomText(
                                      top: 5,
                                      text: profileController.formFieldsList[1],
                                      color: AppColors.green_900,
                                      fontWeight: FontWeight.w500,
                                      bottom: 10,
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    height: 1.h,
                                    color: AppColors.green_900,),
                                  InkWell(
                                    onTap: () {
                                      profileController.isWebsite.value = !profileController.isWebsite.value;
                                    },
                                    child: CustomText(
                                      top: 5,
                                      text: profileController.formFieldsList[2],
                                      color: AppColors.green_900,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ) : SizedBox()),
                          GestureDetector(
                            onTap: () {
                              profileController.isTapped.value = !profileController.isTapped.value;
                              addItems();
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                height: 30.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: AppColors.green_700,
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add, color: AppColors.green_500,),
                                    SizedBox(width: 4.w),
                                    CustomText(
                                      text: "Add".tr,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.green_500,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h,),

                          ///<<<================= Save and Preview Button =================>>>

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 42.w),
                            child: CustomElevatedButton(
                              onTap: (){
                                PrefsHelper.userName = profileController.nameController.text;
                                PrefsHelper.userMail = profileController.emailController.text;
                                PrefsHelper.userPhone = profileController.phoneController.text;
                                PrefsHelper.userDesignation = profileController.designationController.text;
                                PrefsHelper.userCompany = profileController.companyController.text;
                                PrefsHelper.userAddress = profileController.addressController.text;
                                PrefsHelper.userTelephone = profileController.telephoneController.text;
                                PrefsHelper.userFax = profileController.faxController.text;
                                PrefsHelper.userWebsite = profileController.websiteController.text;

                                PrefsHelper.setString("userName", profileController.nameController.text);
                                PrefsHelper.setString("userMail", profileController.emailController.text);
                                PrefsHelper.setString("userPhone", profileController.phoneController.text);
                                PrefsHelper.setString("userDesignation", profileController.designationController.text);
                                PrefsHelper.setString("userCompany", profileController.companyController.text);
                                PrefsHelper.setString("userAddress", profileController.addressController.text);
                                PrefsHelper.setString("userTelephone", profileController.telephoneController.text);
                                PrefsHelper.setString("userFax", profileController.faxController.text);
                                PrefsHelper.setString("userWebsite", profileController.websiteController.text);

                                Get.offAllNamed(AppRoutes.profileScreen);
                              },
                              width: Get.width,
                              height: 42.h,
                              text: AppStrings.saveAndPreview.tr,
                              backgroundColor: AppColors.black_500,
                            ),
                          )
                        ],
                      ),
                    );
                  },),

                ///<<<=================== Card Style =========================>>>
                if(profileController.isStyle.value)
                  EditCardStyle(),

              ],
            ),
          ),
        );
      }),
    );
  }
}


