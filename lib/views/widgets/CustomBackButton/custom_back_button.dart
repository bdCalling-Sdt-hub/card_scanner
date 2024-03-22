

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({
    super.key,
    this.icon = Icons.close,
    this.radius = 4,
    this.height = 24,
    this.width = 24,
    this.iconSize = 16,
    this.iconColor = AppColors.green_50,
    this.color = AppColors.black_400,
    required this.onTap
  });

  final IconData icon;
  double radius;
  double height;
  double width;
  double iconSize;
  Color iconColor;
  Color color;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radius.r)
        ),
        child: Center(child: Icon(icon, size: iconSize.w, color: iconColor,)),
      ),
    );
  }
}