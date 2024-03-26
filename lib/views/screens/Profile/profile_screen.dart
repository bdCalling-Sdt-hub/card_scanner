
import 'dart:ui';

import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/FAQ/faq_screen.dart';
import 'package:card_scanner/views/screens/Profile/edit_profile_screen.dart';
import 'package:card_scanner/views/screens/Profile/my_qrcode_screen.dart';
import 'package:card_scanner/views/screens/Profile/view_profile_screen.dart';
import 'package:card_scanner/views/screens/RecommendedNameCard/recommended_name_card.dart';
import 'package:card_scanner/views/screens/Settings/settings_screen_main.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'IneerWidget/custom_container_button.dart';
import 'card_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 4),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                            image: NetworkImage("https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1711008338~exp=1711011938~hmac=3a05225c2a75c0c003c9f09d51c3fbb6cda1d0189f31e94c8f72555a28854f63&w=826")),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        SizedBox(height: 4.h),
                        CustomText(
                          text: "Sparktech.agency",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.black_400,
                        )
                      ],
                    ),
                    SizedBox(width: 60.w),

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
                                Get.to(ViewProfileScreen());
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
          ),
        ),
      ),
    );
  }
}


