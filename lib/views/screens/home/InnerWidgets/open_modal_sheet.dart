import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/customText/custom_text.dart';

class OpenModalSheet extends StatelessWidget {
  OpenModalSheet({
    super.key,
    required this.index
  });

  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          ),
          color: AppColors.green_50),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CustomBackButton(
                  onTap: (){
                    Get.back();
                  },
                  radius: 100,
                ),
              ),
            ),
            CustomText(
              text: AppStrings.moreOptions,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
            SizedBox(
              height: 20.h,
            ),

            ///<<<=============== Share Business Card ========================>>>

            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      surfaceTintColor:  AppColors.green_900,
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                        width: Get.width,
                        height: 200.h,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomBackButton(
                                onTap: (){
                                  Get.back();
                                },
                                radius: 100.r,
                              ),
                            ),
                            CustomText(
                              text: AppStrings.shareWith,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 40.h,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.black_500,
                                        borderRadius: BorderRadius.circular(12.r)
                                    ),
                                    child: Center(child: SvgPicture.asset(AppIcons.linkedinIcon)),
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.black_500,
                                        borderRadius: BorderRadius.circular(12.r)
                                    ),
                                    child: Center(child: SvgPicture.asset(AppIcons.fbIcon)),
                                  ),
                                  Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.black_500,
                                        borderRadius: BorderRadius.circular(12.r)
                                    ),
                                    child: Center(child: SvgPicture.asset(AppIcons.emailIcon, color: AppColors.green_50,)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: AppStrings.shareBusinessCard,
                    fontSize: 16,
                  )
                ],
              ),
            ),
            Divider(
              endIndent: 120,
              color: AppColors.black_400,
            ),
            SizedBox(
              height: 8.h,
            ),

            ///<<<==================== Remove AlertDialog Open ====================>>>
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      surfaceTintColor:  AppColors.green_900,
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      content: SizedBox(
                        width: Get.width,
                        height: 185.h,
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),
                            CustomText(
                              text: AppStrings.areYouSure,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),

                                ///<<<=============== Yes Button ================>>>

                                CustomElevatedButton(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.homeScreen);
                                  },
                                  text: AppStrings.yes,
                                  height: 38,
                                  width: 64,
                                  isFillColor: true,
                                  backgroundColor: AppColors.black_500,
                                  borderRadius: 36,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),

                                ///<<<=============== No Button ================>>>

                                CustomElevatedButton(
                                  onTap: () {
                                    Get.back();
                                  },
                                  text: AppStrings.no,
                                  height: 38,
                                  width: 64,
                                  borderColor: AppColors.black_500,
                                  isFillColor: false,
                                  borderRadius: 36,
                                  textColor: AppColors.black_500,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: AppStrings.removeCard,
                    fontSize: 16,
                  )
                ],
              ),
            ),
            Divider(
              endIndent: 120,
              color: AppColors.black_400,
            ),
          ],
        ),
      ),
    );
  }
}
