

import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/views/screens/ContactsScreen/contacts_screen.dart';
import 'package:card_scanner/views/screens/Enterprise/enterprise_screen.dart';
import 'package:card_scanner/views/screens/home/home_screen.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../../../utils/app_strings.dart';

class BottomNavBar extends StatelessWidget {

  final int currentIndex;

  BottomNavBar({required this.currentIndex, super.key});


  List<String> navBarIcons =[
    AppIcons.cardIcon,
    AppIcons.chatIcon,
    AppIcons.ocrCameraIcon,
    AppIcons.globeIcon,
    AppIcons.personIcon
  ];

  List<String> navBarTexts = [
    AppStrings.cards,
    AppStrings.contacts,
    "",
    AppStrings.enterprise,
    AppStrings.signIn
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 90.h,
      width: Get.height,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 20.h),
      alignment: Alignment.center,
      color: AppColors.primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
              navBarIcons.length,
                  (index) => InkWell(
                    onTap: () => onTap(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        index == 2? SizedBox(height: 8.h,) : const SizedBox(),
                        Center(
                          child: SvgPicture.asset(
                            navBarIcons[index],
                            color: index == currentIndex? AppColors.black_500 : AppColors.black_300,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        index == 2? const SizedBox(): SizedBox(height: 4.h,),
                        CustomText(
                          text: navBarTexts[index],
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: index == currentIndex? AppColors.black_500 : AppColors.black_300,
                        ),
                      ],
                    ),
                  ),
          ),
      ),
    );
  }

  void onTap(int index) {
    if(index == 0){
      if(!(currentIndex == 0)){
        Get.offAll(()=> HomeScreen(),
          transition: Transition.noTransition
        );
      }
    }else if(index == 1){
      if(!(currentIndex == 1)){
        Get.offAll(()=> ContactsScreen(),
            transition: Transition.noTransition
        );
      }
    }else if(index == 3){
      if(!(currentIndex == 3)){
        Get.offAll(()=> EnterpriseScreen(),
            transition: Transition.noTransition
        );
      }
    }
  }
}

















