import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/onboardingScreen/inner/onboard_scroll_controller.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  OnBoardScrollController onBoardScrollController =
      Get.put(OnBoardScrollController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: onBoardScrollController.imageList.length,
          //     itemBuilder: (context, index) {
          //       var imageList = onBoardScrollController.imageList;
          //       var titleText = onBoardScrollController.titles;
          //       var subTitleText = onBoardScrollController.subTitles;
          //       index = onBoardScrollController.currentPosition.value;
          //       return Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 16.w),
          //         child: Column(
          //           children: [
          //             SizedBox(
          //               height: 150.h,
          //             ),
          //             SizedBox(
          //               height: 300.h,
          //               width: 300.w,
          //               child: SvgPicture.asset(
          //                 imageList[index],
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //
          //             ///<<<================= Title Text =========================>>>
          //             CustomText(
          //               bottom: 8.h,
          //               maxLines: 2,
          //               text: titleText[index],
          //               color: AppColors.black_500,
          //               fontSize: 28,
          //               fontWeight: FontWeight.w600,
          //             ),
          //             CustomText(
          //               left: 10.w,
          //               right: 10.w,
          //               bottom: 8.h,
          //               maxLines: 3,
          //               text: subTitleText[index],
          //               color: AppColors.black_400,
          //               fontSize: 16,
          //               fontWeight: FontWeight.w400,
          //             ),
          //             // SmoothPageIndicator(
          //             //   controller: pageController,
          //             //   count: onBoardScrollController.imageList.length,
          //             //   axisDirection: Axis.horizontal,
          //             //   effect:  const SlideEffect(
          //             //     spacing:  8.0,
          //             //     radius:  4.0,
          //             //     dotWidth:  14.0,
          //             //     dotHeight:  8.0,
          //             //     dotColor:  AppColors.black_400,
          //             //     activeDotColor:  AppColors.black_500,
          //             //
          //             //   ),
          //             // ),
          //           ],
          //         ),
          //       );
          //     },),
          // ),

          Expanded(
            child: GetBuilder<OnBoardScrollController>(builder: (controller) {
              return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: onBoardScrollController.imageList.length,
                onPageChanged: (value) {
                  onBoardScrollController.currentPosition.value = value;
                  print("===============$value");
                },
                itemBuilder: (context, index) {
                  var imageList = onBoardScrollController.imageList;
                  var titleText = onBoardScrollController.titles;
                  var subTitleText = onBoardScrollController.subTitles;
                  index = onBoardScrollController.currentPosition.value;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                        ),
                        SizedBox(
                          height: 300.h,
                          width: 300.w,
                          child: SvgPicture.asset(
                            imageList[index],
                            fit: BoxFit.contain,
                          ),
                        ),

                        ///<<<================= Title Text =========================>>>
                        CustomText(
                          bottom: 8.h,
                          maxLines: 2,
                          text: titleText[index],
                          color: AppColors.black_500,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                        CustomText(
                          left: 10.w,
                          right: 10.w,
                          maxLines: 3,
                          text: subTitleText[index],
                          color: AppColors.black_400,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        // SmoothPageIndicator(
                        //   controller: pageController,
                        //   count: onBoardScrollController.imageList.length,
                        //   axisDirection: Axis.horizontal,
                        //   effect:  const SlideEffect(
                        //     spacing:  8.0,
                        //     radius:  4.0,
                        //     dotWidth:  14.0,
                        //     dotHeight:  8.0,
                        //     dotColor:  AppColors.black_400,
                        //     activeDotColor:  AppColors.black_500,
                        //
                        //   ),
                        // ),
                      ],
                    ),
                  );
                },
              );
            },),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Get.height * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                indicatorContainer(
                    onBoardScrollController.currentPosition.value == 0
                        ? AppColors.black_500
                        : AppColors.black_300),
                SizedBox(width: 8.w),
                indicatorContainer(
                    onBoardScrollController.currentPosition.value == 1
                        ? AppColors.black_500
                        : AppColors.black_300),
                SizedBox(width: 8.w),
                indicatorContainer(
                    onBoardScrollController.currentPosition.value == 2
                        ? AppColors.black_500
                        : AppColors.black_300),
              ],
            ),
          ),
        ],
      )),

      ///<<<==================== Buttons =========================>>>

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h),
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                borderRadius: 26.r,
                isFillColor: false,
                width: 75.w,
                height: 40.h,
                onTap: () {
                  Get.toNamed(AppRoutes.signInScreen);
                },
                text: onBoardScrollController.currentPosition.value == 2? AppStrings.signInBtn.tr : AppStrings.skipBtn.tr,
                textColor: AppColors.black_400,
              ),
              SizedBox(
                height: 42.h,
                width: 75.w,
                child: onBoardScrollController.currentPosition.value == 2
                    ? CustomElevatedButton(
                  backgroundColor: AppColors.black_500,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  borderRadius: 26.r,
                  isFillColor: true,
                  width: 75.w,
                  height: 40.h,
                  onTap: () {
                    Get.toNamed(AppRoutes.signUpScreen);
                  },
                  text: AppStrings.signUpBtn.tr,
                  textColor: AppColors.whiteColor,
                )
                    : ElevatedButton(
                  onPressed: () {
                    if(onBoardScrollController.currentPosition <=2 ){
                      onBoardScrollController.currentPosition.value ++;
                    }
                  },
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(26)))),
                    backgroundColor:
                    MaterialStatePropertyAll(AppColors.black_500),
                  ),
                  child: SvgPicture.asset(
                    AppIcons.rightArrow,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Container indicatorContainer(Color color) {
    return Container(
      height: 8.h,
      width: 14.w,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
    );
  }
}
