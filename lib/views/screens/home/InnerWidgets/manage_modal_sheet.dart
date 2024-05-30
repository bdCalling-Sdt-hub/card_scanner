import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/qr_scanner_controller.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:card_scanner/views/screens/DuplicateCards/duplicate_cards_screen.dart';
import 'package:card_scanner/views/screens/QrCodeScanner/scan_qr_code_screen.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../controllers/storage_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/CustomBackButton/custom_back_button.dart';

class ManageModalSheet extends StatelessWidget {
  ManageModalSheet({super.key});

  RxInt selectedOption = 0.obs;

  QrScannerController qrScannerController = Get.put(QrScannerController());
  OCRCreateCardController ocrCreateCardController = Get.put(OCRCreateCardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
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
                      onTap: () {
                        Get.back();
                      },
                      radius: 100,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),

                    ///<<<================ Manage Card Items ====================>>>

                    InkWell(
                      onTap: () {
                        Get.to(CreateOrEditCardScreen(
                            screenTitle: AppStrings.createCardTitle.tr));
                        StorageController.appTitle = AppStrings.createCardTitle.tr;
                      },
                      child: manageCards(Icons.add, AppStrings.createCard.tr),
                    ),
                    InkWell(
                      onTap: () async {
                        await qrScannerController.qrScanner().then((value) {
                          if (kDebugMode) {
                            print("Qr code data =====>>>>>>>>: $value");
                          }
                          ocrCreateCardController.textFormatRepo(extractedText: value);
                        });
                      },
                      child: manageCards(Icons.filter_center_focus_outlined,
                          AppStrings.scanQrCode.tr),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(DuplicateCardsScreen());
                    //   },
                    //   child: manageCards(Icons.credit_card_outlined,
                    //       AppStrings.duplicateCards.tr),
                    // ),
                    SizedBox()
                  ],
                ),
                SizedBox(height: 12.h),
                // Divider(
                //   color: AppColors.black_400,
                // ),
                // SizedBox(height: 8.h),
                // CustomText(
                //   text: AppStrings.changeSortType,
                //   fontSize: 16,
                //   fontWeight: FontWeight.w500,
                // ),

                ///<<<================= Card sorting type =======================>>>
                //
                // cardShortSelection(1, AppStrings.sortByCreateDate),
                // cardShortSelection(2, AppStrings.sortByName),
                // cardShortSelection(3, AppStrings.sortByCompanyName),
              ],
            ),
      ),
    );
  }

  ///<<<======================= Card Sort Selections ======================>>>

  Row cardShortSelection(int value, String text) {
    return Row(
      children: [
        Radio<int>(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            groupValue: selectedOption.value,
            activeColor: AppColors.black_400,
            fillColor: MaterialStateProperty.all(AppColors.black_400),
            splashRadius: 20,
            onChanged: (value) {
              selectedOption.value = value!.toInt();
            },
            visualDensity: VisualDensity(horizontal: -4, vertical: -2)),
        CustomText(
          text: text,
        )
      ],
    );
  }

  ///<<<========================= Manage Cards Methods ====================>>>

  Container manageCards(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      height: 76.h,
      width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.green_600)),
      child: Column(
        children: [
          Container(
            height: 25.h,
            width: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.black_500),
            ),
            child: Center(
                child: Icon(
              icon,
              size: 20,
            )),
          ),
          CustomText(
            maxLines: 2,
            text: text,
            fontSize: 12,
          )
        ],
      ),
    );
  }
}
