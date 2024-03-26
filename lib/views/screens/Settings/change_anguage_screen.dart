
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({super.key});

  List languageList = ["English", "German", "Malay", "Bangla"];
  RxInt selectedOption = 0.obs;

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
                    text: AppStrings.changeLanguage,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30),
                ],
              ),
              SizedBox(height: 20,),

              Obx(() => Column(
                children: List.generate(
                  languageList.length,
                      (index) => SizedBox(
                    child: Column(
                      children: [
                        SizedBox(height: 12.h),
                        cardShortSelection(index, languageList[index]),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
  Row cardShortSelection(int value, String text) {
    return Row(
      children: [
        Radio<int>(

            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            groupValue: selectedOption.value,
            activeColor: AppColors.black_400,
            fillColor: MaterialStateProperty.all(AppColors.black_400),
            splashRadius: 20,
            onChanged: (value) {
              selectedOption.value = value!.toInt();
            },
            visualDensity: VisualDensity(horizontal: -4, vertical: -2)
        ),
        SizedBox(width: 12.w),
        CustomText(
          text: text,
          fontSize: 16,
          color: AppColors.black_500,
        )
      ],
    );
  }
}
