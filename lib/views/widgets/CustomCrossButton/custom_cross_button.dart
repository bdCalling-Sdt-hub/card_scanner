

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';

class CustomCrossButton extends StatelessWidget {
  const CustomCrossButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      width: 24.w,
      decoration: BoxDecoration(
          color: AppColors.black_400,
          borderRadius: BorderRadius.circular(4.r)
      ),
      child: Center(child: SvgPicture.asset(AppIcons.crossIcon, height: 12.h, width: 12.w,)),
    );
  }
}