import 'package:card_scanner/views/screens/home/InnerWidgets/manage_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/customText/custom_text.dart';
import 'open_modal_sheet.dart';

class CardHolder extends StatelessWidget {
  const CardHolder({
    super.key,
    required this.cardsList,
  });

  final List cardsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.green_50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: cardsList.isNotEmpty
          ? Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 12.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                CustomText(
                  text: AppStrings.cards,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_500,
                  fontSize: 16,
                ),
                CustomText(
                  text: "(${cardsList.length})",
                ),
                const Spacer(),

                ///<<<==================== Group Text =======================>>>

                InkWell(
                  onTap: (){
                    Get.toNamed(AppRoutes.groupScreen);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          AppIcons.groupIcon),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: AppStrings.group,
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ),
                SvgPicture.asset(AppIcons.lineIcon),

                ///<<<=============== Manage Text ===========================>>>

                InkWell(
                  onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ManageModalSheet();
                        },
                      );
                    },
                  child: Row(
                    children: [
                      SizedBox(width: 8.w),
                      SvgPicture.asset(
                          AppIcons.manageIcon),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: AppStrings.manage,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 8.h),
            child: SizedBox(
              height: (100 * cardsList.length).toDouble(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.w),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(4),
                        color: AppColors.green_300,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                height: 100.h,
                                width: 120.w,
                                child: Image.network(
                                    cardsList[index]
                                    ["cardImage"])),
                            SizedBox(
                              width: 8.w,
                            ),
                            CustomText(
                              text: cardsList[index]
                              ["cardHolderName"] == ""
                                  ? "Unknown"
                                  :cardsList[index]
                              ["cardHolderName"],
                              color: AppColors.black_500,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {

                                ///<<<================== Bottom Modal Sheet =========================>>>

                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return OpenModalSheet();
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppIcons.threeDotIcon, fit: BoxFit.cover,),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 42.h,
          ),
        ],
      )
          : Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16.h, left: 12.w),
              child: CustomText(
                text: AppStrings.cards,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  height: 74.h,
                  width: 74.w,
                  child:
                  Image.asset(AppImages.cardLogo)),
              SizedBox(
                height: 16.h,
              ),
              CustomText(
                text: AppStrings.noCards,
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w),
                child: CustomText(
                  maxLines: 3,
                  text: AppStrings
                      .useBusinessCardRecognitionFunction,
                ),
              )
            ],
          ),
          SizedBox(
            height: 42.h,
          ),
        ],
      ),
    );
  }
}