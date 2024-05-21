import 'dart:io';

import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class ContactDetailsScreen extends StatelessWidget {
  ContactDetailsScreen({super.key});

  StorageController phoneStorageController = Get.put(StorageController());

  int index = Get.arguments["index"];

  @override
  Widget build(BuildContext context) {
    var contactDetails = phoneStorageController.contacts[index];

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
                        icon: Icons.arrow_back,
                        onTap: () {
                          Get.back();
                        }),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: AppStrings.contactDetails.tr,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (phoneStorageController.selectedContacts.isEmpty) {
                          phoneStorageController.selectedContacts
                              .add(contactDetails);
                        }
                        Get.toNamed(AppRoutes.cardExportScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.blackColor,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 4.w,
                            ),
                            Icon(
                              Icons.qr_code_2,
                              size: 16,
                              color: AppColors.whiteColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                              text: "Qr Export".tr,
                              fontSize: 14,
                              color: AppColors.whiteColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                          color: AppColors.green_600,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(File(contactDetails.imageUrl))),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    customWrap(
                        title: AppStrings.name.tr, value: contactDetails.name),
                    customWrap(
                        title: AppStrings.designation.tr,
                        value: contactDetails.designation),
                    customWrap(
                        title: AppStrings.company.tr,
                        value: contactDetails.companyName),
                    customWrap(
                        title: AppStrings.email.tr,
                        value: contactDetails.email),
                    customWrap(
                        title: AppStrings.contact.tr,
                        value: contactDetails.phoneNumber),
                    customWrap(
                        title: AppStrings.address.tr,
                        value: contactDetails.address),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row customWrap({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100.w,
          child: CustomText(
            textAlign: TextAlign.left,
            text: "$title: ",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: CustomText(
            textAlign: TextAlign.left,
            maxLines: 5,
            text: value,
            fontSize: 16,
            color: AppColors.green_900,
          ),
        )
      ],
    );
  }
}
