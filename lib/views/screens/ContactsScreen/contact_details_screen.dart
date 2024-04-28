import 'dart:io';

import 'package:card_scanner/Models/contacts_model.dart';
import 'package:card_scanner/controllers/phone_storage_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

class ContactDetailsScreen extends StatelessWidget {
  ContactDetailsScreen({super.key});

  PhoneStorageController phoneStorageController =
      Get.put(PhoneStorageController());

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
                  children: [
                    Image.file(File(contactDetails.imageUrl)),
                    SizedBox(height: 20.h),
                    customRow(
                        title: AppStrings.name, value: contactDetails.name),
                    customRow(
                        title: AppStrings.designation,
                        value: contactDetails.designation),
                    customRow(
                        title: AppStrings.companyName,
                        value: contactDetails.companyName),
                    customRow(
                        title: AppStrings.email, value: contactDetails.email),
                    customRow(
                        title: AppStrings.phoneNumber,
                        value: contactDetails.phoneNumber),
                    customRow(
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

  Row customRow({required String title, required String value}) {
    return Row(
      children: [
        CustomText(
          text: "$title: ",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        CustomText(
          text: value,
          fontSize: 16,
        )
      ],
    );
  }
}
