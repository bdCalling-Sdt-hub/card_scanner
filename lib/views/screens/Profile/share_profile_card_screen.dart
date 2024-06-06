import 'package:card_scanner/Helpers/screen_shot_helper.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Helpers/prefs_helper.dart';
import '../../../Services/image_bb_service.dart';

class ShareProfileCardScreen extends StatelessWidget {
  ShareProfileCardScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());
  ScreenshotController screenshotController = ScreenshotController();
  ScreenShotHelper screenShotHelper = ScreenShotHelper();
  final imageBBService = Get.put(ImageBBService());

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
                    onTap: () {
                      Get.back();
                    },
                  ),
                  CustomText(
                    text: AppStrings.shareCard.tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 30.w,
                  )
                ],
              ),
              SizedBox(height: 50.h),

              ///<<<================= QR Code ========================>>>
              Screenshot(
                controller: screenshotController,
                child: Container(
                  height: 220.h,
                  width: 220.w,
                  decoration: BoxDecoration(color: AppColors.whiteColor),
                  child: QrImageView(
                    data:
                        "${PrefsHelper.profileImagePath} /${profileController.nameController.text}/${profileController.designationController.text}/${profileController.companyController.text}/${profileController.emailController.text}/${profileController.phoneController.text}/${profileController.telephoneController.text}/${profileController.faxController.text}/${profileController.websiteController.text}/${profileController.addressController.text} ",
                    version: QrVersions.auto,
                    size: 200,
                    gapless: false,
                    // embeddedImage: FileImage(File(selectedContact.imageUrl)),
                    embeddedImageStyle:
                        QrEmbeddedImageStyle(size: Size(100, 100)),
                    errorStateBuilder: (context, error) {
                      return Center(
                        child: Text(
                          "Oh! Something went wrong...".tr,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: AppStrings.pointYourCamera.tr,
                color: AppColors.black_400,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(
                height: 40.h,
              ),

              ///<<<================ Share Card Button ======================>>>

              GetBuilder<ImageBBService>(
                builder: (controller) {
                  return controller.isLoading
                      ? Center(
                          child: Padding(
                          padding: EdgeInsets.only(right: 24.w),
                          child: CircularProgressIndicator(),
                        ))
                      : CustomElevatedButton(
                          onTap: () async {
                            String imagePath = await screenShotHelper
                                .captureAndSaveImage(
                                    screenshotController: screenshotController,
                                    isShare: true)
                                .then((value) => screenShotHelper
                                    .getImagePath(imageBytes: value)
                                    .then((value) => imageBBService.uploadImage(
                                        imageFile: value!)));
                            Share.share(imagePath);
                            // XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            // if(imagePath != null){
                            //   Share.shareXFiles([image]);
                            // }
                          },
                          borderRadius: 24,
                          text: AppStrings.share.tr,
                          backgroundColor: AppColors.black_500,
                          height: 54.h,
                          width: 162.w,
                        );
                },
              ),
              SizedBox(
                height: 24.h,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: AppColors.black_50,
              //       borderRadius: BorderRadius.circular(8)),
              //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       CustomText(
              //         text: link,
              //         fontSize: 16,
              //       ),
              //
              //       ///<<<=============== Qr Code Link Copy Icon ==============>>>
              //
              //       InkWell(
              //           onTap: () {
              //             Get.snackbar("Share link copied", "");
              //           },
              //           child: Icon(Icons.content_copy_outlined))
              //     ],
              //   ),
              // ),
              SizedBox(height: 54.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  InkWell(
                    onTap: () async {
                      screenShotHelper.captureAndSaveImage(
                          screenshotController: screenshotController);
                      // _saveQRToGallery(context);
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
                          Icon(
                            Icons.file_download_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          CustomText(
                            text: "Download".tr,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  ),
                  GetBuilder<ImageBBService>(builder: (controller) {
                    return controller.isDownloading? Center(child: CircularProgressIndicator()) : InkWell(
                      onTap: () async {
                        // Get the file path
                        // String? filePath = result.files.single.path;
                        String filePath = await imageBBService.downloadImage(imageUrl: PrefsHelper.myCardImage);



                        final Email email = Email(
                          body: 'Email body',
                          subject: 'Email subject',
                          // recipients: ['siambci@gmail.com'],
                          attachmentPaths: [filePath],
                          isHTML: false,
                        );
                        await FlutterEmailSender.send(email);
                        // sendEmail();
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
                            Icon(
                              Icons.email_outlined,
                              size: 30,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            CustomText(
                              text: "Email".tr,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                      ),
                    );
                  },),
                  SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendEmail() async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto');
    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
