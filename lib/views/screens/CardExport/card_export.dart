
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../widgets/CustomCrossButton/custom_cross_button.dart';

class CardExportScreen extends StatelessWidget {
  CardExportScreen({super.key});

  List cardQrList = [
    {"qrImg" : AppImages.qr1Img, "title" : "Mohsin"},
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
                  const CustomCrossButton(),
                  CustomText(
                    text: AppStrings.cardExport,
                    color: AppColors.black_500,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w,)
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                  child: ListView.builder(
                    itemCount: cardQrList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 100.h,
                            width: Get.width,
                            child: Row(
                              children: [
                                Image.asset(cardQrList[index]["qrImg"]),
                                SizedBox(width: 8.w,),
                                CustomText(text: cardQrList[index]["title"])
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

