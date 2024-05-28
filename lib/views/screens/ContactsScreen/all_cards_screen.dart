
import 'dart:io';

import 'package:card_scanner/Models/contacts_model.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/ocr_create_card_controller.dart';
import '../../../utils/app_colors.dart';
import '../../widgets/customButton/custom_elevated_button.dart';

class AllCardsScreen extends StatelessWidget {
  AllCardsScreen({super.key});

  StorageController phoneStorageController = Get.put(StorageController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: GetBuilder<StorageController>(builder: (storageController) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20,),
                    CustomText(
                      text: AppStrings.contacts.tr,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        storageController.isTapped.value = !storageController.isTapped.value;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.black_500,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Obx(() => Row(
                          children: [
                            CustomText(
                              text: "Sorts by".tr,
                              color: AppColors.green_500,
                            ),
                            storageController.isTapped.value? Icon(Icons.keyboard_arrow_down, color: AppColors.green_500,) : Icon(Icons.arrow_forward_ios, color: AppColors.green_500, size: 14,)
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
                Obx(() => storageController.isTapped.value? Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    height: 80.h,
                    decoration: BoxDecoration(
                        color: AppColors.green_600,
                        borderRadius: BorderRadius.circular(4.r)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            storageController.sortBy(index: 0);
                          },
                          child: CustomText(
                            text: storageController.sortsList[0],
                            color: AppColors.green_900,
                            fontWeight: FontWeight.w500,
                            bottom: 10,
                          ),
                        ),
                        Container(
                          width: 160.w,
                          height: 1.h,
                          color: AppColors.green_900,),
                        InkWell(
                          onTap: () {
                            storageController.sortBy(index: 1);
                          },
                          child: CustomText(
                            top: 5,
                            text: storageController.sortsList[1],
                            color: AppColors.green_900,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ) : SizedBox()),
                SizedBox(height: 20.h),

                GetBuilder<OCRCreateCardController>(builder: (controller) {
                  return controller.isLoading? Center(child: CircularProgressIndicator()) : SizedBox();
                },),

                ///<<<================== Digital Card List ===================>>>

                Expanded(
                  child: storageController.contacts.isEmpty? Center(child: NoData()) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: storageController.contacts.length,
                    itemBuilder: (context, index) {
                      ContactsModel contacts = storageController.contacts[index];
                      if (kDebugMode) {
                        print("contacts.companyName: ${contacts.companyName}");
                      }
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.contactDetailsScreen, arguments: {"index": index});
                        },
                        child: Container(
                          width: Get.width,
                          height: 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 90.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: DecorationImage(fit: BoxFit.cover,image: FileImage(File(contacts.imageUrl))),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      SizedBox(height: 8.h,),
                                      CustomText(
                                        overflow: TextOverflow.ellipsis,
                                        text: contacts.name,
                                        textAlign: TextAlign.start,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 4.h,),
                                      CustomText(
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        text: contacts.designation,
                                        fontSize: 14,
                                      ),
                                      CustomText(
                                        text: contacts.companyName,
                                        fontSize: 14,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///<<<================ Edit Icon ================>>>
                              SizedBox(width: 4.w,),
                              InkWell(
                                onTap: (){
                                  StorageController.imagePath = contacts.imageUrl;
                                  StorageController.nameController.text = contacts.name;
                                  StorageController.designationController.text = contacts.designation;
                                  StorageController.companyController.text = contacts.companyName;
                                  StorageController.emailController.text = contacts.email;
                                  StorageController.mobilePhoneController.text = contacts.mobilePhone;
                                  StorageController.landPhoneController.text = contacts.landPhone ?? "";
                                  StorageController.faxController.text = contacts.fax ?? "";
                                  StorageController.websiteController.text = contacts.website ?? "";
                                  StorageController.addressController.text = contacts.address;
                                  storageController.id = contacts.id;
                                  StorageController.capturedImageList = contacts.capturedImageList ?? [];


                                  Get.to(CreateOrEditCardScreen(screenTitle: AppStrings.editCard));
                                  StorageController.appTitle = AppStrings.editCard;
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(Icons.border_color_outlined, size: 18,color: AppColors.black_500),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) {

                                      ///<<<==================== Sign out pop up =========================>>>

                                      return AlertDialog(
                                        content: CustomText(text: "Are you sure to delete contacts?".tr, fontSize: 20, color: AppColors.black_500,),
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomElevatedButton(
                                                  onTap: (){
                                                    Get.back();
                                                  },
                                                  text: "No".tr,
                                                  textColor: AppColors.black_500,
                                                  isFillColor: false,
                                                  borderColor: AppColors.green_900,
                                                ),
                                              ),
                                              SizedBox(width: 12,),
                                              Expanded(
                                                child: CustomElevatedButton(
                                                  onTap: (){
                                                    Get.back();
                                                    storageController.deleteContact(contacts.id);
                                                  },
                                                  text: "Yes".tr,
                                                  backgroundColor: AppColors.green_900,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(Icons.delete_forever_rounded, size: 18,color: AppColors.black_500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },),
                ),
              ],
            );
          },),
        ),
      ),
    );
  }
}
