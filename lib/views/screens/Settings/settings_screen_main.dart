import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Settings/about_screen.dart';
import 'package:card_scanner/views/screens/Settings/change_language_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

// ignore: must_be_immutable
class SettingsScreenMain extends StatelessWidget {
  SettingsScreenMain({super.key});

  final notificationController = ValueNotifier<bool>(false);

  List servicesList = [
    // {"icon": Icon(Icons.pageview), "text": AppStrings.general},
    // {"icon": Icon(Icons.notifications), "text": AppStrings.notifications},
    {"icon": Icon(Icons.language), "text": AppStrings.language.tr},
    {
      "icon": SvgPicture.asset(AppIcons.aboutIcon, height: 18),
      "text": AppStrings.aboutUs
    },
  ];
  
  RxBool isDefault = false.obs;
  RxBool isFirstLast = false.obs;
  RxBool isLastFirst = false.obs;

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
                    onTap: () {
                      Get.back();
                    },
                    icon: Icons.arrow_back,
                  ),
                  CustomText(
                    text: AppStrings.settings.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(
                height: 80.h,
              ),
              Column(
                children: List.generate(
                  servicesList.length,
                  (index) => InkWell(
                    onTap: () {
                      // if (index == 0) {
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return openAlertDialog(0);
                      //     },
                      //   );
                      // }
                      // else if (index == 1) {
                      //   showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return openAlertDialog(1);
                      //     },
                      //   );
                      // }
                      if(index == 0){
                        Get.to(ChangeLanguageScreen());
                      }
                      else if(index == 1){
                        Get.to(AboutScreen());
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 12.h),
                          margin: EdgeInsets.symmetric(vertical: 6.h),
                          decoration: BoxDecoration(
                              color: AppColors.green_600,
                              borderRadius: BorderRadius.circular(8.r)),
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
                        Divider(),
                      ],
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

  AlertDialog openAlertDialog(int index) {
    return AlertDialog(
      surfaceTintColor: AppColors.green_900,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        width: Get.width,
        height: 220.h,
        child: index == 0? Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CustomBackButton(
                onTap: () {
                  Get.back();
                },
                radius: 100,
              ),
            ),
            SizedBox(height: 16.h),
            InkWell(
              onTap: (){
                isDefault.value = true;
                isFirstLast.value = false;
                isLastFirst.value = false;
              },
              child: Row(
                children: [
                  CustomText(
                    text: AppStrings.setAsDefault.tr,
                    fontSize: 16,
                  ),
                  Spacer(),
                  Icon(
                    isDefault.value? Icons.check : null,
                    size: 20,
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                isDefault.value = false;
                isFirstLast.value = true;
                isLastFirst.value = false;
              },
              child: Row(
                children: [
                  CustomText(
                    text: AppStrings.firstLast.tr,
                    fontSize: 16,
                  ),
                  Spacer(),
                  Icon(
                    isFirstLast.value? Icons.check : null,
                    size: 20,
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                isDefault.value = false;
                isFirstLast.value = false;
                isLastFirst.value = true;
              },
              child: Row(
                children: [
                  CustomText(
                    text: AppStrings.lastFirst.tr,
                    fontSize: 16,
                  ),
                  Spacer(),
                  Icon(
                    isLastFirst.value? Icons.check : null,
                    size: 20,
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        )) : Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CustomBackButton(
                onTap: () {
                  Get.back();
                },
                radius: 100,
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              height: 40.h,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.green_600,
              ),
              child: Row(
                children: [
                  CustomText(
                      text: AppStrings.receiveNotifications.tr,
                    fontSize: 16,
                  ),
                  Spacer(),
                  AdvancedSwitch(
                    thumb: ValueListenableBuilder(
                      valueListenable: notificationController,
                      builder: (_, value, __) {
                        return Icon(value
                            ? Icons.circle
                            : Icons.circle_outlined, size: 16,);
                      },
                    ),
                    controller: notificationController,
                    activeColor: AppColors.green_900,
                    inactiveColor: AppColors.black_200,
                    borderRadius: BorderRadius.all(const Radius.circular(15)),
                    width: 40.0,
                    height: 20.0,
                    enabled: true,
                    disabledOpacity: 0.5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
