import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Helpers/prefs_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

// ignore: must_be_immutable
class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({super.key});

  final List locale = [
    {"name": "en", "countryCode": "US", "locale": const Locale("en", "US")},
    {"name": "zh", "countryCode": "CN", "locale": const Locale("zh", "CN")},
    {"name": "ja", "countryCode": "JP", "locale": const Locale("ja", "JP")}
  ];

  List languageList = [
    "English",
    "Chinese",
    "Japanese"
  ];
  RxInt selectedItem = 0.obs;
  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }


  @override
  Widget build(BuildContext context) {
    selectedItem.value =  PrefsHelper.localizationCountryCode == "US" ? 0 :  PrefsHelper.localizationCountryCode == "CN"? 1 : 2 ;
    // selectedItem.value = languageList.indexOf(PrefsHelper.localizationCountryCode);
    // print("selectedItem.value ${selectedItem.value}");
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
                    text: AppStrings.changeLanguage.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30.w),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                      children: List.generate(
                        languageList.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              selectedItem.value = index;
                              PrefsHelper.localizationCountryCode = locale[index]["countryCode"];
                              PrefsHelper.localizationLanguageCode = locale[index]["name"];
                              Get.updateLocale(locale[index]["locale"]);
                              PrefsHelper.setString(
                                  "localizationLanguageCode", PrefsHelper.localizationLanguageCode);
                              PrefsHelper.setString(
                                  "localizationCountryCode", PrefsHelper.localizationCountryCode);


                              if (kDebugMode) {
                                print(
                                  "Language is: ---------------->> ${locale[index]["name"]}, ${locale[index]["locale"]}");
                              }
                            },
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(.2),
                                          width: 1),
                                      color: index == selectedItem.value
                                          ? AppColors.green_900
                                          : AppColors.whiteColor,
                                    ),
                                  ),
                                  CustomText(
                                    text: languageList[index],
                                    color: AppColors.black_500,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    left: 16,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
            groupValue: selectedItem.value,
            activeColor: AppColors.black_400,
            fillColor: MaterialStateProperty.all(AppColors.black_400),
            splashRadius: 20,
            onChanged: (value) {
              selectedItem.value = value!.toInt();
            },
            visualDensity: VisualDensity(horizontal: -4, vertical: -2)),
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
