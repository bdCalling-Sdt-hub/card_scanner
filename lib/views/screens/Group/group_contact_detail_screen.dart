

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/routes/app_routes.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/CustomBackButton/custom_back_button.dart';
import '../../widgets/customButton/custom_elevated_button.dart';
import '../../widgets/customText/custom_text.dart';
import '../../widgets/custom_text_field/custom_text_field.dart';

// ignore: must_be_immutable
class GroupContactDetailScreen extends StatelessWidget {
  GroupContactDetailScreen({super.key});

  StorageController phoneStorageController = Get.put(StorageController());
  ScrollController scrollController = ScrollController();

  int groupIndex = Get.arguments["groupIndex"];
  int contactIndex = Get.arguments["contactIndex"];

  RxBool isTapped = false.obs;

  RxBool hasNoteData = false.obs;
  RxBool isNoteTapped = false.obs;


  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }


  void sendEmail(String emailTo) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailTo,
      // query: encodeQueryParameters(<String, String>{
      //   'subject': 'Example Subject & Symbols are allowed!',
      //   'body': 'Hello, this is a test email.'
      // }),
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailTo';
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }


  checkNoteData({required String noteData}){
    if(noteData == "" || noteData.isEmpty){
      hasNoteData.value = false;
    }else{
      hasNoteData.value = true;
    }
  }


  void addNote({required bool isUP}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double position = isUP ? scrollController.position.maxScrollExtent : scrollController.position.minScrollExtent;
      scrollController.animateTo(
        position,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    var contactDetails = phoneStorageController.groupedContactsList[groupIndex].contactsList[contactIndex];
    StorageController.noteController.text = contactDetails.note;
    if (kDebugMode) {
      print("-----------------${contactDetails.note}");
    }
    checkNoteData(noteData: contactDetails.note);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                        icon: Icons.arrow_back,
                        onTap: () {
                          Get.back();
                        }),
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: AppStrings.contactDetails.tr,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        phoneStorageController.selectedContacts.clear();
                        phoneStorageController.selectedContacts.add(contactDetails);
                        Get.toNamed(AppRoutes.cardExportScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.blackColor,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 4.w,
                            ),
                            Icon(
                              Icons.qr_code_2,
                              size: 16,
                              color: AppColors.whiteColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                              text: "Qr Export".tr,
                              fontSize: 14,
                              color: AppColors.whiteColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: contactDetails.imageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 180.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                            color: AppColors.green_600,
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: imageProvider,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                          height: 180.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                            color: AppColors.green_600,
                            borderRadius:
                            BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() => GestureDetector(
                      onTap: () {
                        isTapped.value = !isTapped.value;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.green_600),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Scanned Images".tr,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            isTapped.value
                                ? Icon(
                              Icons.keyboard_arrow_down,
                            )
                                : Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    )),
                    Obx(() => isTapped.value
                        ? Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        contactDetails.capturedImageList != []
                            ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                contactDetails.capturedImageList
                                    .length, (index) {
                              return CachedNetworkImage(
                                imageUrl: contactDetails.capturedImageList[index],
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 220,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: imageProvider,
                                      )),
                                ),
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => SizedBox(width: Get.width * 0.9, child: Icon(Icons.error)),
                              );
                            }),
                          ),
                        )
                            : Center(
                            child: CustomText(
                              text: "No image found".tr,
                            )),
                      ],
                    )
                        : SizedBox()),
                    SizedBox(height: 30.h),
                    customWrap(
                        title: AppStrings.name.tr, value: contactDetails.name),
                    SizedBox(height: 4.h,),
                    customWrap(
                        title: AppStrings.designation.tr,
                        value: contactDetails.designation),
                    SizedBox(height: 4.h,),
                    customWrap(
                        title: AppStrings.company.tr,
                        value: contactDetails.companyName),
                    SizedBox(height: 4.h,),
                    customWrap(
                        onTap: () {
                          sendEmail(contactDetails.email);
                        },
                        icon: Icons.email_outlined,
                        isIcon: true,
                        title: AppStrings.email.tr,
                        value: contactDetails.email),
                    SizedBox(height: 8.h,),
                    customWrap(
                        onTap: () {
                          makePhoneCall(contactDetails.mobilePhone);
                        },
                        icon: Icons.call,
                        isIcon: true,
                        title: AppStrings.mobile.tr,
                        value: contactDetails.mobilePhone),
                    SizedBox(height: 8.h,),
                    contactDetails.landPhone != ""
                        ? customWrap(
                        title: "Telephone".tr,
                        value: contactDetails.landPhone)
                        : SizedBox(),
                    SizedBox(height: contactDetails.landPhone != ""? 4.h : 0,),
                    contactDetails.fax != ""
                        ? customWrap(
                        title: "Fax".tr, value: contactDetails.fax)
                        : SizedBox(),
                    SizedBox(height: contactDetails.fax != ""? 4.h : 0,),
                    contactDetails.website != ""
                        ? customWrap(
                        title: "Website".tr, value: contactDetails.website)
                        : SizedBox(),
                    SizedBox(height: contactDetails.website != ""? 4.h : 0,),
                    customWrap(
                        title: AppStrings.address.tr,
                        value: contactDetails.address),
                    SizedBox(
                      height: 8.h,
                    ),
                    Obx(() {
                      return isNoteTapped.value
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 300.h,
                            child: CustomTextField(
                              textEditingController: StorageController.noteController,
                              hintText: "${"Write here".tr}...",
                              maxLines: 10,
                              fillColor: AppColors.green_600,
                              fieldBorderColor: AppColors.transparentColor,
                            ),
                          ),
                          SizedBox(height: 12.h,),
                          Align(
                            alignment: Alignment.center,
                            child: CustomElevatedButton(
                              width: Get.width/2,
                              height: 42,
                              onTap: () {
                                StorageController.imagePath = contactDetails.imageUrl;
                                StorageController.nameController.text = contactDetails.name;
                                StorageController.designationController.text = contactDetails.designation;
                                StorageController.companyController.text = contactDetails.companyName;
                                StorageController.emailController.text = contactDetails.email;
                                StorageController.mobilePhoneController.text = contactDetails.mobilePhone;
                                StorageController.landPhoneController.text = contactDetails.landPhone;
                                StorageController.faxController.text = contactDetails.fax;
                                StorageController.websiteController.text = contactDetails.website;
                                StorageController.addressController.text = contactDetails.address;
                                StorageController.capturedImageList = contactDetails.capturedImageList;
                                phoneStorageController.id = contactDetails.id;
                                isNoteTapped.value = false;
                                phoneStorageController.updateContact();

                                checkNoteData(noteData: StorageController.noteController.text);
                                addNote(isUP: false);
                              },
                              text: "Save".tr,
                              backgroundColor: AppColors.black_500,
                            ),
                          ),
                          SizedBox(height: 20.h,),
                        ],
                      )
                          : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: CustomText(
                              textAlign: TextAlign.left,
                              text: "${"Note".tr}: ",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Obx(() => hasNoteData.value ?Expanded(
                            child: CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 50,
                              text: StorageController.noteController.text,
                              fontSize: 16,
                              color: AppColors.green_900,
                            ),
                          ) : SizedBox()),
                          InkWell(
                            onTap: () {
                              isNoteTapped.value = true;
                              addNote(isUP: true);
                            },
                            child: Icon(
                              Icons.note_alt_outlined,
                              color: AppColors.green_900,
                              size: 28,
                            ),
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row customWrap({required String title, required String value, IconData? icon, bool isIcon = false, VoidCallback? onTap }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100.w,
          child: CustomText(
            textAlign: TextAlign.left,
            text: "$title: ",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: CustomText(
            textAlign: TextAlign.left,
            maxLines: 5,
            text: value,
            fontSize: 16,
            color: AppColors.green_900,
          ),
        ),

        isIcon
            ? InkWell(
            onTap: onTap,
            child: Icon(icon, size: 24, color: AppColors.green_900,))
            : SizedBox(),
      ],
    );
  }
}