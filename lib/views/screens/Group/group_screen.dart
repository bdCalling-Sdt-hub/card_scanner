
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

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
                  SizedBox(width: 30.h,),
                ],
              ),
              SizedBox(height: 22.h,),

              ///<<<===================== Search Bar =========================>>>

              CustomTextField(
                prefixIcon: const Icon(Icons.search),
                hintText: AppStrings.enterGroupName,
              ),

              SizedBox(height: 8.h),

              ///<<<================== Create Text Button ===================>>>

              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.createGroupScreen);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10.w),
                  height: 58.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.green_600,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.black_400)
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      SizedBox(width: 12.w),
                      CustomText(
                        text: AppStrings.createNewGroup,
                        color: AppColors.black_500,
                        fontSize: 16,
                      )
                    ],
                  ),
                ),
              ),

              ///<<<================== Recently Added Text ===================>>>
              SizedBox(height: 16.h),
              CustomText(
                text: "${AppStrings.recentlyAdded}(0)",
                fontSize: 16,
                color: AppColors.black_400 ,
              ),
              const Divider(color: AppColors.black_400,),
              CustomText(
                text: "${AppStrings.unGrouped}(0)",
                fontSize: 16,
                color: AppColors.black_400 ,
              ),

              ///<<<================== New Group Created ====================>>>
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.selectedGroupCards);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10.w),
                  height: 58.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors.green_600,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.black_400)
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.groups),
                      SizedBox(width: 12.w),
                      CustomText(
                        text: "${AppStrings.group}: ${AppStrings.alpha}",
                        color: AppColors.black_500,
                        fontSize: 16,
                      )
                    ],
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
