
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardScrollController extends GetxController{
  final List<String> imageList = [AppImages.onboardImg1, AppImages.onboardImg2, AppImages.onboardImg3];
  final List<String> titles = [AppStrings.onBoardTitle1, AppStrings.onBoardTitle2, AppStrings.onBoardTitle3];
  final List<String> subTitles = [AppStrings.onBoardSubTitle1, AppStrings.onBoardSubTitle2, AppStrings.onBoardSubTitle3];

  RxInt currentPosition = 0.obs;


}