

import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../widgets/customButton/custom_elevated_button.dart';
import '../../../widgets/customText/custom_text.dart';

class OcrImageDialog{

  OCRCreateCardController ocrCreateCardController = Get.put(OCRCreateCardController());
  Future<dynamic> ocrCameraImageDialog(BuildContext context, String responseText) {
    return showDialog(
      context:
      context,
      builder:
          (context) {
        return ocrCreateCardController.isLoading
            ? Center(child: CircularProgressIndicator())
            : AlertDialog(
          content: CustomText(
            maxLines: 2,
            text: "Do you want scan back part of your card".tr,
            fontSize: 20,
            color: AppColors.black_500,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onTap: () {
                      Get.back();
                      ocrCreateCardController.textFormatRepo(extractedText: responseText);
                    },
                    text: "No".tr,
                    textColor: AppColors.black_500,
                    isFillColor: false,
                    borderColor: AppColors.green_900,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: CustomElevatedButton(
                    onTap: () async {
                      // SystemNavigator.pop();
                      Get.back();
                      String newResponse = await ocrCreateCardController.selectImageCamera().then((value) => ocrCreateCardController.cropImage(imgPath: value!, isOcr: true),).then((value) => ocrCreateCardController.processImage(value!),);
                      responseText += newResponse;
                      ocrCreateCardController.textFormatRepo(extractedText: responseText);
                    },
                    text: "Yes".tr,
                    backgroundColor: AppColors.green_900,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> ocrGalleryImageDialog(BuildContext context, String responseText) {
    return showDialog(
      context:
      context,
      builder:
          (context) {
        return ocrCreateCardController.isLoading
            ? Center(child: CircularProgressIndicator())
            : AlertDialog(
          content: CustomText(
            maxLines: 2,
            text: "Do you want scan back part of your card".tr,
            fontSize: 20,
            color: AppColors.black_500,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onTap: () {
                      Get.back();
                      ocrCreateCardController.textFormatRepo(extractedText: responseText);
                    },
                    text: "No".tr,
                    textColor: AppColors.black_500,
                    isFillColor: false,
                    borderColor: AppColors.green_900,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: CustomElevatedButton(
                    onTap: () async {
                      // SystemNavigator.pop();
                      Get.back();
                      String newResponse = await ocrCreateCardController.selectImageGallery().then((value) => ocrCreateCardController.cropImage(imgPath: value!),).then((value) => ocrCreateCardController.processImage(value!),);
                      responseText += newResponse;
                      ocrCreateCardController.textFormatRepo(extractedText: responseText);
                    },
                    text: "Yes".tr,
                    backgroundColor: AppColors.green_900,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}