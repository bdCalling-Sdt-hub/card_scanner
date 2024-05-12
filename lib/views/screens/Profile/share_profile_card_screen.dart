

import 'dart:ui' as ui;

import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';


class ShareProfileCardScreen extends StatelessWidget {
  ShareProfileCardScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());
  ScreenshotController screenshotController = ScreenshotController();

  String link ="https://cf88BYf=name-card-scanner" ;
  final GlobalKey _qrImageKey = GlobalKey();

  Future<void> captureAndSaveImage() async{
    final Uint8List? uint8List = await screenshotController.capture();
    print("uint8List $uint8List");
    if(uint8List != null){
      final PermissionStatus status = await Permission.storage.request();
      if(status.isGranted){
        final result = await ImageGallerySaver.saveImage(uint8List);
        if(result['isSuccess']){
          if (kDebugMode) {
            print("Image saved to gallery");
          }else{
            if (kDebugMode) {
              print("Failed to save image: ${result['error']}");
            }
          }
        }
      }else{
        if (kDebugMode) {
          await Permission.storage.request();
          print("Permission to access storage denied");
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(
                      onTap: (){
                        Get.back();
                        },
                  ),
                  CustomText(
                    text: AppStrings.shareCard,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w,)
                ],
              ),
              SizedBox(height: 50.h),
              ///<<<================= QR Code ========================>>>
              Screenshot(
                controller: screenshotController,
                child: QrImageView(
                  data: "${profileController.nameController.text}/${profileController.designationController.text}/${profileController.companyController.text}/${profileController.emailController.text}/${profileController.phoneController.text}/${profileController.addressController.text} ",
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
                        "Uh oh! Something went wrong...",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: AppStrings.pointYourCamera,
                color: AppColors.black_400,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 40.h,),

              ///<<<================ Share Card Button ======================>>>

              CustomElevatedButton(
                  onTap: (){
                    Share.share(link) ;
                  },
                borderRadius: 24,
                text: AppStrings.share,
                backgroundColor: AppColors.black_500,
                height: 54.h,
                width: 162.w,
              ),
              SizedBox(height: 24.h,),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black_50,
                  borderRadius: BorderRadius.circular(8)
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: link,
                      fontSize: 16,
                    ),

                    ///<<<=============== Qr Code Link Copy Icon ==============>>>

                    InkWell(
                        onTap: (){
                          Get.snackbar("Share link copied", "");
                        },
                        child: Icon(Icons.content_copy_outlined))
                  ],
                ),
              ),
              SizedBox(height: 54.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  InkWell(
                    onTap: () async {
                      captureAndSaveImage();

                      // _saveQRToGallery(context);
                      Get.snackbar("Qr code downloaded", "");
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8.h, right: 4.w, left: 4.w),
                      height: 76.h,
                      width: 76,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.black_50,
                          border: Border.all(color: AppColors.green_600)),
                      child: Column(
                        children: [
                          Icon(Icons.file_download_outlined, size: 30,),
                          SizedBox(height: 4.h,),
                          CustomText(
                            text: "Download",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Get.snackbar("Qr code downloaded", "");
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8.h, right: 4.w, left: 4.w),
                      height: 76.h,
                      width: 76,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.black_50,
                          border: Border.all(color: AppColors.green_600)),
                      child: Column(
                        children: [
                          Icon(Icons.email_outlined, size: 30,),
                          SizedBox(height: 4.h,),
                          CustomText(
                            text: "Email",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _saveQRToGallery(BuildContext context) async {
    try {
      // Capture the rendered QR code image
      RenderRepaintBoundary boundary =
      _qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveImage(pngBytes);
      print("success $result");

      // Show a confirmation dialog
    } catch (e) {
      print('Failed to save QR code: $e');
      // Show an error dialog
    }
  }
}
