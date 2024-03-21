import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/widgets/BottomNavBar/bottom_nav_bar.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:card_scanner/views/widgets/custom_text_field/custom_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_strings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  int currentPosition = 0;
  List serviceList = [
    {"icon": AppIcons.cardSyncIcon, "service": AppStrings.cardSync},
    {"icon": AppIcons.excelIcon, "service": AppStrings.cardExport},
    {"icon": AppIcons.emailIcon, "service": AppStrings.emailSign},
  ];

  List cardsList = [
    {
      'cardImage':
      "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Richard",
    },
    {
      'cardImage':
      "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "",
    },
    {
      'cardImage':
      "https://plus.unsplash.com/premium_photo-1710030733154-16b30a0f944f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8",
      'cardHolderName': "Nicholas",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavBar(currentIndex: 0),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
                width: Get.width,
              ),

              ///<<<=================== Top Bar ===========================>>>

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 30.w),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36.w),
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        onTap: () {},
                        // controller: widget.textEditingController,
                        keyboardType: TextInputType.text,
                        // onChanged: widget.onChanged,
                        maxLines: 1,
                        cursorColor: AppColors.green_200,
                        style: TextStyle(
                          color: AppColors.green_500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 0.h),
                          hintText: "${AppStrings.search}...",
                          hintStyle: const TextStyle(
                            color: AppColors.green_50,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: AppColors.green_900,
                          filled: true,
                          suffixIcon: Icon(
                            Icons.search,
                            color: AppColors.green_50,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              gapPadding: 0),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              gapPadding: 0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              gapPadding: 0),
                        ),
                      ),
                    ),
                  )),
                  Container(
                    height: 24.h,
                    width: 24.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.black_500),
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: AppColors.whiteColor,
                    )),
                  )
                ],
              ),

              ///<<<================= Home Image ===========================>>>
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                child: Image.asset(AppImages.homePageLogo),
              ),

              CustomText(
                text: AppStrings.shareWithAnyone,
                maxLines: 2,
                color: AppColors.black_500,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: CustomElevatedButton(
                  onTap: () {},
                  text: AppStrings.createMyCard,
                  textColor: AppColors.black_500,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  borderRadius: 41,
                  borderColor: AppColors.green_900,
                  isFillColor: false,
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///<<<============== Services List ============================>>>

                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black_500),
                              borderRadius: BorderRadius.circular(8.r)),
                          width: Get.width,
                          height: 76.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: serviceList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        serviceList[index]["icon"]),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    CustomText(
                                      text: serviceList[index]["service"],
                                    )
                                  ],
                                ),
                              );
                            },
                          )),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 4.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.black_500),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Container(
                            height: 4.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.black_500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),

                      ///<<<=============== Card Holder =============================>>>
                      Container(
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
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
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppIcons.groupIcon),
                                            SizedBox(width: 4.w),
                                            CustomText(
                                              text: AppStrings.group,
                                            ),
                                            SizedBox(width: 8.w),
                                            SvgPicture.asset(AppIcons.lineIcon),
                                            SizedBox(width: 8.w),
                                            SvgPicture.asset(
                                                AppIcons.manageIcon),
                                            SizedBox(width: 4.w),
                                            CustomText(
                                              text: AppStrings.manage,
                                            ),
                                          ],
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
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        
                                                        ///<<<================== Bottom Modal Sheet =========================>>>
                                                        
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return Container(
                                                                height: 250,
                                                                width: Get.width,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                    topLeft: Radius.circular(8.r), 
                                                                    topRight: Radius.circular(8.r),),
                                                                  color: AppColors.green_50
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        color: AppColors.black_400,
                                                                        
                                                                      ),
                                                                      child: SvgPicture.asset(AppIcons.crossIcon),
                                                                    )
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                        );
                                                      },
                                                      child: SvgPicture.asset(
                                                          AppIcons.threeDotIcon),
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
                      ),

                    ],
                  ),
                ),
              )
              // Container(
              //   width: Get.width,
              //   height: 72.h,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8.r),
              //     color: AppColors.green_50
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 40.h,
              //         width: 40.w,
              //         decoration: BoxDecoration(
              //           color: AppColors.black_400,
              //           borderRadius: BorderRadius.circular(100),
              //         ),
              //         child: Center(child: SvgPicture.asset(AppIcons.targetIcon)),
              //       ),
              //       Column(
              //         children: [
              //           CustomText(
              //             text: AppStrings.artificialProofreading,
              //             color: AppColors.black_500,
              //             fontWeight: FontWeight.w500,
              //             fontSize: 20,
              //           ),
              //           CustomText(
              //             text: AppStrings.accurateIndentification,
              //             color: AppColors.black_400,
              //             fontWeight: FontWeight.w400,
              //             fontSize: 16,
              //           ),
              //         ],
              //       ),
              //       const Icon(Icons.arrow_forward_ios_rounded),
              //     ],
              //   )
              // )
            ],
          ),
        ),
      ),
    );
  }
}
