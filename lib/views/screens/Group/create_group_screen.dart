
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
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
                    text: AppStrings.createGroup,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: 30.w)
                ],
              ),
              SizedBox(height: 16.h),

              ///<<<================== Group Name Editing Field =================>>>

              TextFormField(
                decoration: InputDecoration(
                  hintText: AppStrings.enterGroupName,
                ),
              ),
              SizedBox(height: 16.h,),

              ///<<<=================== Select Cards Button ==================>>>
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.only(left: Get.width - 150),
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: AppColors.green_600,
                      border: Border.all(
                          color: AppColors.black_400
                      ),
                      borderRadius: BorderRadius.circular(4.r)
                  ),
                  child: Center(
                    child: CustomText(
                      text: AppStrings.selectCards,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 150.h,),
              Image.asset(AppImages.noData, height: 100, width: 100,),
              CustomText(
                text: AppStrings.noCardsSelected,
              )
            ],
          ),
        ),
      ),

      ///<<<=============== Create Group Button ==============================>>>

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: CustomElevatedButton(
            onTap: (){},
          text: AppStrings.createGroup,
          backgroundColor: AppColors.black_500,
        ),
      ),
    );
  }
}
