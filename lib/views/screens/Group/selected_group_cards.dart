

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_scanner/Models/contacts_model.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:flutter/material.dart';


import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../widgets/customButton/custom_elevated_button.dart';

// ignore: must_be_immutable
class SelectedGroupCards extends StatelessWidget {
  SelectedGroupCards({super.key});

  int groupIndex = Get.arguments['index'];
  StorageController storageController = Get.put(StorageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: GetBuilder<StorageController>(builder: (storageController) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child:CustomBackButton(
                    onTap: (){
                      Get.back();
                    },
                    icon: Icons.arrow_back,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    const Icon(Icons.groups),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: "${AppStrings.group.tr}: ${storageController.groupedContactsList[groupIndex].name}",
                      color: AppColors.black_500,
                      fontSize: 16,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        storageController.groupNameController.text = storageController.groupedContactsList[groupIndex].name;
                        if(storageController.selectedGroupContacts.isEmpty){
                          storageController.selectedGroupContacts.addAll(storageController.groupedContactsList[groupIndex].contactsList);
                        }
                        Get.toNamed(AppRoutes.editGroupScreen, arguments: {"groupIndex" : groupIndex});
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
                    SizedBox(width: 4.w,),
                  ],
                ),
                const Divider(color: AppColors.black_400),
                SizedBox(height: 20.h),

                ///<<<=================== Cards List ========================>>>

                Expanded(
                  child: ListView.builder(
                    itemCount: storageController.groupedContactsList[groupIndex].contactsList.length,
                    itemBuilder: (context, index) {
                      List<ContactsModel> contactsList = storageController.groupedContactsList[groupIndex].contactsList;
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.groupContactDetailScreen, arguments: {"groupIndex" : groupIndex, "contactIndex": index});
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r)
                          ),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: contactsList[index].imageUrl,
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8.r),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                    height: 90.h,
                                    width: 90.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                        color: AppColors.green_600
                                    ),
                                    child: Center(child: CircularProgressIndicator())),
                                errorWidget: (context, url, error) => Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8.r),
                                      color: AppColors.green_600
                                  ),
                                  child: Icon(Icons.error),
                                ),
                              ),
                              // Container(
                              //   height: 90.h,
                              //   width: 90.w,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(8.r),
                              //     image: DecorationImage(fit: BoxFit.cover,image: FileImage(File(contactsList[index].imageUrl))),
                              //   ),
                              // ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8.h,),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        text: contactsList[index].name,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 4.h,),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        text: contactsList[index].designation,
                                        fontSize: 12,
                                      ),
                                      CustomText(
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        text: contactsList[index].companyName,
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
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
                                                  height: 48.h,
                                                  textColor: AppColors.black_500,
                                                  isFillColor: false,
                                                  borderColor: AppColors.green_900,
                                                ),
                                              ),
                                              SizedBox(width: 12.w,),
                                              Expanded(
                                                child: CustomElevatedButton(
                                                  onTap: (){
                                                    storageController.deleteGroupContactRepo(groupIndex: groupIndex, listIndex: index);
                                                    // storageController.deleteGroupRepo(index: index);
                                                  },
                                                  text: "Yes".tr,
                                                  height: 48.h,
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
                                  child: Icon(Icons.delete_forever_rounded, size: 20,color: AppColors.black_500),
                                ),
                              ),
                              SizedBox(width: 6.w),
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

