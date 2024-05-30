import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/views/screens/home/InnerWidgets/manage_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/CustomBackButton/custom_back_button.dart';
import '../../../widgets/customButton/custom_elevated_button.dart';
import '../../../widgets/customText/custom_text.dart';

class CardHolder extends StatelessWidget {
  CardHolder({super.key,});

  @override
  Widget build(context) {
    return GetBuilder<StorageController>(
        builder:(storageController) {
          return storageController.isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.green_50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: storageController.contacts.isNotEmpty
                ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.cards.tr,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black_500,
                        fontSize: 16,
                      ),
                      CustomText(
                        text: "(${storageController.contacts.length})",
                      ),
                      const Spacer(),

                      ///<<<==================== Group Text =======================>>>

                      InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.groupScreen);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                AppIcons.groupIcon),
                            SizedBox(width: 4.w),
                            CustomText(
                              text: AppStrings.group.tr,
                            ),
                            SizedBox(width: 8.w),
                          ],
                        ),
                      ),
                      SvgPicture.asset(AppIcons.lineIcon),

                      ///<<<=============== Manage Text ===========================>>>

                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ManageModalSheet();
                            },
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 8.w),
                            SvgPicture.asset(
                                AppIcons.manageIcon),
                            SizedBox(width: 4.w),
                            CustomText(
                              text: AppStrings.manage.tr,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  child: SizedBox(
                    height: (150 * storageController.contacts.length).toDouble(),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: storageController.contacts.length,
                      itemBuilder: (context, index) {
                        return GetBuilder<StorageController>(builder: (controller) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.w),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.contactDetailsScreen, arguments: {"index" : index});
                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(4),
                                  color: AppColors.green_300,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                  ),
                                  child: Row(
                                    children: [
                                    CachedNetworkImage(
                                    imageUrl: storageController.contacts[index].imageUrl,
                                    imageBuilder: (context, imageProvider) => Container(
                                        margin: EdgeInsets.symmetric(vertical: 8.h),
                                        height: 100.h,
                                        width: 120.w,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                            image: imageProvider)
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Container(
                                      margin: EdgeInsets.symmetric(vertical: 8.h),
                                      height: 100.h,
                                      width: 120.w,
                                      child: Icon(Icons.error),
                                    ),
                                  ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          overflow: TextOverflow.ellipsis,
                                          text: storageController.contacts[index].name,
                                          color: AppColors.black_500,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {

                                          ///<<<================== Bottom Modal Sheet =========================>>>

                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 250,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(8.r),
                                                      topRight: Radius.circular(8.r),
                                                    ),
                                                    color: AppColors.green_50),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.centerRight,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: CustomBackButton(
                                                            onTap: (){
                                                              Get.back();
                                                            },
                                                            radius: 100,
                                                          ),
                                                        ),
                                                      ),
                                                      CustomText(
                                                        text: AppStrings.moreOptions.tr,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 24,
                                                      ),
                                                      SizedBox(
                                                        height: 20.h,
                                                      ),

                                                      ///<<<=============== Share Business Card ========================>>>

                                                      InkWell(
                                                        onTap: () {
                                                          Share.share("${storageController.contacts[index].name}, ${storageController.contacts[index].designation}, ${storageController.contacts[index].companyName}, ${storageController.contacts[index].mobilePhone}, ${storageController.contacts[index].email}, ${storageController.contacts[index].address}");

                                                          // showDialog(
                                                          //   context: context,
                                                          //   builder: (context) {
                                                          //     return AlertDialog(
                                                          //       surfaceTintColor:  AppColors.green_900,
                                                          //       contentPadding: EdgeInsets.zero,
                                                          //       shape: RoundedRectangleBorder(
                                                          //           borderRadius: BorderRadius.circular(8)),
                                                          //       content: Container(
                                                          //         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                                                          //         width: Get.width,
                                                          //         height: 200.h,
                                                          //         child: Column(
                                                          //           children: [
                                                          //             Align(
                                                          //               alignment: Alignment.centerRight,
                                                          //               child: CustomBackButton(
                                                          //                 onTap: (){
                                                          //                   Get.back();
                                                          //                 },
                                                          //                 radius: 100.r,
                                                          //               ),
                                                          //             ),
                                                          //             CustomText(
                                                          //               text: AppStrings.shareWith.tr,
                                                          //               fontSize: 20,
                                                          //               fontWeight: FontWeight.w500,
                                                          //             ),
                                                          //             SizedBox(height: 40.h,),
                                                          //             Padding(
                                                          //               padding: EdgeInsets.symmetric(horizontal: 20.w),
                                                          //               child: Row(
                                                          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          //                 children: [
                                                          //                   Container(
                                                          //                     height: 40.h,
                                                          //                     width: 40.w,
                                                          //                     decoration: BoxDecoration(
                                                          //                         color: AppColors.black_500,
                                                          //                         borderRadius: BorderRadius.circular(12.r)
                                                          //                     ),
                                                          //                     child: Center(child: SvgPicture.asset(AppIcons.linkedinIcon)),
                                                          //                   ),
                                                          //                   Container(
                                                          //                     height: 40.h,
                                                          //                     width: 40.w,
                                                          //                     decoration: BoxDecoration(
                                                          //                         color: AppColors.black_500,
                                                          //                         borderRadius: BorderRadius.circular(12.r)
                                                          //                     ),
                                                          //                     child: Center(child: SvgPicture.asset(AppIcons.fbIcon)),
                                                          //                   ),
                                                          //                   Container(
                                                          //                     height: 40.h,
                                                          //                     width: 40.w,
                                                          //                     decoration: BoxDecoration(
                                                          //                         color: AppColors.black_500,
                                                          //                         borderRadius: BorderRadius.circular(12.r)
                                                          //                     ),
                                                          //                     child: Center(child: SvgPicture.asset(AppIcons.emailIcon, color: AppColors.green_50,)),
                                                          //                   )
                                                          //                 ],
                                                          //               ),
                                                          //             )
                                                          //           ],
                                                          //         ),
                                                          //       ),
                                                          //     );
                                                          //   },
                                                          // );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.share),
                                                            SizedBox(width: 8.w),
                                                            CustomText(
                                                              text: AppStrings.shareBusinessCard.tr,
                                                              fontSize: 16,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        endIndent: 120,
                                                        color: AppColors.black_400,
                                                      ),
                                                      SizedBox(
                                                        height: 8.h,
                                                      ),

                                                      ///<<<==================== Remove AlertDialog Open ====================>>>
                                                      InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                surfaceTintColor:  AppColors.green_900,
                                                                contentPadding: EdgeInsets.zero,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8)),
                                                                content: SizedBox(
                                                                  width: Get.width,
                                                                  height: 185.h,
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(height: 40.h),
                                                                      CustomText(
                                                                        text: AppStrings.areYouSure.tr,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 20,
                                                                      ),
                                                                      SizedBox(height: 24.h),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          SizedBox(),
                                                                          ///<<<=============== Yes Button ================>>>

                                                                          CustomElevatedButton(
                                                                            onTap: () {
                                                                              storageController.deleteContact(storageController.contacts[index].id);
                                                                              Get.offAllNamed(AppRoutes.homeScreen);
                                                                            },
                                                                            text: AppStrings.yes.tr,
                                                                            height: 38,
                                                                            width: 64,
                                                                            isFillColor: true,
                                                                            backgroundColor: AppColors.black_500,
                                                                            borderRadius: 36,
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w400,
                                                                          ),

                                                                          ///<<<=============== No Button ================>>>
                                                                          CustomElevatedButton(
                                                                            onTap: () {
                                                                              Get.back();
                                                                            },
                                                                            text: AppStrings.no.tr,
                                                                            height: 38,
                                                                            width: 64,
                                                                            borderColor: AppColors.black_500,
                                                                            isFillColor: false,
                                                                            borderRadius: 36,
                                                                            textColor: AppColors.black_500,
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w400,
                                                                          ),
                                                                          SizedBox(),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.delete),
                                                            SizedBox(width: 8.w),
                                                            CustomText(
                                                              text: AppStrings.removeCard.tr,
                                                              fontSize: 16,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        endIndent: 120,
                                                        color: AppColors.black_400,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              AppIcons.threeDotIcon, fit: BoxFit.cover, height: 8, ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 42.h,
                ),
              ],
            ) : Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 16.h, left: 12.w),
                    child: CustomText(
                      text: AppStrings.cards.tr,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 74.h,
                        width: 74.w,
                        child:
                        Image.asset(AppImages.cardLogo)),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomText(
                      text: AppStrings.noCards.tr,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w),
                      child: CustomText(
                        maxLines: 3,
                        text: AppStrings
                            .useBusinessCardRecognitionFunction.tr,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 42.h,
                ),
              ],
            ),
          );
        },
    );
  }
}