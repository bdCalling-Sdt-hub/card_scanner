

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({
    super.key,
    this.icon = Icons.close,
    required this.onTap
  });

  final IconData icon;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24.h,
        width: 24.w,
        decoration: BoxDecoration(
            color: AppColors.black_400,
            borderRadius: BorderRadius.circular(4.r)
        ),
        child: Center(child: Icon(icon, size: 16.w, color: AppColors.green_50,)),
      ),
    );
  }
}