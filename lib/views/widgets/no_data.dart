
import 'package:card_scanner/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_images.dart';
import 'customText/custom_text.dart';
import 'custom_image.dart';


class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImage(
            imageSrc: AppImages.noData,
            imageType: ImageType.png,
            size: 70.sp,
          ),
          CustomText(
            text: AppStrings.noData,
            fontSize: 16.h,
            top: 8.h,
          )
        ],
      ),
    );
  }
}
