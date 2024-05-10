
import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/payment_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_controller.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../Profile/share_profile_card_screen.dart';
import 'InnerWidgets/card_holder.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPosition = 0;

  List serviceList = [
    {"icon": AppIcons.cardSyncIcon, "service": AppStrings.cardSync},
    {"icon": AppIcons.excelIcon, "service": AppStrings.cardExport},
    {"icon": AppIcons.shareCard, "service": AppStrings.shareCard},
  ];

  String link = "https://cf88BYf=name-card-scanner";

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
                      if (kDebugMode) {
                        print("Payment Controller Called");
                      }
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

              GetBuilder<OCRCreateCardController>(builder: (controller) {
                return controller.isLoading? SizedBox(
                  height: 56,
                    child: Center(child: CircularProgressIndicator())) : Padding(
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
                                          StorageController.appTitle = AppStrings.createCardTitle;
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
                );
              },),

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
                                // Get.to(AllCardsExportScreen());
                                Get.toNamed(AppRoutes.allCardsExportScreen);
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
                      SizedBox(
                        height: 16.h,
                      ),

                      ///<<<=============== Card Holder =============================>>>
                      CardHolder(),
                    ],
                  ),
                ),
              )
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

// class CardHolder extends StatelessWidget {
//   const CardHolder({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StorageController>(
//       builder:(storageController) {
//         return Container(
//           width: Get.width,
//           decoration: BoxDecoration(
//             color: AppColors.green_50,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: storageController.contacts.isNotEmpty
//               ? Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 12.w, vertical: 16.h),
//                 child: Row(
//                   mainAxisAlignment:
//                   MainAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: AppStrings.cards,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.black_500,
//                       fontSize: 16,
//                     ),
//                     CustomText(
//                       text: "(${storageController.contacts.length})",
//                     ),
//                     const Spacer(),
//
//                     ///<<<==================== Group Text =======================>>>
//
//                     InkWell(
//                       onTap: (){
//                         Get.toNamed(AppRoutes.groupScreen);
//                       },
//                       child: Row(
//                         children: [
//                           SvgPicture.asset(
//                               AppIcons.groupIcon),
//                           SizedBox(width: 4.w),
//                           CustomText(
//                             text: AppStrings.group,
//                           ),
//                           SizedBox(width: 8.w),
//                         ],
//                       ),
//                     ),
//                     SvgPicture.asset(AppIcons.lineIcon),
//
//                     ///<<<=============== Manage Text ===========================>>>
//
//                     InkWell(
//                       onTap: () {
//                         showModalBottomSheet(
//                           context: context,
//                           builder: (context) {
//                             return ManageModalSheet();
//                           },
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           SizedBox(width: 8.w),
//                           SvgPicture.asset(
//                               AppIcons.manageIcon),
//                           SizedBox(width: 4.w),
//                           CustomText(
//                             text: AppStrings.manage,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 16.w, vertical: 8.h),
//                 child: SizedBox(
//                   height: (150 * storageController.contacts.length).toDouble(),
//                   child: ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: storageController.contacts.length,
//                     itemBuilder: (context, index) {
//                       return GetBuilder<StorageController>(builder: (controller) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 4.w),
//                           child: Container(
//                             width: Get.width,
//                             decoration: BoxDecoration(
//                               borderRadius:
//                               BorderRadius.circular(4),
//                               color: AppColors.green_300,
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 8.w,
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                       margin: EdgeInsets.symmetric(vertical: 8.h),
//                                       height: 100.h,
//                                       width: 120.w,
//                                       child: Image.file(File(storageController.contacts[index].imageUrl), fit: BoxFit.cover,)),
//                                   SizedBox(
//                                     width: 8.w,
//                                   ),
//                                   Expanded(
//                                     child: CustomText(
//                                       overflow: TextOverflow.ellipsis,
//                                       text: storageController.contacts[index].name,
//                                       color: AppColors.black_500,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//
//                                       ///<<<================== Bottom Modal Sheet =========================>>>
//
//                                       showModalBottomSheet(
//                                         context: context,
//                                         builder: (context) {
//                                           return Container(
//                                             height: 250,
//                                             width: Get.width,
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.only(
//                                                   topLeft: Radius.circular(8.r),
//                                                   topRight: Radius.circular(8.r),
//                                                 ),
//                                                 color: AppColors.green_50),
//                                             child: Padding(
//                                               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Align(
//                                                     alignment: Alignment.centerRight,
//                                                     child: GestureDetector(
//                                                       onTap: () {
//                                                         Get.back();
//                                                       },
//                                                       child: CustomBackButton(
//                                                         onTap: (){
//                                                           Get.back();
//                                                         },
//                                                         radius: 100,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   CustomText(
//                                                     text: AppStrings.moreOptions,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontSize: 24,
//                                                   ),
//                                                   SizedBox(
//                                                     height: 20.h,
//                                                   ),
//
//                                                   ///<<<=============== Share Business Card ========================>>>
//
//                                                   InkWell(
//                                                     onTap: () {
//                                                       showDialog(
//                                                         context: context,
//                                                         builder: (context) {
//                                                           return AlertDialog(
//                                                             surfaceTintColor:  AppColors.green_900,
//                                                             contentPadding: EdgeInsets.zero,
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius: BorderRadius.circular(8)),
//                                                             content: Container(
//                                                               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//                                                               width: Get.width,
//                                                               height: 200.h,
//                                                               child: Column(
//                                                                 children: [
//                                                                   Align(
//                                                                     alignment: Alignment.centerRight,
//                                                                     child: CustomBackButton(
//                                                                       onTap: (){
//                                                                         Get.back();
//                                                                       },
//                                                                       radius: 100.r,
//                                                                     ),
//                                                                   ),
//                                                                   CustomText(
//                                                                     text: AppStrings.shareWith,
//                                                                     fontSize: 20,
//                                                                     fontWeight: FontWeight.w500,
//                                                                   ),
//                                                                   SizedBox(height: 40.h,),
//                                                                   Padding(
//                                                                     padding: EdgeInsets.symmetric(horizontal: 20.w),
//                                                                     child: Row(
//                                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                       children: [
//                                                                         Container(
//                                                                           height: 40.h,
//                                                                           width: 40.w,
//                                                                           decoration: BoxDecoration(
//                                                                               color: AppColors.black_500,
//                                                                               borderRadius: BorderRadius.circular(12.r)
//                                                                           ),
//                                                                           child: Center(child: SvgPicture.asset(AppIcons.linkedinIcon)),
//                                                                         ),
//                                                                         Container(
//                                                                           height: 40.h,
//                                                                           width: 40.w,
//                                                                           decoration: BoxDecoration(
//                                                                               color: AppColors.black_500,
//                                                                               borderRadius: BorderRadius.circular(12.r)
//                                                                           ),
//                                                                           child: Center(child: SvgPicture.asset(AppIcons.fbIcon)),
//                                                                         ),
//                                                                         Container(
//                                                                           height: 40.h,
//                                                                           width: 40.w,
//                                                                           decoration: BoxDecoration(
//                                                                               color: AppColors.black_500,
//                                                                               borderRadius: BorderRadius.circular(12.r)
//                                                                           ),
//                                                                           child: Center(child: SvgPicture.asset(AppIcons.emailIcon, color: AppColors.green_50,)),
//                                                                         )
//                                                                       ],
//                                                                     ),
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                       );
//                                                     },
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(Icons.share),
//                                                         SizedBox(width: 8.w),
//                                                         CustomText(
//                                                           text: AppStrings.shareBusinessCard,
//                                                           fontSize: 16,
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Divider(
//                                                     endIndent: 120,
//                                                     color: AppColors.black_400,
//                                                   ),
//                                                   SizedBox(
//                                                     height: 8.h,
//                                                   ),
//
//                                                   ///<<<==================== Remove AlertDialog Open ====================>>>
//                                                   InkWell(
//                                                     onTap: () {
//                                                       showDialog(
//                                                         context: context,
//                                                         builder: (context) {
//                                                           return AlertDialog(
//                                                             surfaceTintColor:  AppColors.green_900,
//                                                             contentPadding: EdgeInsets.zero,
//                                                             shape: RoundedRectangleBorder(
//                                                                 borderRadius: BorderRadius.circular(8)),
//                                                             content: SizedBox(
//                                                               width: Get.width,
//                                                               height: 185.h,
//                                                               child: Column(
//                                                                 children: [
//                                                                   SizedBox(height: 40.h),
//                                                                   CustomText(
//                                                                     text: AppStrings.areYouSure,
//                                                                     fontWeight: FontWeight.w500,
//                                                                     fontSize: 20,
//                                                                   ),
//                                                                   SizedBox(height: 24.h),
//                                                                   Row(
//                                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                     children: [
//                                                                       SizedBox(),
//
//                                                                       ///<<<=============== Yes Button ================>>>
//
//                                                                       CustomElevatedButton(
//                                                                         onTap: () {
//                                                                           storageController.deleteContact(storageController.contacts[index].id);
//                                                                           Get.toNamed(AppRoutes.homeScreen);
//                                                                         },
//                                                                         text: AppStrings.yes,
//                                                                         height: 38,
//                                                                         width: 64,
//                                                                         isFillColor: true,
//                                                                         backgroundColor: AppColors.black_500,
//                                                                         borderRadius: 36,
//                                                                         fontSize: 20,
//                                                                         fontWeight: FontWeight.w400,
//                                                                       ),
//
//                                                                       ///<<<=============== No Button ================>>>
//
//                                                                       CustomElevatedButton(
//                                                                         onTap: () {
//                                                                           Get.back();
//                                                                         },
//                                                                         text: AppStrings.no,
//                                                                         height: 38,
//                                                                         width: 64,
//                                                                         borderColor: AppColors.black_500,
//                                                                         isFillColor: false,
//                                                                         borderRadius: 36,
//                                                                         textColor: AppColors.black_500,
//                                                                         fontSize: 20,
//                                                                         fontWeight: FontWeight.w400,
//                                                                       ),
//                                                                       SizedBox(),
//                                                                     ],
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                       );
//                                                     },
//                                                     child: Row(
//                                                       children: [
//                                                         Icon(Icons.delete),
//                                                         SizedBox(width: 8.w),
//                                                         CustomText(
//                                                           text: AppStrings.removeCard,
//                                                           fontSize: 16,
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Divider(
//                                                     endIndent: 120,
//                                                     color: AppColors.black_400,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     },
//                                     child: Container(
//                                       padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
//                                       child: Center(
//                                         child: SvgPicture.asset(
//                                           AppIcons.threeDotIcon, fit: BoxFit.cover, height: 8, ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },);
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 42.h,
//               ),
//             ],
//           ) : Column(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                       top: 16.h, left: 12.w),
//                   child: CustomText(
//                     text: AppStrings.cards,
//                   ),
//                 ),
//               ),
//               Column(
//                 children: [
//                   SizedBox(
//                       height: 74.h,
//                       width: 74.w,
//                       child:
//                       Image.asset(AppImages.cardLogo)),
//                   SizedBox(
//                     height: 16.h,
//                   ),
//                   CustomText(
//                     text: AppStrings.noCards,
//                   ),
//                   SizedBox(
//                     height: 4.h,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 24.w),
//                     child: CustomText(
//                       maxLines: 3,
//                       text: AppStrings
//                           .useBusinessCardRecognitionFunction,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 42.h,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
