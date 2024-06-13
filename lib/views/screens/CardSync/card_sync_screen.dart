
import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../widgets/customButton/custom_elevated_button.dart';

// ignore: must_be_immutable
class CardSyncScreen extends StatelessWidget {
  CardSyncScreen({super.key});

  AuthController authController = Get.put(AuthController());
  StorageController storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(onTap: (){
                    Get.back();
                  }),
                  CustomText(
                    text: AppStrings.smartSync.tr,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w,),
                ],
              ),
              SizedBox(
                height: 36.h,
              ),

              ///<<<===================== Mobile Backup ======================>>>
              // Container(
              //   width: Get.width,
              //   decoration: BoxDecoration(
              //       border: Border.all(color: AppColors.green_900),
              //       borderRadius: BorderRadius.circular(8),
              //       color: AppColors.green_600
              //   ),
              //   child: Column(
              //     children: [
              //       GestureDetector(
              //         onTap: (){
              //           showDialog(
              //             context: context,
              //             builder: (context) {
              //               return AlertDialog(
              //                 content: CustomText(
              //                   maxLines: 5,
              //                   fontSize: 20,
              //                   fontWeight: FontWeight.w600,
              //                   text: AppStrings.sureToSaveInMobile,
              //                   color: AppColors.green_900,
              //                 ),
              //                 actions: [
              //                   Row(
              //                     children: [
              //                       Expanded(
              //                         child: CustomElevatedButton(
              //                           onTap: (){
              //                             Get.back();
              //                           },
              //                           text: "No",
              //                           textColor: AppColors.black_500,
              //                           isFillColor: false,
              //                           borderColor: AppColors.black_500,
              //                         ),
              //                       ),
              //                       SizedBox(width: 12,),
              //                       Expanded(
              //                         child: CustomElevatedButton(
              //                           onTap: (){
              //                             Get.back();
              //                             Get.snackbar("Your data backed up in your local storage", "");
              //                           },
              //                           text: "Yes",
              //                           backgroundColor: AppColors.black_500,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               );
              //             },);
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              //           decoration: BoxDecoration(
              //               border: Border(
              //                   bottom: BorderSide(color: AppColors.green_900)
              //               ),
              //               borderRadius: BorderRadius.circular(8),
              //               color: AppColors.green_500
              //           ),
              //           child: Column(
              //             children: [
              //               Image.asset(AppImages.mobileSmartSync, height: 130.h, width: 168.w,),
              //               SizedBox(height: 20.h),
              //               Align(
              //                 alignment: Alignment.centerLeft,
              //                 child: CustomText(
              //                   text: AppStrings.mobileBackup,
              //                   fontSize: 18,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               SizedBox(height: 8.h),
              //               Align(
              //                 alignment: Alignment.centerLeft,
              //                 child: CustomText(
              //                   text: AppStrings.batchExportCards,
              //                   fontSize: 16,
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              //         child: RichText(
              //           textAlign: TextAlign.start,
              //           text: TextSpan(
              //             text: 'To import back up contacts press below,  ',
              //             style: TextStyle(fontSize: 16, color: AppColors.black_500),
              //             children: <TextSpan>[
              //               TextSpan(
              //                   text: 'Import Contacts',
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.w500,
              //                     color: Colors.blueAccent,
              //                     fontSize: 18,
              //                     decoration: TextDecoration.underline,
              //                   ),
              //                   recognizer: TapGestureRecognizer()..onTap = (){
              //                     storageController.downloadFile(AuthController.accessToken);
              //                   }
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              SizedBox(height: 20.h,),

              ///<<<===================== Google backup ======================>>>

              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.green_900),
                    borderRadius: BorderRadius.circular(8),
                  color: AppColors.green_600
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        // authController.googleSignInRepo();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: 135.h,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CustomBackButton(onTap: () {
                                        Get.back();
                                      },),
                                    ),
                                    SizedBox(height: 8.h,),
                                    CustomText(
                                      maxLines: 5,
                                      text: AppStrings.sureToSaveInEmail.tr,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.green_900,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                GetBuilder<AuthController>(builder: (authController) {
                                  return authController.isLoading? Center(child: CircularProgressIndicator()) : CustomElevatedButton(onTap: () {
                                    authController.googleSignInRepo(isUpload: true);
                                  },
                                    svgIcon: AppIcons.googleColorfulIcon,
                                    text: "Upload".tr,
                                    backgroundColor: AppColors.black_500,
                                    fontSize: 20,
                                  );
                                },),
                                SizedBox(height: 8.h,),

                                CustomText(
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                    fontSize: 16,
                                    text: "To get access another google account press on logout,".tr,
                                ),
                                TextButton(onPressed: (){
                                  authController.googleSignOutRepo();
                                  Get.back();
                                },
                                    child: Text("Logout".tr,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.blue,
                                      ),
                                    )),
                              ],
                            );
                          },);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                        // margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.green_900)
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.green_500
                        ),
                        child: Column(
                          children: [
                            Image.asset(AppImages.emailBackUpImg, height: 130.h, width: 168.w,),
                            SizedBox(height: 20.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                text: AppStrings.emailBackup.tr,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomText(
                                textAlign: TextAlign.left,
                                text: AppStrings.dataBackupEmailsSecurely.tr,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      child: GetBuilder<AuthController>(builder: (authController) {
                        return authController.isLoading? Center(child: CircularProgressIndicator()) : RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'To import back up contacts press below,  '.tr,
                            style: TextStyle(fontSize: 16, color: AppColors.black_500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Import Contacts'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueAccent,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                    authController.googleSignInRepo(isUpload: false);
                                  }
                              ),
                            ],
                          ),
                        );
                      },),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
