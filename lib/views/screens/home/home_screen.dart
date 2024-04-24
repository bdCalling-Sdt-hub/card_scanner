import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/payment_controller.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../Profile/share_profile_card_screen.dart';
import 'InnerWidgets/card_holder.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  int currentPosition = 0;
  List serviceList = [
    {"icon": AppIcons.cardSyncIcon, "service": AppStrings.cardSync},
    {"icon": AppIcons.excelIcon, "service": AppStrings.cardExport},
    {"icon": AppIcons.shareCard, "service": AppStrings.shareCard},
  ];

  String link = "https://cf88BYf=name-card-scanner";

  List cardsList = [
    {
      'cardImage':
          "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Richard",
    },
    {
      'cardImage':
          "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "",
    },
    {
      'cardImage':
          "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Nicholas",
    },
    {
      'cardImage':
          "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Fardin",
    },
    {
      'cardImage':
          "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Kabir",
    },
    {
      'cardImage':
          "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Suhana",
    },
    {
      'cardImage':
          "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Nicholas",
    },
  ];

  ProfileController profileController = Get.put(ProfileController());
  PaymentController paymentController = Get.put(PaymentController());
  OCRCreateCardController ocrCreateCardController =
      Get.put(OCRCreateCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
                width: Get.width,
              ),

              ///<<<=================== Top Bar ===========================>>>

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30.w),
                  Expanded(
                      child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      onTap: () {},
                      // controller: widget.textEditingController,
                      keyboardType: TextInputType.text,
                      // onChanged: widget.onChanged,
                      maxLines: 1,
                      cursorColor: AppColors.green_200,
                      style: const TextStyle(
                        color: AppColors.green_500,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 0.h),
                        hintText: "${AppStrings.search}...",
                        hintStyle: const TextStyle(
                          color: AppColors.green_50,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        fillColor: AppColors.green_900,
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.green_50,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 0),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 0),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 8.w,
                  ),
                  InkWell(
                    onTap: () {
                      print("Payment Controller Called");
                      showDialog(
                        context: context,
                        builder: (context) {
                          return paymentAlertDialog(context);
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      height: 40.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: AppColors.black_500),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              color: AppColors.green_500,
                            ),
                            CustomText(
                              text: AppStrings.donate,
                              color: AppColors.green_500,
                              fontWeight: FontWeight.w600,
                              left: 4,
                            ),
                          ],
                        ),
                      ),
                      // child: Column(
                      //   children: [
                      //     Center(
                      //         child: SvgPicture.asset(AppIcons.donateIcon, height: 30, width: 30,)),
                      //     // CustomText(text: "Donate", fontSize: 12, color: AppColors.green_500,),
                      //   ],
                      // ),
                    ),
                  )
                ],
              ),

              ///<<<================= Home Image ===========================>>>
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                child: Image.asset(AppImages.homePageLogo),
              ),

              CustomText(
                text: AppStrings.shareWithAnyone,
                maxLines: 2,
                color: AppColors.black_500,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),

              ///<<<==================== Create Card Button ===================>>>

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: CustomElevatedButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppColors.green_700,
                          content: Container(
                            padding: EdgeInsets.only(top: 12.h, left: 8.w),
                            height: 120.h,
                            child: GetBuilder<OCRCreateCardController>(
                              builder: (controller) {
                                return controller.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(CreateOrEditCardScreen(
                                                  screenTitle: AppStrings
                                                      .createCardTitle));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: AppColors.green_600,
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    AppIcons.editNote,
                                                    height: 26.h,
                                                    width: 20.w,
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  CustomText(
                                                    text: AppStrings.cardCreateManually,
                                                    fontSize: 16,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              ocrCreateCardController
                                                  .selectImageCamera(
                                                      isOcr: true);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8.w),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: AppColors.green_600,
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    AppIcons.ocrCameraIcon,
                                                    height: 20.h,
                                                    width: 20.w,
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  CustomText(
                                                    text: AppStrings.cardCreateOcr,
                                                    fontSize: 16,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: AppStrings.createDigitalCards,
                  textColor: AppColors.black_500,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  borderRadius: 41,
                  borderColor: AppColors.green_900,
                  isFillColor: false,
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///<<<============== Services List ============================>>>

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black_500),
                            borderRadius: BorderRadius.circular(8.r)),
                        width: Get.width,
                        height: 76.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildServiceItems(
                              onTap: () {
                                Get.toNamed(AppRoutes.cardSyncScreen);
                              },
                              icon: AppIcons.cardSyncIcon,
                              title: AppStrings.cardSync,
                            ),
                            buildServiceItems(
                              onTap: () {
                                Get.toNamed(AppRoutes.cardExportScreen);
                              },
                              icon: AppIcons.excelIcon,
                              title: AppStrings.cardExport,
                            ),
                            buildServiceItems(
                              onTap: () {
                                Get.to(ShareProfileCardScreen());
                              },
                              icon: AppIcons.shareCard,
                              title: AppStrings.shareCard,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 8.h,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       height: 4.h,
                      //       width: 20.w,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(4),
                      //           color: AppColors.black_500),
                      //     ),
                      //     SizedBox(
                      //       width: 4.w,
                      //     ),
                      //     Container(
                      //       height: 4.h,
                      //       width: 20.w,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(4),
                      //           color: AppColors.black_500),
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: 16.h,
                      ),

                      ///<<<=============== Card Holder =============================>>>
                      CardHolder(
                        profileController: profileController,
                        context: context,
                      ),
                    ],
                  ),
                ),
              )
              // Container(
              //   width: Get.width,
              //   height: 72.h,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8.r),
              //     color: AppColors.green_50
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 40.h,
              //         width: 40.w,
              //         decoration: BoxDecoration(
              //           color: AppColors.black_400,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Center(child: SvgPicture.asset(AppIcons.targetIcon)),
              //       ),
              //       Column(
              //         children: [
              //           CustomText(
              //             text: AppStrings.artificialProofreading,
              //             color: AppColors.black_500,
              //             fontWeight: FontWeight.w500,
              //             fontSize: 20,
              //           ),
              //           CustomText(
              //             text: AppStrings.accurateIndentification,
              //             color: AppColors.black_400,
              //             fontWeight: FontWeight.w400,
              //             fontSize: 16,
              //           ),
              //         ],
              //       ),
              //       const Icon(Icons.arrow_forward_ios_rounded),
              //     ],
              //   )
              // )
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog paymentAlertDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.green_500,
        ),
        height: 250,
        width: Get.width,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CustomBackButton(
                  radius: 100,
                  onTap: () {
                    Get.back();
                  }),
            ),
            TextFormField(
              controller: paymentController.amountController,
              decoration: InputDecoration(hintText: AppStrings.amount),
            ),
            SizedBox(
              height: 12.h,
            ),
            TextFormField(
              controller: paymentController.currencyController,
              decoration: InputDecoration(hintText: AppStrings.currency),
            ),
            SizedBox(
              height: 24.h,
            ),
            CustomElevatedButton(
              onTap: () {
                Get.to(paymentController.buildPaypalCheckout(
                    subscriptionName: "Donation",
                    context: context,
                    amount: paymentController.amountController.text,
                    currency: paymentController.currencyController.text));
              },
              text: AppStrings.send,
              backgroundColor: AppColors.black_500,
            )
          ],
        ),
      ),
    );
  }

  ///<<<============== Services List Method ============================>>>

  Padding buildServiceItems(
      {required VoidCallback onTap,
      required String icon,
      required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            SizedBox(
              height: 4.h,
            ),
            CustomText(text: title)
          ],
        ),
      ),
    );
  }
}
