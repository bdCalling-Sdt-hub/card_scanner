

import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomText(
                text: AppStrings.contacts,
                color: AppColors.black_500,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 48.h),
                child: Image.asset(
                    AppImages.contactsImage
                ),
              ),
              SizedBox(height: 12.h,),
              CustomText(
                text: AppStrings.currentlyNoContacts,
                color: AppColors.black_500,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 12.h,),
              CustomText(
                maxLines: 3,
                text: AppStrings.noContactsFoundTryAgain,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.black_400,
              ),
              SizedBox(height: 78.h,),
              CustomElevatedButton(
                  onTap: (){},
                height: 42.h,
                width: 130.w,
                text: AppStrings.goSearch,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                backgroundColor: AppColors.green_900,
                isFillColor: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
