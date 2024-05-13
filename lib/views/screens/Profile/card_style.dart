
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/customText/custom_text.dart';

class CardStyleScreen extends StatelessWidget {
  CardStyleScreen({super.key});

  PageController pageController = PageController();

  List cardColorList = [
    AppColors.ashColor,
    AppColors.deepAshColor,
    AppColors.greenColor,
    AppColors.deepRedColor,
    AppColors.blackColor,
    AppColors.whitishColor
  ];

  RxInt currentPosition = 0.obs;

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
                      onTap: (){Get.back();},
                    icon: Icons.arrow_back,
                  ),
                  CustomText(text: AppStrings.cardStyle.tr, fontSize: 20, fontWeight: FontWeight.w500,),
                  SizedBox(width: 30,)
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            SizedBox(
              height: 255.h,
              width: Get.width,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: cardColorList.length,
                onPageChanged: (value) {
                  if (kDebugMode) {
                    print("===============$value");
                  }
                  currentPosition.value = value;
                },
                itemBuilder: (context, index) {
                  return Container(
                    width: Get.width,
                    color: cardColorList[index],
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Mostain Billah",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: currentPosition.value == 5? AppColors.black_500 : AppColors.green_50,
                                  ),
                                  CustomText(
                                    text: "Ui-Ux Designer",
                                    color: currentPosition.value == 5? AppColors.black_500 : AppColors.green_50,
                                  ),
                                  CustomText(
                                    text: "Sparktech.agency",
                                    fontSize: 18,
                                    color: currentPosition.value == 5? AppColors.black_500 : AppColors.green_50,
                                  ),
                                ],
                              ),
                              Spacer(),

                              ///<<<================= Company Logo ================>>>

                              Container(
                                height: 52.h,
                                width: 52.w,
                                decoration: BoxDecoration(
                                  color: AppColors.green_500,
                                  borderRadius: BorderRadius.circular(4),
                                  border: currentPosition.value == 5? Border.all(color: AppColors.black_500) : null,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(AppImages.nameCardLogo),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          ///<<<================= Profile Picture ================>>>

                          Container(
                            height: 120.w,
                            width: 120.w,
                            decoration: BoxDecoration(
                              border: currentPosition.value == 5? Border.all(color: AppColors.black_500) : null,
                              image: DecorationImage(
                                image: NetworkImage("https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1711008338~exp=1711011938~hmac=3a05225c2a75c0c003c9f09d51c3fbb6cda1d0189f31e94c8f72555a28854f63&w=826"),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              margin: EdgeInsets.only(bottom: Get.height * 0.15),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  indicatorContainer(
                      currentPosition.value == 0
                          ? AppColors.black_500
                          : AppColors.black_300),
                  SizedBox(width: 8.w),
                  indicatorContainer(
                      currentPosition.value == 1
                          ? AppColors.black_500
                          : AppColors.black_300),
                  SizedBox(width: 8.w),
                  indicatorContainer(
                      currentPosition.value == 2
                          ? AppColors.black_500
                          : AppColors.black_300),
                  SizedBox(width: 8.w),
                  indicatorContainer(
                      currentPosition.value == 3
                          ? AppColors.black_500
                          : AppColors.black_300),
                  SizedBox(width: 8.w),
                  indicatorContainer(
                      currentPosition.value == 4
                          ? AppColors.black_500
                          : AppColors.black_300),
                  SizedBox(width: 8.w),
                  indicatorContainer(
                      currentPosition.value == 5
                          ? AppColors.black_500
                          : AppColors.black_300),
                ],
              )),
            ),
          ],
        ),
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
