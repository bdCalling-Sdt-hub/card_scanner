import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/customButton/custom_elevated_button.dart';

// ignore: must_be_immutable
class GroupScreen extends StatelessWidget {
  GroupScreen({super.key});

  StorageController storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StorageController>(
        builder: (storageController) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(
                        onTap: () {
                          Get.back();
                        },
                        icon: Icons.arrow_back,
                      ),
                      CustomText(
                        text: AppStrings.group.tr,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        width: 30.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22.h,
                  ),

                  ///<<<===================== Search Bar =========================>>>

                  // CustomTextField(
                  //   prefixIcon: const Icon(Icons.search),
                  //   hintText: AppStrings.enterGroupName,
                  // ),
                  //
                  // SizedBox(height: 8.h),

                  ///<<<================== Create Text Button ===================>>>

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.createGroupScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w),
                      height: 58.h,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: AppColors.green_600,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.black_400)),
                      child: Row(
                        children: [
                          const Icon(Icons.add),
                          SizedBox(width: 12.w),
                          CustomText(
                            text: AppStrings.createNewGroup.tr,
                            color: AppColors.black_500,
                            fontSize: 16,
                          )
                        ],
                      ),
                    ),
                  ),

                  ///<<<================== Recently Added Text ===================>>>
                  SizedBox(height: 16.h),
                  GetBuilder<StorageController>(
                    builder: (storageController) {
                      return CustomText(
                        text: storageController.groupedContactsList.isEmpty? "${AppStrings.recentlyAdded.tr} (0)" :
                            "${AppStrings.recentlyAdded.tr} (${storageController.groupCount})",
                        fontSize: 16,
                        color: AppColors.black_400,
                      );
                    },
                  ),
                  const Divider(
                    color: AppColors.black_400,
                  ),
                  // CustomText(
                  //   text:
                  //       "${AppStrings.unGrouped.tr} (${PrefsHelper.unGroupedContacts})",
                  //   fontSize: 16,
                  //   color: AppColors.black_400,
                  // ),

                  ///<<<================== New Group Created ====================>>>
                  SizedBox(height: 12.h),
                  CustomText(text:"${"Groups".tr}:", fontSize: 16, fontWeight: FontWeight.w500,),
                  SizedBox(height: 16.h),
                  storageController.groupedContactsList.isEmpty
                      ? Center(child: CustomText(text: "No Groups Created".tr,))
                      : Expanded(
                    child: GetBuilder<StorageController>(builder: (storageController) {
                      storageController.groupedContactsList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                      return storageController.isLoading? Center(child: CircularProgressIndicator()) : ListView.builder(
                        itemCount: storageController.groupedContactsList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PrefsHelper.getGroupedList().then((value) {
                                storageController.groupedContactsList = value;
                                storageController.reloadGroupContacts(index: index, groupContactList: storageController.groupedContactsList[index].contactsList);
                                Get.toNamed(AppRoutes.selectedGroupCards, arguments: {'index' : index});
                              }, );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.only(left: 10.w),
                              height: 58.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: AppColors.green_600,
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                  Border.all(color: AppColors.black_400)),
                              child: Row(
                                children: [
                                  const Icon(Icons.groups),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: CustomText(
                                      textAlign: TextAlign.left,
                                      text: storageController.groupedContactsList[index].name,
                                      color: AppColors.black_500,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  // InkWell(
                                  //   onTap: (){
                                  //
                                  //   },
                                  //   child: Container(
                                  //     height: 30.h,
                                  //     width: 30.w,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(100),
                                  //     ),
                                  //     child: Icon(Icons.border_color_outlined, size: 18,color: AppColors.black_500),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (context) {

                                          ///<<<==================== Delete group pop up =========================>>>

                                          return AlertDialog(
                                            content: CustomText(text: "Are you sure to delete contacts?".tr, fontSize: 20, color: AppColors.black_500,),
                                            actions: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomElevatedButton(
                                                      onTap: (){
                                                        Get.back();
                                                      },
                                                      text: "No".tr,
                                                      height: 48.h,
                                                      textColor: AppColors.black_500,
                                                      isFillColor: false,
                                                      borderColor: AppColors.green_900,
                                                    ),
                                                  ),
                                                  SizedBox(width: 12.w,),
                                                  Expanded(
                                                    child: CustomElevatedButton(
                                                      onTap: (){
                                                        Get.back();
                                                        storageController.deleteGroupRepo(index: index);
                                                      },
                                                      text: "Yes".tr,
                                                      height: 48.h,
                                                      backgroundColor: AppColors.green_900,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Icon(Icons.delete_forever_rounded, size: 22,color: AppColors.black_500),
                                    ),
                                  ),
                                  SizedBox(width: 8.w,),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
