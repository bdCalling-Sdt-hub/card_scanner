
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../widgets/customText/custom_text.dart';

// ignore: must_be_immutable
class CustomContainerButton extends StatelessWidget {
  CustomContainerButton({
    super.key,
    this.height = 25,
    this.width = 55,
    this.radius = 8,
    this.backgroundColor = AppColors.green_900,
    this.icon = Icons.border_color_outlined,
    this.iconColor = AppColors.green_50,
    this.iconSize = 14,
    this.farWidth = 4,
    required this.text,
    this.textColor = AppColors.green_50,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.imageHeight = 30,
    this.imageWidth = 30,
    this.ifImage = false,
    this.svgIcon = "",
    this.ifBorder = false,
    required this.onTap,
    this.paddingH = 4,
    this.paddingV = 0,

  });

  double height;
  double width;
  double radius;
  double iconSize;
  Color backgroundColor;
  Color iconColor;
  Color textColor;
  IconData icon;
  String svgIcon;
  double imageHeight;
  double imageWidth;
  bool ifImage;
  bool ifBorder;
  double farWidth;
  double fontSize;
  FontWeight fontWeight;
  String text;
  VoidCallback onTap;
  double paddingH;
  double paddingV;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: ifBorder? null : backgroundColor,
            border: Border.all(color: backgroundColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ifImage
                ? SvgPicture.asset(svgIcon, height: imageHeight.h, width: imageWidth.w, color: iconColor)
                : Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            SizedBox(width: farWidth.w),
            CustomText(
              text: text.tr,
              color: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
            )
          ],
        ),
      ),
    );
  }
}