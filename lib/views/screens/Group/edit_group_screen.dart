

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/screens/Group/card_selection_screen.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

// ignore: must_be_immutable
class EditGroupScreen extends StatelessWidget {
  EditGroupScreen({super.key});

  int groupIndex = Get.arguments['groupIndex'];

  StorageController storageController = Get.put(StorageController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(onTap: (){
                    Get.back();
                    Future.delayed(Duration(seconds: 1), () {
                      storageController.groupNameController.clear();
                      storageController.selectedGroupContacts.clear();
                    },);
                  },
                    icon: Icons.arrow_back,
                  ),
                  CustomText(
                    text: "Edit Group".tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: 30.w)
                ],
              ),
              SizedBox(height: 16.h),

              ///<<<================== Group Name Field =================>>>

              TextFormField(
                controller: storageController.groupNameController,
                decoration: InputDecoration(
                  labelText: AppStrings.enterGroupName.tr,
                  labelStyle: TextStyle(color: AppColors.black_200),
                ),
              ),
              SizedBox(height: 16.h,),

              ///<<<=================== Select Cards Button ==================>>>
              GestureDetector(
                onTap: (){
                  storageController.loadContacts().then((value) {
                    Get.to(CardSelectionScreen());
                  },);
                },
                child: Container(
                  margin: EdgeInsets.only(left: Get.width - 150),
                  height: 32.h,
                  decoration: BoxDecoration(
                      color: AppColors.green_600,
                      border: Border.all(
                          color: AppColors.black_400
                      ),
                      borderRadius: BorderRadius.circular(4.r)
                  ),
                  child: Center(
                    child: CustomText(
                      text: AppStrings.selectCards.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Obx(() {
                return storageController.selectedGroupContacts.isEmpty
                    ? Column(
                  children: [
                    SizedBox(height: 150.h,),
                    Image.asset(AppImages.noData, height: 100, width: 100,),
                    CustomText(
                      text: AppStrings.noCardsSelected.tr,
                    ),
                  ],
                )
                    : Column(
                  children: List.generate(
                      storageController.selectedGroupContacts.length,
                          (index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 4.h),
                          width: Get.width,
                          height: 100.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: storageController.selectedGroupContacts
                                      .contains(index)
                                      ? AppColors.green_900
                                      : AppColors.transparentColor),
                              borderRadius:
                              BorderRadius.circular(12.r)),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: storageController.selectedGroupContacts[index].imageUrl,
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8.r),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                    height: 90.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                        color: AppColors.green_600
                                    ),
                                    child: Center(child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) => Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8.r),
                                      color: AppColors.green_600
                                  ),
                                  child: Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          text: storageController
                                              .selectedGroupContacts[
                                          index]
                                              .name,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4,),
                                      Expanded(
                                        child: CustomText(
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          text: storageController
                                              .selectedGroupContacts[
                                          index]
                                              .designation,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          text: storageController
                                              .selectedGroupContacts[
                                          index]
                                              .companyName,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///<<<================ Edit Icon ================>>>
                            ],
                          ),
                        );
                      }),
                );
              },)
            ],
          ),
        ),
      ),

      ///<<<=============== Edit Group Button ==============================>>>

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: CustomElevatedButton(
          onTap: () async {
            storageController.upDateGroupContactRepo(groupIndex: groupIndex);
          },
          text: "Save Group".tr,
          backgroundColor: AppColors.black_500,
        ),
      ),
    );
  }
}