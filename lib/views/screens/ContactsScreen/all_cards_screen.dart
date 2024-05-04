
import 'dart:io';

import 'package:card_scanner/Models/contacts_model.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: AppStrings.contacts,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.h),

                ///<<<================== Digital Card List ===================>>>

                Expanded(
                  child: storageController.contacts.isEmpty? Center(child: NoData()) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: storageController.contacts.length,
                    itemBuilder: (context, index) {
                      ContactsModel contacts = storageController.contacts[index];
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 4.h,),
                                      CustomText(
                                        overflow: TextOverflow.ellipsis,
                                        text: contacts.designation,
                                        fontSize: 14,
                                      ),
                                      CustomText(
                                        text: contacts.companyName,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              ///<<<================ Edit Icon ================>>>
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  StorageController.imagePath = contacts.imageUrl;
                                  StorageController.nameController.text = contacts.name;
                                  StorageController.designationController.text = contacts.designation;
                                  StorageController.companyController.text = contacts.companyName;
                                  StorageController.emailController.text = contacts.email;
                                  StorageController.phoneController.text = contacts.phoneNumber;
                                  StorageController.addressController.text = contacts.address;
                                  storageController.id = contacts.id;

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
                                        content: CustomText(text: "Are you sure to delete contacts?", fontSize: 20, color: AppColors.black_500,),
                                        actions: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CustomElevatedButton(
                                                  onTap: (){
                                                    Get.back();
                                                  },
                                                  text: "No",
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
                                                  text: "Yes",
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
                )
              ],
            );
          },),
        ),
      ),
    );
  }
}
