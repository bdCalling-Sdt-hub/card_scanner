import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

// ignore: must_be_immutable
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
  // RxInt selectedIndex = 20.obs;

  void launchURL() async {
    final Uri url = Uri.parse('https://sites.google.com/view/name-card-scanner-qna/home?authuser=1');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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

                CustomText(
                  text: "Please tap on the given below link to get the FAQs:".tr,
                ),
                InkWell(
                  onTap: () {
                    launchURL();
                  },
                  child: CustomText(
                    top: 32,
                    fontWeight: FontWeight.w600,
                    textDecoration: TextDecoration.underline,
                    text: "Name Card FAQs",
                    color: Colors.blue,
                  ),
                )

                // Column(
                //   children: List.generate(questionList.length, (index) {
                //     return Column(
                //       children: [
                //         InkWell(
                //           onTap: (){
                //             selectedIndex.value = index;
                //           },
                //           child: Row(
                //             children: [
                //               CustomText(
                //                 text: questionList[index],
                //                 fontSize: 16,
                //               ),
                //               Spacer(),
                //               Icon(
                //                 index == selectedIndex.value? Icons.keyboard_arrow_down : Icons.arrow_forward_ios ,
                //                 size: 20,
                //               )
                //             ],
                //           ),
                //         ),
                //         SizedBox(height: 8.h,),
                //         Divider(),
                //         SizedBox(height: 8.h,),
                //         if(index == selectedIndex.value)
                //           Container(
                //             margin: EdgeInsets.only(bottom: 12.h),
                //             padding: EdgeInsets.all(16.w),
                //             decoration: BoxDecoration(
                //                 color: AppColors.green_100,
                //                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(4))
                //             ),
                //             child: CustomText(
                //               maxLines: 10,
                //               text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book",),)
                //       ],
                //     );
                //   }),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
