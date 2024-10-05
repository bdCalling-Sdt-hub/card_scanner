
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/CustomBackButton/custom_back_button.dart';

class CardExportScreen extends StatelessWidget {
  CardExportScreen({super.key});

  final PageController pageController = PageController(viewportFraction: 0.8);
  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StorageController>(builder: (storageController) {

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(onTap: () {
                      Get.back();
                      },),
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
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(top: 32.h, left: 16.w, right: 16.w),
                    child: PageView.builder(
                      controller: pageController,
                      // scrollDirection: Axis.horizontal,
                      itemCount: storageController.selectedContacts.length,
                      itemBuilder: (context, index) {
                        var selectedContact = storageController.selectedContacts[index];
                        if (kDebugMode) {
                          print("${selectedContact.imageUrl}/ /${selectedContact.name} /${selectedContact.designation} /${selectedContact.companyName} /${selectedContact.email} /${selectedContact.mobilePhone} /${selectedContact.landPhone} /${selectedContact.fax}/${selectedContact.website}/${selectedContact.address}}");
                        }
                        return Column(
                          children: [
                            SizedBox(height: 100.h,),
                            ///<<<============== Qr code generation ===============>>>

                            QrImageView(
                              data: "Image url: ${selectedContact.imageUrl}, \nName:${selectedContact.name}, \nDesignation: ${selectedContact.designation}, \nCompany Name: ${selectedContact.companyName}, \nEmail: ${selectedContact.email}, \nMobile: ${selectedContact.mobilePhone}, \nTelephone: ${selectedContact.landPhone}, \nFax: ${selectedContact.fax}, \nWebsite: ${selectedContact.website}, \nAddress: ${selectedContact.address}}",
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
                            CustomText(
                              top: 8,
                              text: selectedContact.name,
                              fontSize: 16,
                            ),
                          ],
                        );
                      },
                      onPageChanged: (value) {
                        currentIndex.value = value;
                      },
                    ),
                  ),
                ),
               Expanded(
                 flex: 2,
                 child: Column(
                   children: [
                     const Divider(),
                     SizedBox(height: 16.h,),

                     Obx(() => AnimatedSmoothIndicator(
                       activeIndex: currentIndex.value,
                       count: storageController.selectedContacts.length,
                       effect: ExpandingDotsEffect(
                           dotHeight: 10.h,
                           dotWidth: 10.w,
                           activeDotColor: AppColors.black_400,
                           dotColor: AppColors.green_800
                       ),
                     ))
                   ],
                 ),
               )
              ],
            ),
          ),
        );
      },),
    );
  }
}

