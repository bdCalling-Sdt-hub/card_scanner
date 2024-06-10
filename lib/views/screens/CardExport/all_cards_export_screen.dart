
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/Models/contacts_model.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AllCardsExportScreen extends StatelessWidget {
  AllCardsExportScreen({super.key});

  StorageController storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    storageController.isSelected = List.generate(storageController.contacts.length, (index) => false);
    return Scaffold(
      // bottomNavigationBar: BottomNavBar(currentIndex: 1),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: GetBuilder<StorageController>(builder: (storageController) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(onTap: () {
                      Get.back();
                      storageController.count = 0;
                      storageController.selectedContacts.clear();

                    },),
                    CustomText(
                      text: "${AppStrings.selectedItems.tr}: ${storageController.count}",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    InkWell(
                      onTap: () {
                        storageController.unSelectAll();
                      },
                      child: CustomText(
                        text: AppStrings.unselectAll.tr,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.green_800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                ///<<<================== Digital Card List ===================>>>

                Expanded(
                  child: storageController.contacts.isEmpty? Center(child: NoData()) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: storageController.contacts.length,
                    itemBuilder: (context, index) {
                      storageController.contacts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                      ContactsModel contacts = storageController.contacts[index];
                      return GestureDetector(
                        onTap: () {
                          storageController.toggleSelection(index: index);
                        },
                        child: Container(
                          margin: storageController.isSelected[index]? EdgeInsets.only(bottom: 4.h) : null,
                          padding: storageController.isSelected[index]? EdgeInsets.only(left: 4.w) : null,
                          width: Get.width,
                          height: 100.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: storageController.isSelected[index]? AppColors.green_900 : AppColors.transparentColor),
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: contacts.imageUrl,
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    image: DecorationImage(fit: BoxFit.fill,image: imageProvider,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: AppColors.green_600
                                  ),
                                  child: Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8.h,),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        text: contacts.name,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 4.h,),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        text: contacts.designation,
                                        fontSize: 14,
                                      ),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        text: contacts.companyName,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },),
                )
              ],
            );
          },),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.black_500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
        Get.toNamed(AppRoutes.cardExportScreen);
      },
        child: CustomText(text: AppStrings.export.tr, color: AppColors.green_300,),),
    );
  }
}
