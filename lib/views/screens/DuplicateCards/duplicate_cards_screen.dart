
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class DuplicateCardsScreen extends StatelessWidget {
  DuplicateCardsScreen({super.key});

  List cardQrList = [
    {"qrImg" : AppImages.qr1Img, "title" : "Mohsin"},
    {"qrImg" : AppImages.qr1Img, "title" : "Mohsin"},
    {"qrImg" : AppImages.qr1Img, "title" : "Cool"},
    {"qrImg" : AppImages.qr1Img, "title" : "Cool"},
    {"qrImg" : AppImages.qr1Img, "title" : "Frozen"},
  ];

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
                    onTap: () {Get.back();},
                    icon: Icons.arrow_back,
                  ),
                  CustomText(
                    text: AppStrings.manageDuplicateCards,
                    color: AppColors.black_500,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w,)
                ],
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 32.h, left: 16.w, right: 16.w),
                  child: ListView.builder(
                    itemCount: cardQrList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 100.h,
                            width: Get.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(cardQrList[index]["qrImg"]),
                                SizedBox(width: 8.w,),
                                CustomText(text: cardQrList[index]["title"], fontSize: 20),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4.h),
                                  child: Icon(Icons.delete_forever_rounded, size: 24),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
