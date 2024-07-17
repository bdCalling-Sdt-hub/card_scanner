
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: must_be_immutable
class EnterpriseScreen extends StatelessWidget {
  EnterpriseScreen({super.key});

  List enterpriseFirstList = [
    {"icon" : AppIcons.saveTime, "name" : AppStrings.saveTime.tr},
    {"icon" : AppIcons.saveNSecurity, "name" : AppStrings.saveDataBackup.tr},
    {"icon" : AppIcons.dollarIcon, "name" : AppStrings.valueForMoney.tr},
    {"icon" : AppIcons.availableIcon, "name" : AppStrings.alwaysAvailable.tr},
  ];

  List enterpriseThirdList = [
    {"icon" : AppIcons.saveTime, "name" : AppStrings.fastInputBusinessCards.tr},
    {"icon" : AppIcons.importExportIcon, "name" : AppStrings.exchangeEcardsSeamlessly.tr},
    {"icon" : AppIcons.dataLists, "name" : AppStrings.exportCustomerData.tr},
    {"icon" : AppIcons.safeData, "name" : AppStrings.synchroniseData.tr},
  ];

  void launchURL() async {
    final Uri url = Uri.parse('https://forms.gle/7m8JXK97mcyyHFJfA');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                      text: AppStrings.nameCardScanner.tr,
                      color: AppColors.green_500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                      child: CustomText(
                        maxLines: 4,
                        text: AppStrings.nameCardScannerEfficientlyDigitizes.tr,
                        color: AppColors.green_500,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    CustomText(
                      text: "Current version is free to use.".tr,
                      color: AppColors.green_500,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: "Please complete survey below if there is demand for PREMIUM features:".tr,
                      color: AppColors.green_500,
                      fontWeight: FontWeight.w400,
                      bottom: 8,
                    ),
                    InkWell(
                        onTap: () {
                          launchURL();
                        },
                        child: CustomText(
                            text: "https://forms.gle/7m8JXK97mcyyHFJfA",
                            color: Colors.lightBlue,
                          fontWeight: FontWeight.w400,
                        ),
                    ),
                    SizedBox(
                      height: 24.h,
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
                      SizedBox(height: 12.h,),
                      CustomText(
                        text: AppStrings.allFeatures,
                        color: AppColors.black_500,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 36.h,),
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
                                    height: 60.h,
                                    width: 60.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.black_500),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(child: SvgPicture.asset(enterpriseThirdList[index]["icon"])),
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomText(
                                    // textAlign: TextAlign.left,
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
