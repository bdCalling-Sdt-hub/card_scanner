import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../customText/custom_text.dart';


class CustomElevatedButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final VoidCallback onTap;
  final String text;
  final double height;
  final double width;
  final double top;
  final double left;
  final double right;
  final double bottom;
  final double elevation;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isFillColor;

  const CustomElevatedButton({
    super.key,
    this.backgroundColor = AppColors.green_500,
    this.borderColor = AppColors.black_500,
    this.textColor = AppColors.whiteColor,
    this.borderRadius = 8,
    required this.onTap,
    this.text = "Get Started",
    this.height = 56,
    this.width = double.infinity,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
    this.elevation = 0,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.isFillColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin:
        EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
              color: isFillColor ? Colors.transparent : borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
          color: isFillColor ? backgroundColor : null,
        ),
        child: CustomText(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
          text: text,
        ),
      ),
    );
  }
}