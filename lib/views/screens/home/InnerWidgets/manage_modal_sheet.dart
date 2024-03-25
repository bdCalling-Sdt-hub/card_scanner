
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../widgets/CustomBackButton/custom_back_button.dart';

class ManageModalSheet extends StatelessWidget {
  const ManageModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          ),
          color: AppColors.green_50),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CustomBackButton(
                  onTap: (){
                    Get.back();
                  },
                  radius: 100,
                ),
              ),
            ),
            SizedBox(height: 24.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                manageCards(Icons.add, AppStrings.createCard),
                manageCards(Icons.filter_center_focus_outlined, AppStrings.scanQrCode),
                manageCards(Icons.credit_card_outlined, AppStrings.duplicateCards),
                SizedBox()
              ],
            ),
            SizedBox(height: 12.h),
            Divider(
              color: AppColors.black_400,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: AppStrings.changeShortType,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            Row(
              children: [
                // RadioMenuButton(value: value, groupValue: groupValue, onChanged: onChanged, child: child)
              ],
            )
          ],
        ),
      ),
    );
  }

  Container manageCards(IconData icon, String text) {
    return Container(
                padding: EdgeInsets.only(top: 8),
                height: 72.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.green_600)
                ),
                child: Column(
                  children: [
                    Container(
                      height: 25.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.black_500),
                      ),
                      child: Center(child: Icon(icon, size: 20,)),
                    ),
                    CustomText(
                      maxLines: 2,
                      text: text,
                      fontSize: 12,
                    )
                  ],
                ),
              );
  }
}
