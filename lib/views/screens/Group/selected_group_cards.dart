
import 'package:flutter/material.dart';


import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';

class SelectedGroupCards extends StatelessWidget {
  SelectedGroupCards({super.key});

  List cardDetailsList = [
    {"image": "https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1711008338~exp=1711011938~hmac=3a05225c2a75c0c003c9f09d51c3fbb6cda1d0189f31e94c8f72555a28854f63&w=826", "name" : "Michael Chen", "companyName" : "XYZ Tech Solutions", "designation" : "Senior Software Engineer" },
    {"image": "https://img.freepik.com/free-photo/portrait-young-businesswoman-holding-eyeglasses-hand-against-gray-backdrop_23-2148029483.jpg?t=st=1711008375~exp=1711011975~hmac=511516ca747144f164ba632e645a5e64ec5b83132241f31a387017b30764cff6&w=826", "name" : "Emily Rodriguez", "companyName" : "Global Finance Group", "designation" : "Financial Analyst" },
    {"image": "https://img.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg?t=st=1711008418~exp=1711012018~hmac=0e5c69783af897de4032dee9e55d26366c4a747abe603bbdf93c1d64cd208b47&w=1380", "name" : "Lisa Nguyen", "companyName" : "Stellar Designs LLC", "designation" : "Creative Director" },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
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
                    text: "${AppStrings.group}: ${AppStrings.alpha}",
                    color: AppColors.black_500,
                    fontSize: 16,
                  )
                ],
              ),
              const Divider(color: AppColors.black_400),
              SizedBox(height: 20.h),

              ///<<<=================== Cards List ========================>>>

              Expanded(
                child: ListView.builder(
                  itemCount: cardDetailsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Get.width,
                      height: 100.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r)
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 90.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(cardDetailsList[index]["image"])),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.h,),
                                CustomText(
                                  text: cardDetailsList[index]["name"],
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(height: 4.h,),
                                CustomText(
                                  text: cardDetailsList[index]["companyName"],
                                ),
                                CustomText(
                                  text: cardDetailsList[index]["designation"],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },),
              )
            ],
          ),
        ),
      ),
    );
  }
}

