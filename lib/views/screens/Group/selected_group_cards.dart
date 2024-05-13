
import 'dart:io';

import 'package:card_scanner/Models/contacts_model.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:flutter/material.dart';


import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';

class SelectedGroupCards extends StatelessWidget {
  SelectedGroupCards({super.key});

  int listIndex = Get.arguments['index'];
  StorageController storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:CustomBackButton(
                  onTap: (){
                    Get.back();
                  },
                  icon: Icons.arrow_back,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Icon(Icons.groups),
                  SizedBox(width: 12.w),
                  CustomText(
                    text: "${AppStrings.group.tr}: ${storageController.groupedContactsList[listIndex].name}",
                    color: AppColors.black_500,
                    fontSize: 16,
                  )
                ],
              ),
              const Divider(color: AppColors.black_400),
              SizedBox(height: 20.h),

              ///<<<=================== Cards List ========================>>>

              Expanded(
                child: ListView.builder(
                  itemCount: storageController.groupedContactsList[listIndex].contactsList.length,
                  itemBuilder: (context, index) {
                    List<ContactsModel> contactsList = storageController.groupedContactsList[listIndex].contactsList;
                    return Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r)
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 90.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(fit: BoxFit.cover,image: FileImage(File(contactsList[index].imageUrl))),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.h,),
                                  CustomText(
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    text: contactsList[index].name,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 4.h,),
                                  CustomText(
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    text: contactsList[index].designation,
                                    fontSize: 12,
                                  ),
                                  CustomText(
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    text: contactsList[index].companyName,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}

