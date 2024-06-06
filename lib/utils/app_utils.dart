import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../views/widgets/customText/custom_text.dart';
import 'app_colors.dart';


class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage({required String message, IconData icon = Icons.check}) {
    FToast fToast = FToast();

    if (Get.context != null) {
      fToast.init(Get.context!);
      Widget toast = Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: AppColors.green_600,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            SizedBox(
              width: 12.w,
            ),
            Flexible(
              child: CustomText(
                text: message,
                textAlign: TextAlign.center,
                maxLines: 2,
                color: AppColors.blackColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    } else {
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.greenAccent,
        textColor: AppColors.blackColor,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  static snackBarMessage(String title, String message) {
    Get.snackbar(kDebugMode ? title : 'oops!', message,
        backgroundColor: AppColors.blackColor);
  }
}