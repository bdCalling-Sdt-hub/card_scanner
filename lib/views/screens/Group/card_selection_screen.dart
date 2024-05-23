import 'dart:io';

import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/customButton/custom_elevated_button.dart';
import '../../widgets/no_data.dart';
import 'create_group_screen.dart';

class CardSelectionScreen extends StatefulWidget {
  const CardSelectionScreen({super.key});

  @override
  State<CardSelectionScreen> createState() => _CardSelectionScreenState();
}

class _CardSelectionScreenState extends State<CardSelectionScreen> {
  // List cardDetailsList = [
  StorageController storageController = Get.put(StorageController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30.h),
                  // CustomBackButton(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   icon: Icons.arrow_back,
                  // ),
                  CustomText(
                    text: AppStrings.selectContacts.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(width: 30.h),
                ],
              ),
              SizedBox(height: 20.h),

              ///<<<================== Digital Card List ===================>>>

              GetBuilder<StorageController>(builder: (storageController) {
                return storageController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : storageController.allContactsForGroup.isEmpty
                    ? Center(child: NoData())
                    : Expanded(
                        child: ListView.builder(
                          itemCount:
                              storageController.allContactsForGroup.length,
                          itemBuilder: (context, index) {
                            storageController.allContactsForGroup.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                            List<bool> isSelect = List.generate(
                                storageController.allContactsForGroup.length,
                                (index) => false);
                            return Obx(() => GestureDetector(
                                  onTap: () {
                                    isSelect[index] = !isSelect[index];
                                    if (isSelect[index]) {
                                      storageController.selectedGroupContacts.add(storageController.allContactsForGroup[index]);
                                      if (kDebugMode) {
                                        print("storageController.selectedGroupContacts: ${storageController.selectedGroupContacts}");
                                      }

                                    } else {
                                      storageController.selectedGroupContacts.remove(storageController.allContactsForGroup[index]);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 4.h),
                                    padding: storageController.selectedGroupContacts
                                        .contains(storageController.allContactsForGroup[index])? EdgeInsets.only(left: 4.w) : null,
                                    width: Get.width,
                                    height: 100.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: storageController.selectedGroupContacts
                                                    .contains(storageController.allContactsForGroup[index])
                                                ? AppColors.green_900
                                                : AppColors.transparentColor),
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 90.h,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(
                                                    storageController
                                                        .allContactsForGroup[
                                                            index]
                                                        .imageUrl))),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Flexible(
                                                  child: CustomText(
                                                    overflow: TextOverflow.ellipsis,
                                                    text: storageController
                                                        .allContactsForGroup[
                                                            index]
                                                        .name,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 4,),
                                                CustomText(
                                                  overflow: TextOverflow.ellipsis,
                                                  text: storageController
                                                      .allContactsForGroup[
                                                          index]
                                                      .designation,
                                                  fontSize: 12,
                                                ),
                                                CustomText(
                                                  overflow: TextOverflow.ellipsis,
                                                  text: storageController
                                                      .allContactsForGroup[
                                                          index]
                                                      .companyName,
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),


                                        ///<<<================ Edit Icon ================>>>
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      );
              }),
            ],
          ),
        ),
      ),

      ///<<<=============== Create Group Button ==============================>>>

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: CustomElevatedButton(
          onTap: () {
            // storageController.addMultipleSelectedContacts(storageController.selectedGroupContacts);
            // storageController.selectedGroupContacts.addAll(storageController.tempoContactsList);
            Get.back();
          },
          text: AppStrings.saveNBack.tr,
          backgroundColor: AppColors.black_500,
        ),
      ),
    );
  }
}
