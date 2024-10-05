import 'dart:developer';

import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/payment_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/screens/ContactsScreen/contact_details_screen.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:card_scanner/views/screens/home/InnerWidgets/ocrimage_dialog.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_currency_picker/flutter_currency_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controllers/qr_scanner_controller.dart';
import '../../../controllers/storage_controller.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
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
  QrScannerController qrScannerController = Get.put(QrScannerController());

  OCRCreateCardController ocrCreateCardController =
      Get.put(OCRCreateCardController());
  StorageController storageController = Get.put(StorageController());
  OcrImageDialog ocrImageDialog = OcrImageDialog();



  TextEditingController searchController = TextEditingController();

  void filterContacts(String query) {
    setState(() {
      ContactDetailsScreen.filteredContacts = storageController.contacts
          .where((contact) =>
              contact.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration(seconds: 1),
      () {
        storageController.loadContacts();
      },
    );
    super.initState();
  }

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
                height: 12.h,
                width: Get.width,
              ),

              ///<<<=================== Top Bar ===========================>>>

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 8.w),
                  Expanded(
                      child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      onChanged: filterContacts,
                      controller: searchController,
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
                        hintText: "${AppStrings.search.tr}...",
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
                              text: AppStrings.donate.tr,
                              color: AppColors.green_500,
                              fontWeight: FontWeight.w600,
                              left: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              searchController.text.isNotEmpty && ContactDetailsScreen.filteredContacts.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: ContactDetailsScreen.filteredContacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 42.w),
                            title: Text(ContactDetailsScreen.filteredContacts[index].name),
                            onTap: () {
                              log("Index: $index");
                              Get.toNamed(AppRoutes.contactDetailsScreen, arguments: {"index": index});
                            },
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          ///<<<================= Home Image ===========================>>>
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12.h),
                            height: 160.h,
                            width: 230.w,
                            child: Image.asset(
                              AppImages.homePageLogo,
                              fit: BoxFit.fill,
                            ),
                          ),

                          CustomText(
                            text: AppStrings.shareWithAnyone.tr,
                            maxLines: 2,
                            color: AppColors.black_500,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),

                          ///<<<==================== Create Card Button ===================>>>

                          GetBuilder<OCRCreateCardController>(
                            builder: (controller) {
                              return controller.isLoading
                                  ? SizedBox(
                                      height: 56,
                                      child: Center(
                                          child: CircularProgressIndicator()))
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: CustomElevatedButton(
                                        onTap: () async {
                                          await digitalCardShowDialog(context);
                                        },
                                        text: AppStrings.createDigitalCards.tr,
                                        textColor: AppColors.black_500,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        borderRadius: 16,
                                        borderColor: AppColors.green_900,
                                        isFillColor: false,
                                        height: 48,
                                      ),
                                    );
                            },
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ///<<<============== Services List ============================>>>

                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.black_500),
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    width: Get.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: buildServiceItems(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoutes.cardSyncScreen);
                                            },
                                            icon: AppIcons.cardSyncIcon,
                                            title: AppStrings.cardSync.tr,
                                          ),
                                        ),
                                        Expanded(
                                          child: buildServiceItems(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: SizedBox(
                                                      height: 100,
                                                      width: Get.width,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              storageController
                                                                  .exportToExcel(
                                                                      contactList:
                                                                          storageController
                                                                              .contacts);
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          12.w),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.w),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                                color: AppColors
                                                                    .green_600,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 20.w,
                                                                  ),
                                                                  SvgPicture.asset(
                                                                      AppIcons
                                                                          .excelIcon),
                                                                  SizedBox(
                                                                    width: 20.w,
                                                                  ),
                                                                  CustomText(
                                                                    text:
                                                                        "Excel Export"
                                                                            .tr,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              storageController
                                                                  .selectedContacts
                                                                  .clear();
                                                              Get.toNamed(AppRoutes
                                                                  .allCardsExportScreen);
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          12.w),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.w),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                                color: AppColors
                                                                    .green_600,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: 20.w,
                                                                  ),
                                                                  Icon(Icons
                                                                      .qr_code_2),
                                                                  SizedBox(
                                                                    width: 20.w,
                                                                  ),
                                                                  CustomText(
                                                                    text:
                                                                        "Qr Export"
                                                                            .tr,
                                                                    fontSize:
                                                                        16,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                              // Get.to(AllCardsExportScreen());
                                            },
                                            isExport: true,
                                            title: AppStrings.cardExport.tr,
                                          ),
                                        ),
                                        Expanded(
                                          child: buildServiceItems(
                                            onTap: () {
                                              Get.toNamed(AppRoutes
                                                  .shareProfileCardScreen);
                                            },
                                            icon: AppIcons.shareCard,
                                            title: AppStrings.shareCard.tr,
                                          ),
                                        ),
                                      ],
                                    ),
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
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> digitalCardShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.green_700,
          content: Container(
            padding: EdgeInsets.only(top: 12.h, left: 4.w),
            child: GetBuilder<OCRCreateCardController>(
              builder: (controller) {
                return controller.isLoading
                    ? SizedBox(
                        height: 170.h,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// <<<========== Create Card Manually =================>>>

                          InkWell(
                            onTap: () {
                              storageController.clearControllers();
                              Get.to(CreateOrEditCardScreen(
                                  screenTitle: AppStrings.createCardTitle));
                              StorageController.appTitle =
                                  AppStrings.createCardTitle;
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
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
                                    text: "Create cards manually".tr,
                                    fontSize: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          ///<<<=========== Create card qr scan ====================>>>

                          InkWell(
                            onTap: () async {
                              await qrScannerController
                                  .qrScanner()
                                  .then((value) {
                                if (kDebugMode) {
                                  print("Qr code data =====>>>>>>>>: $value");
                                }
                                ocrCreateCardController.textFormatRepo(
                                    extractedText: value);
                              });
                            },
                            child: manageCards(
                                Icons.qr_code_scanner, "Scan QR Code".tr),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          /// <<<========== Create Card Using OCR Camera =================>>>

                          InkWell(
                            onTap: () async {
                              String responseText =
                                  await ocrCreateCardController
                                      .selectImageCamera()
                                      .then(
                                        (value) =>
                                            ocrCreateCardController.cropImage(
                                                imgPath: value!, isOcr: true),
                                      )
                                      .then(
                                        (value) => ocrCreateCardController
                                            .processImage(value!),
                                      );
                              ocrImageDialog.ocrCameraImageDialog(
                                  context, responseText);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
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
                                    text: "OCR with camera image".tr,
                                    fontSize: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          /// <<<========== Create Card Using OCR Gallery =================>>>

                          InkWell(
                            onTap: () async {
                              String responseText =
                                  await ocrCreateCardController
                                      .selectImageGallery()
                                      .then(
                                        (value) =>
                                            ocrCreateCardController.cropImage(
                                                imgPath: value!, isOcr: true),
                                      )
                                      .then(
                                        (value) => ocrCreateCardController
                                            .processImage(value!),
                                      );
                              ocrImageDialog.ocrGalleryImageDialog(
                                  context, responseText);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.green_600,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.image_outlined),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  CustomText(
                                    text: "OCR with gallery image".tr,
                                    fontSize: 16,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                        ],
                      );
              },
            ),
          ),
        );
      },
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
        height: 270,
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8.w),
                  labelText: AppStrings.amount.tr,
                  labelStyle: TextStyle(color: AppColors.green_900)),
            ),
            SizedBox(
              height: 12.h,
            ),
            GetBuilder<PaymentController>(builder: (controller) {
              return CurrencySelector(
                indent: EdgeInsets.only(left: 8.w),
                value: controller.currency?.code,
                hintText: 'Currency Type (Code)'.tr,
                fieldBackground:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                update: (value) => controller.setCurrency(value: value),
              );
            },),
            SizedBox(
              height: 24.h,
            ),
            CustomElevatedButton(
              onTap: () {
                if (paymentController.currency?.code != null && paymentController.currency!.code.isNotEmpty) {
                  if (kDebugMode) {
                    print("Currency Code ${paymentController.currency!.code}");
                  }
                  Get.to(paymentController.buildPaypalCheckout(
                      subscriptionName: "Donation".tr,
                      context: context,
                      amount: paymentController.amountController.text,
                      currency: paymentController.currency!.code));
                } else {
                  Get.snackbar("Please, must select a currency".tr, "");
                }
              },
              text: AppStrings.send.tr,
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
      String icon = "",
      required String title,
      bool isExport = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isExport ? Icon(Icons.ios_share) : SvgPicture.asset(icon),
            SizedBox(
              height: 4.h,
            ),
            CustomText(overflow: TextOverflow.ellipsis, text: title)
          ],
        ),
      ),
    );
  }

  Container manageCards(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.green_600,
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 8.w,
          ),
          CustomText(
            text: text.tr,
            fontSize: 16,
          )
        ],
      ),
    );
  }
}


