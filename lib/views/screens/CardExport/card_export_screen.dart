
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../widgets/CustomBackButton/custom_back_button.dart';

class CardExportScreen extends StatelessWidget {
  CardExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StorageController>(builder: (storageController) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(onTap: () {Get.back();},),
                    CustomText(
                      text: AppStrings.cardExport.tr,
                      color: AppColors.black_500,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 30.w,)
                  ],
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32.h, left: 16.w, right: 16.w),
                    child: ListView.builder(
                      itemCount: storageController.selectedContacts.length,
                      itemBuilder: (context, index) {
                        var selectedContact = storageController.selectedContacts[index];
                        return Column(
                          children: [

                            ///<<<============== Qr code generation ===============>>>

                            QrImageView(
                              data: "${selectedContact.name}/${selectedContact.designation}/${selectedContact.companyName}/${selectedContact.email}/${selectedContact.phoneNumber}/${selectedContact.address} ",
                              version: QrVersions.auto,
                              size: 200,
                              gapless: false,
                              // embeddedImage: FileImage(File(selectedContact.imageUrl)),
                              embeddedImageStyle: QrEmbeddedImageStyle(
                                  size: Size(100, 100)
                              ),
                              errorStateBuilder: (context, error) {
                                return Center(
                                  child: Text(
                                    "Oh! Something went wrong...".tr,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                            // SizedBox(
                            //   height: 100.h,
                            //   width: Get.width,
                            //   child: Row(
                            //     children: [
                            //       Image.asset(cardQrList[index]["qrImg"]),
                            //       SizedBox(width: 8.w,),
                            //       CustomText(text: cardQrList[index]["title"], fontSize: 20,)
                            //     ],
                            //   ),
                            // ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },),
    );
  }
}

