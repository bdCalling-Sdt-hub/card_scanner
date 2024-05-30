import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
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
import '../../widgets/customButton/custom_elevated_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../../widgets/custom_text_field/custom_text_field.dart';

class GroupContactDetailScreen extends StatelessWidget {
  GroupContactDetailScreen({super.key});

  StorageController phoneStorageController =
  Get.put(StorageController());
  ScrollController scrollController = ScrollController();

  int groupIndex = Get.arguments["groupIndex"];
  int contactIndex = Get.arguments["contactIndex"];

  RxBool isTapped = false.obs;




  @override
  Widget build(BuildContext context) {
    var contactDetails = phoneStorageController.groupedContactsList[groupIndex].contactsList[contactIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: contactDetails.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 180.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                            color: AppColors.green_600,
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: imageProvider,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          height: 180.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                            color: AppColors.green_600,
                            borderRadius:
                            BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() => GestureDetector(
                      onTap: () {
                        isTapped.value = !isTapped.value;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.green_600),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Scanned Images".tr,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            isTapped.value
                                ? Icon(
                              Icons.keyboard_arrow_down,
                            )
                                : Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    )),
                    Obx(() => isTapped.value
                        ? Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        contactDetails.capturedImageList != null
                            ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                contactDetails.capturedImageList!
                                    .length, (index) {
                              return CachedNetworkImage(
                                imageUrl: contactDetails.capturedImageList![index],
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 220,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: imageProvider,
                                      )),
                                ),
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => SizedBox(width: Get.width * 0.9, child: Icon(Icons.error)),
                              );
                            }),
                          ),
                        )
                            : Center(
                            child: CustomText(
                              text: "No image found".tr,
                            )),
                      ],
                    )
                        : SizedBox()),
                    SizedBox(height: 30.h),
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
                        title: AppStrings.mobile.tr,
                        value: contactDetails.mobilePhone),
                    contactDetails.landPhone != ""
                        ? customWrap(
                        title: "Telephone".tr,
                        value: contactDetails.landPhone!)
                        : SizedBox(),
                    contactDetails.fax != ""
                        ? customWrap(
                        title: "Fax".tr, value: contactDetails.fax!)
                        : SizedBox(),
                    contactDetails.website != ""
                        ? customWrap(
                        title: "Website".tr, value: contactDetails.website!)
                        : SizedBox(),
                    customWrap(
                        title: AppStrings.address.tr,
                        value: contactDetails.address),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                ),
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
