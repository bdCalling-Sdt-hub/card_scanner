
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    child: Column(
      children: [
        Row(
          children: [
            CustomBackButton(onTap: (){
              Get.back();
            }),
            Align(
              alignment: Alignment.center,
              child: CustomText(
                text: AppStrings.contactDetails,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    ),
      ),
      ),
    );
  }
}
