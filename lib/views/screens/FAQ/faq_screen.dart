import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});

  List questionList = [
    AppStrings.redeemPremiumCode,
    AppStrings.resetMyLoginPassword,
    AppStrings.setTheRecognitionLanguages,
    AppStrings.supportForProblemsQuestions,
    AppStrings.syncPhoneCardsCamCardCloud,
    AppStrings.phoneWiFiConnectionSyncFailed,
  ];
  RxBool isTapped = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
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
                      text: AppStrings.faq,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    SizedBox(width: 30),
                  ],
                ),
                SizedBox(height: 40.h),
            
                ///<<<================ Question List =======================>>>
            
                Column(
                  children: List.generate(questionList.length, (index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: questionList[index],
                              fontSize: 16,
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                isTapped.value = !isTapped.value;
                              },
                              child: Icon(
                                isTapped.value? Icons.keyboard_arrow_down : Icons.arrow_forward_ios ,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8.h,),
                        Divider(),
                        SizedBox(height: 8.h,),
                        if(isTapped.value)
                          Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                                color: AppColors.green_100,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(4))
                            ),
                            child: CustomText(
                              maxLines: 10,
                              text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",),)
            
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
