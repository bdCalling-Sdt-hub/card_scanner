import 'dart:io';


import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class ContactDetailsScreen extends StatelessWidget {
  ContactDetailsScreen({super.key});

  StorageController phoneStorageController =
      Get.put(StorageController());

  int index = Get.arguments["index"];

  @override
  Widget build(BuildContext context) {
    var contactDetails = phoneStorageController.contacts[index];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                      text: AppStrings.contactDetails,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 250,
                    //   width: Get.width,
                    //   child: PhotoView(
                    //       imageProvider: FileImage(File(contactDetails.imageUrl))),
                    // ),
                    Container(
                      height: 250,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                            image: FileImage(File(contactDetails.imageUrl)))
                      ),
                    ),
                    SizedBox(height: 20.h),
                    customWrap(
                        title: AppStrings.name, value: contactDetails.name),
                    customWrap(
                        title: AppStrings.designation,
                        value: contactDetails.designation),
                    customWrap(
                        title: AppStrings.companyName,
                        value: contactDetails.companyName),
                    customWrap(
                        title: AppStrings.email, value: contactDetails.email),
                    customWrap(
                        title: AppStrings.phoneNumber,
                        value: contactDetails.phoneNumber),
                    customWrap(
                        title: AppStrings.address,
                        value: contactDetails.address),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Wrap customWrap({required String title, required String value}) {
    return Wrap(
      children: [
        CustomText(
          text: "$title: ",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(width: 8.w,),
        CustomText(
          maxLines: 5,
          text: value,
          fontSize: 16,
          color: AppColors.green_900,
        )
      ],
    );
  }
}
