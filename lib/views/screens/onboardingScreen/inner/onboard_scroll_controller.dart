
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:get/get.dart';

class OnBoardScrollController extends GetxController{
  final List<String> imageList = [AppImages.onboardImg1, AppImages.onboardImg2, AppImages.onboardImg3];
  final List<String> titles = [AppStrings.onBoardTitle1.tr, AppStrings.onBoardTitle2.tr, AppStrings.onBoardTitle3.tr];
  final List<String> subTitles = [AppStrings.onBoardSubTitle1.tr, AppStrings.onBoardSubTitle2.tr, AppStrings.onBoardSubTitle3.tr];

  RxInt currentPosition = 0.obs;

}