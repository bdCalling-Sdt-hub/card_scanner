

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/controllers/profile_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/views/screens/ContactsScreen/all_cards_screen.dart';
import 'package:card_scanner/views/screens/Auth/signin_screen.dart';
import 'package:card_scanner/views/screens/ContactsScreen/contacts_screen.dart';
import 'package:card_scanner/views/screens/Enterprise/enterprise_screen.dart';
import 'package:card_scanner/views/screens/Profile/profile_screen.dart';
import 'package:card_scanner/views/screens/home/InnerWidgets/ocrimage_dialog.dart';
import 'package:card_scanner/views/screens/home/home_screen.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/app_strings.dart';

class BottomNavBar extends StatefulWidget {

  final int currentIndex;

  BottomNavBar({required this.currentIndex, super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  OCRCreateCardController ocrCreateCardController = Get.put(OCRCreateCardController());
  AuthController authController = Get.put(AuthController());
  OcrImageDialog ocrImageDialog = OcrImageDialog();


  List<String> navBarIcons =[
    AppIcons.cardIcon,
    AppIcons.chatIcon,
    AppIcons.ocrCameraIcon,
    AppIcons.globeIcon,
    AppIcons.personIcon
  ];

  bool ifContacts = true;

  @override
  void initState() {
    // TODO: implement initState
    PrefsHelper.getBool(AppStrings.signedIn);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String profileText = PrefsHelper.signedIn? AppStrings.me.tr : AppStrings.signIn.tr;
    List<String> navBarTexts = [
      AppStrings.cards.tr,
      AppStrings.contacts.tr,
      "",
      AppStrings.enterprise.tr,
      profileText
    ];
    return Container(
      height: 90.h,
      width: Get.height,
      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 20.h),
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
                            color: index == widget.currentIndex? AppColors.black_500 : AppColors.black_300,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        index == 2? const SizedBox(): SizedBox(height: 4.h,),
                        CustomText(
                          text: navBarTexts[index],
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: index == widget.currentIndex? AppColors.black_500 : AppColors.black_300,
                        ),
                      ],
                    ),
                  ),
          ),
      ),
    );
  }

  Future<void> onTap(int index) async {
    if(index == 0){
      if(!(widget.currentIndex == 0)){
        Get.to(()=> HomeScreen(),
          transition: Transition.noTransition
        );
      }
    }else if(index == 1){
      if(!(widget.currentIndex == 1)){
          Get.to(()=> AllCardsScreen(), transition: Transition.noTransition);
      }
    }else if(index == 2){
      if(!(widget.currentIndex == 2)){
        String
        responseText =
            await ocrCreateCardController
            .selectImageCamera(isOcr: true)
            .then(
              (value) => ocrCreateCardController.processImage(value!),
        );
        ocrImageDialog.ocrCameraImageDialog(context, responseText);
      }
    }else if(index == 3){
      if(!(widget.currentIndex == 3)){
        Get.to(()=> EnterpriseScreen(),
            transition: Transition.noTransition
        );
      }
    }else if(index == 4){
      if(!(widget.currentIndex == 4)){
        if(PrefsHelper.signedIn){
          Get.offAll(()=> ProfileScreen(),
              transition: Transition.noTransition
          );
        } else{
          Get.offAll(()=> SignInScreen(),
              transition: Transition.noTransition
          );
        }
      }
    }
  }
}

















