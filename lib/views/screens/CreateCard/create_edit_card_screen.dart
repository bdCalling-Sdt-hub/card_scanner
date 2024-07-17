
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customText/custom_text.dart';

// ignore: must_be_immutable
class CreateOrEditCardScreen extends StatelessWidget {
  CreateOrEditCardScreen({super.key, required this.screenTitle});

  StorageController storageController = Get.put(StorageController());
  OCRCreateCardController ocrCreateCardController =
      Get.put(OCRCreateCardController());

  ScrollController scrollController = ScrollController();

  final String screenTitle;
  RxBool isTapped = false.obs;

  void addItem() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<StorageController>(
          builder: (storageController) {
            return storageController.isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    controller: scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackButton(
                              onTap: () {
                                if (screenTitle == AppStrings.createCardTitle) {
                                  Get.toNamed(AppRoutes.homeScreen);
                                } else {
                                  Get.toNamed(AppRoutes.allCardsScreen);
                                }
                                storageController.clearControllers();
                              },
                              icon: Icons.arrow_back,
                            ),
                            CustomText(
                              text: screenTitle.tr,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            SizedBox(width: 30),
                          ],
                        ),

                        ///<<<=============== Profile Picture =========================>>>
                        SizedBox(height: 20.h),
                        Stack(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  isTapped.value = !isTapped.value;
                                },
                                child: isTapped.value
                                    ? CustomCachedNetworkImage()
                                    : CachedNetworkImage(
                                        imageUrl:
                                            "${StorageController.imagePath}",
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 150.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.green_600,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: imageProvider),
                                          ),
                                        ),
                                        placeholder: (context, url) => SizedBox(
                                            height: 150.h,
                                            width: 150.w,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator())),
                                        errorWidget:
                                            (context, url, error) =>
                                                Container(
                                          height: 150.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.green_600,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                              ),
                            ),

                            ///<<<================ Edit Icon ==========================>>>

                            Positioned(
                              bottom: 5.h,
                              right: 5.w,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.all(4.w),
                                        backgroundColor:
                                            AppColors.green_700,
                                        content: Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    storageController
                                                        .getGalleryImage();
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 8.h),
                                                    height: 70,
                                                    width: 70,
                                                    decoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8),
                                                      color: AppColors
                                                          .green_600,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons
                                                            .image_outlined),
                                                        CustomText(
                                                          text:
                                                              "Gallery".tr,
                                                          fontSize: 16,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                InkWell(
                                                  onTap: () {
                                                    storageController
                                                        .getCameraImage();
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 8.h),
                                                    height: 70,
                                                    width: 70,
                                                    decoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8),
                                                      color: AppColors
                                                          .green_600,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppIcons
                                                              .ocrCameraIcon,
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                        CustomText(
                                                          text: "Camera".tr,
                                                          fontSize: 16,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(AppRoutes
                                                        .linkedInWebViewScreen);
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: SizedBox(
                                                            height: 200,
                                                            child: Column(
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child: CustomBackButton(onTap:
                                                                        () {
                                                                      Get.back();
                                                                    })),
                                                                SizedBox(
                                                                  height:
                                                                      20,
                                                                ),
                                                                CustomText(
                                                                  fontSize:
                                                                      16,
                                                                  maxLines:
                                                                      5,
                                                                  text: "Google & Apple SignIn doesn't support in web view, So don't try"
                                                                      .tr,
                                                                ),
                                                                CustomText(
                                                                  fontSize:
                                                                      18,
                                                                  text: "'Continue with Google & Sign in with Apple'"
                                                                      .tr,
                                                                  maxLines:
                                                                      3,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .green_900,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                    // Get.snackbar("Google Sign In does not support web view, So don't try 'Continue with Google'".tr, "",
                                                    //   duration: Duration(seconds: 3),
                                                    //   colorText: AppColors.green_900,
                                                    // );
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 8.h),
                                                    height: 70,
                                                    width: 75,
                                                    decoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8),
                                                      color: AppColors
                                                          .green_600,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppIcons
                                                              .linkedinIcon,
                                                          height: 20,
                                                          width: 20,
                                                          color: AppColors
                                                              .black_500,
                                                        ),
                                                        CustomText(
                                                          text:
                                                              "LinkedIn".tr,
                                                          fontSize: 16,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(AppRoutes
                                                        .googleWebViewScreen);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 8.h),
                                                    height: 70,
                                                    width: 70,
                                                    decoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(8),
                                                      color: AppColors
                                                          .green_600,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppIcons
                                                              .googleColorfulIcon,
                                                          height: 20,
                                                          width: 20,
                                                          color: AppColors
                                                              .black_500,
                                                        ),
                                                        CustomText(
                                                          text: "Google".tr,
                                                          fontSize: 16,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100),
                                      color: AppColors.green_300),
                                  child: Icon(Icons.border_color_outlined,
                                      size: 20),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 12.h,
                        ),

                        TextFormField(
                          controller: StorageController.nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "full name is required".tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: AppStrings.fullName.tr,
                              labelStyle:
                                  TextStyle(color: AppColors.black_200)),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          controller:
                              StorageController.designationController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Designation is required".tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: AppStrings.designation.tr,
                            labelStyle:
                                TextStyle(color: AppColors.black_200),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          controller: StorageController.companyController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Company name is required".tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: AppStrings.companyName.tr,
                              labelStyle:
                                  TextStyle(color: AppColors.black_200)),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          controller: StorageController.emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required".tr;
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: AppStrings.email.tr,
                              labelStyle:
                                  TextStyle(color: AppColors.black_200)),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          controller:
                              StorageController.mobilePhoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mobile number is required".tr;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Mobile Phone".tr,
                              labelStyle:
                                  TextStyle(color: AppColors.black_200)),
                        ),
                        Obx(() {
                          return Column(
                            children: [
                              storageController.isLandPhone.value ||
                                      StorageController.landPhoneController
                                          .text.isNotEmpty
                                  ? SizedBox(
                                      height: 4.h,
                                    )
                                  : SizedBox(),
                              storageController.isLandPhone.value ||
                                      StorageController.landPhoneController
                                          .text.isNotEmpty
                                  ? TextFormField(
                                      controller: StorageController
                                          .landPhoneController,
                                      decoration: InputDecoration(
                                          labelText: "Land Phone".tr,
                                          labelStyle: TextStyle(
                                              color: AppColors.black_300)),
                                    )
                                  : SizedBox(),
                              storageController.isFax.value ||
                                      StorageController
                                          .faxController.text.isNotEmpty
                                  ? SizedBox(height: 4.h)
                                  : SizedBox(),
                              storageController.isFax.value ||
                                      StorageController
                                          .faxController.text.isNotEmpty
                                  ? TextFormField(
                                      controller:
                                          StorageController.faxController,
                                      decoration: InputDecoration(
                                          labelText: "Fax".tr,
                                          labelStyle: TextStyle(
                                              color: AppColors.black_300)),
                                    )
                                  : SizedBox(),
                              storageController.isWebsite.value ||
                                      StorageController
                                          .websiteController.text.isNotEmpty
                                  ? SizedBox(height: 4.h)
                                  : SizedBox(),
                              storageController.isWebsite.value ||
                                      StorageController
                                          .websiteController.text.isNotEmpty
                                  ? TextFormField(
                                      controller: StorageController
                                          .websiteController,
                                      decoration: InputDecoration(
                                          labelText: "Website".tr,
                                          labelStyle: TextStyle(
                                              color: AppColors.black_300)),
                                    )
                                  : SizedBox(),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 4.h,
                        ),
                        TextFormField(
                          controller: StorageController.addressController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Address is required".tr;
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: AppStrings.address.tr,
                              labelStyle:
                                  TextStyle(color: AppColors.black_200)),
                        ),
                        SizedBox(height: 16.h),
                        Obx(() => storageController.isTapped.value
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                      color: AppColors.green_600,
                                      borderRadius:
                                          BorderRadius.circular(4.r)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          storageController
                                                  .isLandPhone.value =
                                              !storageController
                                                  .isLandPhone.value;
                                        },
                                        child: CustomText(
                                          text: storageController
                                              .formFieldsList[0],
                                          color: AppColors.green_900,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          bottom: 16,
                                        ),
                                      ),
                                      Container(
                                        width: 100.w,
                                        height: 1.h,
                                        color: AppColors.green_900,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          storageController.isFax.value =
                                              !storageController
                                                  .isFax.value;
                                        },
                                        child: CustomText(
                                          top: 5,
                                          text: storageController
                                              .formFieldsList[1],
                                          color: AppColors.green_900,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          bottom: 16,
                                        ),
                                      ),
                                      Container(
                                        width: 100.w,
                                        height: 1.h,
                                        color: AppColors.green_900,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          storageController
                                                  .isWebsite.value =
                                              !storageController
                                                  .isWebsite.value;
                                        },
                                        child: CustomText(
                                          top: 5,
                                          text: storageController
                                              .formFieldsList[2],
                                          color: AppColors.green_900,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          bottom: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox()),
                        GestureDetector(
                          onTap: () {
                            storageController.isTapped.value =
                                !storageController.isTapped.value;
                            addItem();
                          },
                          child: Container(
                            height: 30.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                                color: AppColors.green_700,
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColors.green_500,
                                ),
                                SizedBox(width: 4.w),
                                CustomText(
                                  text: "Add".tr,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.green_500,
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                        ///<<<================ Done Button ============================>>>

                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomElevatedButton(
                            onTap: () async {
                              // if (formKey.currentState!.validate()) {

                              if (screenTitle == AppStrings.editCard) {
                                await storageController.updateContact();
                              } else {
                                await storageController.addContact();
                              }
                              storageController.clearControllers();
                              // Get.toNamed(AppRoutes.allCardsScreen);
                              // }
                              Get.offAllNamed(AppRoutes.allCardsScreen);
                            },
                            text: AppStrings.done.tr,
                            backgroundColor: AppColors.black_500,
                            width: 120,
                            height: 42,
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  CachedNetworkImage CustomCachedNetworkImage() {
    return CachedNetworkImage(
      imageUrl: "${StorageController.imagePath}",
      imageBuilder: (context, imageProvider) => Container(
        height: 250.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.green_600,
          borderRadius: BorderRadius.circular(8.r),
          image: DecorationImage(fit: BoxFit.fill, image: imageProvider),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        if (kDebugMode) {
          print("Error url : $url");
        }
        return Container(
          height: 250.h,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.green_600,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(Icons.error),
        );
      },
    );
  }
}
