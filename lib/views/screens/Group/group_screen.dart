import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                        text:
                            "${AppStrings.recentlyAdded.tr} (${storageController.groupCount})",
                        fontSize: 16,
                        color: AppColors.black_400,
                      );
                    },
                  ),
                  const Divider(
                    color: AppColors.black_400,
                  ),
                  CustomText(
                    text:
                        "${AppStrings.unGrouped.tr} (${storageController.unGroupedContacts})",
                    fontSize: 16,
                    color: AppColors.black_400,
                  ),

                  ///<<<================== New Group Created ====================>>>
                  SizedBox(height: 32.h),
                  Expanded(
                    child: GetBuilder<StorageController>(builder: (storageController) {
                      return storageController.isLoading? Center(child: CircularProgressIndicator()) : ListView.builder(
                        itemCount: storageController.groupedContactsList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PrefsHelper.getGroupedList().then((value) {
                                storageController.groupedContactsList = value;
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
                                  CustomText(
                                    text:
                                    "${AppStrings.group.tr}: ${storageController.groupedContactsList[index].name}",
                                    color: AppColors.black_500,
                                    fontSize: 16,
                                  )
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
