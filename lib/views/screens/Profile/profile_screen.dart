
import 'dart:io';
import 'dart:ui';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Auth/signin_screen.dart';
import 'package:card_scanner/views/screens/FAQ/faq_screen.dart';
import 'package:card_scanner/views/screens/Profile/edit_profile_screen.dart';
import 'package:card_scanner/views/screens/Profile/my_qrcode_screen.dart';
import 'package:card_scanner/views/screens/Profile/view_profile_screen.dart';
import 'package:card_scanner/views/screens/RecommendedNameCard/recommended_name_card.dart';
import 'package:card_scanner/views/screens/Settings/settings_screen_main.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'IneerWidget/custom_container_button.dart';
import 'card_style.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    List cardViewList = [
      {"icon" : Icon(Icons.visibility_outlined), "text" : AppStrings.view},
      {"icon" : Icon(Icons.palette_outlined), "text" : AppStrings.cardStyle},
      {"icon" : Icon(Icons.qr_code_scanner), "text" : AppStrings.cardCode},
    ];

    List servicesList = [
      {"icon" : SvgPicture.asset(AppIcons.sendIcon, height: 18), "text" : AppStrings.recommendToFriends},
      {"icon" : Icon(Icons.swap_vert_circle_outlined), "text" : AppStrings.faq},
      {"icon" : Icon(Icons.settings_outlined), "text" : AppStrings.settings},
      {"icon" : Icon(Icons.logout_outlined), "text" : AppStrings.signOut},
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 4),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: GetBuilder<ProfileController>(builder: (profileController) {
            return Column(
              children: [
                CustomText(
                  text: AppStrings.myProfile,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                SizedBox(height: 20.h),

                ///<<<====================== Profile Details ==================>>>

                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.w,
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
                      SizedBox(width: 8.w),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              text: profileController.nameController.text.isEmpty? PrefsHelper.userName : profileController.nameController.text,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.green_900,
                            ),
                            CustomText(
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              text: profileController.designationController.text.isEmpty? "Designation: null" : profileController.designationController.text,
                              color: AppColors.black_400,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              text: profileController.companyController.text.isEmpty? "Company Name: null" : profileController.companyController.text,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.black_400,
                            )
                          ],
                        ),
                      ),
                      Spacer(),

                      ///<<<============== Edit Card ==========================>>>

                      CustomContainerButton(
                          onTap: (){
                            Get.to(EditProfileScreen());
                          },
                          text: AppStrings.edit
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                ///<<<===================== View Card Items ===================>>>

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        cardViewList.length,
                            (index) => InkWell(
                          onTap: (){
                            if(index == 0){
                              Get.to(ViewECardScreen());
                            } else if(index == 1){
                              Get.to(CardStyleScreen());
                            } else if(index == 2){
                              Get.to(MyQrCodeScreen());
                            }
                          },
                          child: Container(
                            height: 65.h,
                            width: 82.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(color: AppColors.black_400)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                cardViewList[index]["icon"],
                                CustomText(
                                  text: cardViewList[index]["text"],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                ),
                SizedBox(height: 40.h),

                ///<<<=================== Services List =======================>>>

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.black_400)
                  ),
                  child: Column(
                    children: List.generate(
                      servicesList.length, (index) =>
                        InkWell(
                          onTap: (){
                            if(index == 2 ){
                              Get.to(SettingsScreenMain());
                            } else if(index == 0 ){
                              Get.to(RecommendNameCardScreen());
                            } else if(index == 1 ){
                              Get.to(FAQScreen());
                            } else if(index == 3 ){
                              showDialog(
                                context: context,
                                builder: (context) {

                                  ///<<<==================== Sign out pop up =========================>>>

                                  return AlertDialog(
                                    content: CustomText(text: "Are you sure to sign out?", fontSize: 20, color: AppColors.black_500,),
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
                                              borderColor: AppColors.green_900,
                                            ),
                                          ),
                                          SizedBox(width: 12,),
                                          Expanded(
                                            child: CustomElevatedButton(
                                              onTap: (){
                                                // SystemNavigator.pop();
                                                authController.signOutRepo();
                                              },
                                              text: "Yes",
                                              backgroundColor: AppColors.green_900,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                            margin: EdgeInsets.symmetric(vertical: 6.h),
                            decoration: BoxDecoration(
                                color: AppColors.green_600,
                                borderRadius: BorderRadius.circular(8.r)
                            ),
                            child: Row(
                              children: [
                                servicesList[index]["icon"],
                                SizedBox(width: 8.w),
                                CustomText(
                                  text: servicesList[index]["text"],
                                  fontSize: 16,
                                  color: AppColors.black_500,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios_outlined, size: 12),
                              ],
                            ),
                          ),
                        ),
                    ),
                  ),
                )
              ],
            );
          },),
        ),
      ),
    );
  }
}


