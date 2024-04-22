
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EnterpriseScreen extends StatelessWidget {
  EnterpriseScreen({super.key});

  List enterpriseFirstList = [
    {"icon" : AppIcons.saveTime, "name" : AppStrings.saveTime},
    {"icon" : AppIcons.saveNSecurity, "name" : AppStrings.saveAndSecurity},
    {"icon" : AppIcons.dollarIcon, "name" : AppStrings.valueForMoney},
    {"icon" : AppIcons.availableIcon, "name" : AppStrings.alwaysAvailable},
  ];

  List enterpriseSecondList = [
    {"titleText" : AppStrings.fastNAccurateDataEntry, "subTitleText" : AppStrings.quicklyEnterBusinessCardsToSales, "image" : AppImages.enterpriseImg2},
    {"titleText" : AppStrings.roleBasedAccessControl, "subTitleText" : AppStrings.secureCompanyDataWithAppropriateRole, "image" : AppImages.enterpriseImg2},
    {"titleText" : AppStrings.smartCollaboration, "subTitleText" : AppStrings.facilitateTeamCollaboration, "image" : AppImages.enterpriseImg2},
    {"titleText" : AppStrings.dataIntegration, "subTitleText" : AppStrings.integrateYourCustomerDataWithOtherCRM, "image" : AppImages.enterprise3},
  ];

  List enterpriseThirdList = [
    {"icon" : AppIcons.saveTime, "name" : AppStrings.fastInputBusinessCards},
    {"icon" : AppIcons.importExportIcon, "name" : AppStrings.exchangeEcardsSeamlessly},
    {"icon" : AppIcons.networkIcon, "name" : AppStrings.centralizeAllEmployeesBusinessCards},
    {"icon" : AppIcons.setRole, "name" : AppStrings.setRoleForEachUser},
    {"icon" : AppIcons.dataLists, "name" : AppStrings.exportCustomerData},
    {"icon" : AppIcons.safeData, "name" : AppStrings.dataIsAlwaysSafeAndSecure},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green_900,
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [

              ///<<<=================== Top Part ===========================>>>

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Image.asset(AppImages.enterpriseImage)),
                    CustomText(
                      text: AppStrings.nameCardScanner.toUpperCase(),
                      color: AppColors.green_500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                      child: CustomText(
                        maxLines: 4,
                        text: AppStrings.nameCardScannerEfficientlyDigitizes,
                        color: AppColors.green_500,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    // CustomElevatedButton(
                    //   width: 165.w,
                    //   height: 42.h,
                    //   onTap: (){},
                    //   text: AppStrings.tryItFree,
                    //   backgroundColor: AppColors.black_500,
                    //   textColor: AppColors.green_400,
                    // ),
                    SizedBox(
                      height: 42.h,
                    ),
                  ],
                ),
              ),

              ///<<<==================== Bottom Part =========================>>>

              Container(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 320.h,
                        width: Get.width,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: enterpriseFirstList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                                crossAxisCount: 2
                            ), itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 68.h,
                                    width: 68.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.black_500),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(child: SvgPicture.asset(enterpriseFirstList[index]["icon"])),
                                  ),
                                  SizedBox(height: 4.h,),
                                  CustomText(
                                    text: enterpriseFirstList[index]["name"],
                                    color: AppColors.black_400,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ],
                              );
                            },
                        ),
                      ),
                      const Divider(color: AppColors.black_400,),
                      SizedBox(height: 16.h,),

                      Column(
                        children: List.generate(
                            enterpriseSecondList.length,
                                (index) => Column(
                                  children: [
                                    CustomText(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black_500,
                                      text: enterpriseSecondList[index]["titleText"],
                                    ),
                                    SizedBox(height: 12.h,),
                                    CustomText(
                                      maxLines: 5,
                                      color: AppColors.black_400,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      text: enterpriseSecondList[index]["subTitleText"],
                                    ),
                                    SizedBox(height: 12.h,),
                                    Image.asset(enterpriseSecondList[index]["image"]),
                                    SizedBox(height: 20.h,),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: 12.h,),
                      const Divider(color: AppColors.black_400,),
                      CustomText(
                        text: AppStrings.allFeatures,
                        color: AppColors.black_500,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 48.h,),
                      SizedBox(
                        height: (100 * enterpriseThirdList.length).toDouble(),
                        width: Get.width,
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: enterpriseThirdList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 200,
                              crossAxisSpacing: 16,
                                crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 68.h,
                                    width: 68.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.black_500),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(child: SvgPicture.asset(enterpriseThirdList[index]["icon"])),
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                    maxLines: 5,
                                    text: enterpriseThirdList[index]["name"],
                                    color: AppColors.black_400,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ],
                              );
                            },
                        ),
                      ),
                      const Divider(color: AppColors.black_400,),
                      SizedBox(height: 8.h,),
                      CustomText(
                        left: 10,
                        maxLines: 3,
                        text: AppStrings.overTheBusinessesAreLove,
                        color: AppColors.black_500,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      SizedBox(height: 24.h,),
                      Wrap(
                        runSpacing: 24.h,
                        spacing: 16.w,
                        children: [
                          Image.asset(AppImages.fastCompany, height: 74.h, width: 74.w,),
                          Image.asset(AppImages.meetUp, height: 74.h, width: 74.w,),
                          Image.asset(AppImages.total, height: 74.h, width: 74.w,),
                          Image.asset(AppImages.xing, height: 74.h, width: 74.w,),
                          Image.asset(AppImages.heritage, height: 74.h, width: 74.w,),
                          Image.asset(AppImages.recurly, height: 74.h, width: 74.w,),
                        ],
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
