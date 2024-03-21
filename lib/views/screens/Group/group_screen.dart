
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(onTap: (){
                    Get.back();
                  },
                    icon: Icons.arrow_back,
                  ),
                  CustomText(
                    text: AppStrings.group,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  Container(
                    height: 26.h,
                    width: 65.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.black_400
                      ),
                      borderRadius: BorderRadius.circular(4.r)
                    ),
                    child: Center(
                      child: CustomText(
                        text: AppStrings.short,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 22.h,),
              CustomTextField(
                prefixIcon: const Icon(Icons.search),
                hintText: AppStrings.enterGroupName,
              )
            ],
          ),
        ),
      ),
    );
  }
}
