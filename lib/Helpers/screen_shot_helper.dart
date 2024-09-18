

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShotHelper{


  static String downloadImagePath = "" ;
  ///============== Capture image repo=========================>>>
  Future<Uint8List?> captureAndSaveImage({required ScreenshotController screenshotController, bool isShare = false}) async{
    final Uint8List? uint8List = await screenshotController.capture();
    if (kDebugMode) {
      print("uint8List $uint8List");
    }

    if(uint8List != null){
      final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
      final AndroidDeviceInfo androidInfo = await info.androidInfo;
      debugPrint('releaseVersion : ${androidInfo.version.release}');
      final int androidVersion = int.parse(androidInfo.version.release);

      if (androidVersion >= 13) {
        final request = await Permission.photos.request(); //import 'package:permission_handler/permission_handler.dart';
        debugPrint('IsPermission Granted? : ${request.isGranted}');
        final result = await ImageGallerySaverPlus.saveImage(uint8List,name: "screen_shot_mage",);

        if(isShare){
          if (kDebugMode) {
            print("============>>> $result");
          }
          return uint8List;
          // downloadImagePath = result["filePath"].toString().split(":")[1];
        } else{
          if(result['isSuccess']){
            Get.snackbar("Image downloaded to your phone gallery".tr, "");
            if (kDebugMode) {
              print("Image saved to gallery");
            }else{
              if (kDebugMode) {
                print("Failed to save image: ${result['error']}");
              }
            }
          }
        }
      }
      if(androidVersion < 13){
        final PermissionStatus status = await Permission.storage.request();
        if(status.isGranted){
          final result = await ImageGallerySaverPlus.saveImage(uint8List,name: "screen_shot_mage",);
          if(isShare){
            return uint8List;
          } else{
            if(result['isSuccess']){
              Get.snackbar("Image downloaded to your phone gallery".tr, "");
              if (kDebugMode) {
                print("Image saved to gallery");
              }else{
                if (kDebugMode) {
                  print("Failed to save image: ${result['error']}");
                }
              }
            }
          }
        }else{
          await Permission.storage.request();
          if (kDebugMode) {
            print("Permission to access storage denied");
          }
        }
      }
    }else{
      Get.snackbar("Screenshot is failed".tr, "");
    }
    return uint8List;
  }

  ///=================>> Gallery Image Save Repo <<<============================
  Future<void> galleryImageSaver({Uint8List? uint8List}) async {
    if(uint8List != null){
      final PermissionStatus status = await Permission.storage.request();
      if(status.isGranted){
        final result = await ImageGallerySaverPlus.saveImage(uint8List,name: "QrCodeImage");
        if(result['isSuccess']){
          Get.snackbar("Image downloaded to your phone gallery".tr, "");
          if (kDebugMode) {
            print("Image saved to gallery");
          }else{
            if (kDebugMode) {
              print("Failed to save image: ${result['error']}");
            }
          }
        }
      }else{
        await Permission.storage.request();
        if (kDebugMode) {
          print("Permission to access storage denied");
        }
      }
    }else{
      Get.snackbar("Screenshot is failed".tr, "");
    }
  }

  ///=================>> Get Captured Image Path <<============================
  File? file;
  Future<File?> getImagePath({Uint8List? imageBytes}) async {
    if (imageBytes != null) {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/profile_image.jpg';
      file = File(path);
      await file!.writeAsBytes(imageBytes);
    }
    return file;
  }



///==============another method Capture image save to gallery repo=========================>>>
  //RepaintBoundary(
  //           key: _qrImageKey,
  //           child: QrImageView(
  //
  //           ),
  //         ),
  //
  // final GlobalKey _qrImageKey = GlobalKey();
  //
  // Future<void> _saveQRToGallery(BuildContext context) async {
  //   try {
  //     // Capture the rendered QR code image
  //     RenderRepaintBoundary boundary =
  //     _qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage(pixelRatio: 2.0);
  //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();
  //
  //     // Save the image to the gallery
  //     final result = await ImageGallerySaver.saveImage(pngBytes);
  //     if (kDebugMode) {
  //       print("success $result");
  //     }
  //
  //     // Show a confirmation dialog
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Failed to save QR code: $e');
  //     }
  //     // Show an error dialog
  //   }
  // }
}


///==============another method Capture image save to gallery repo=========================>>>
//   ///==============Capture image repo=========================>>>
//   Future<void> captureAndSaveImage(ScreenshotController screenshotController) async{
//     final Uint8List? uint8List = await screenshotController.capture();
//     print("uint8List $uint8List");
//     if(uint8List != null){
//       getUint8Image(imageBytes: uint8List);
//     }
//   }
//
//
//   Future<void> getUint8Image({Uint8List? imageBytes}) async {
//     if (imageBytes != null) {
//       // Convert Uint8List to Image
//       img.Image image = img.decodeImage(imageBytes)!;
//
//       // Create a temporary file with a unique name
//       final tempDir = await getTemporaryDirectory();
//       final tempPath = tempDir.path;
//       final tempFile = File('$tempPath/temp_image.jpg');
//
//       // Write the image to the temporary file
//       await tempFile.writeAsBytes(img.encodeJpg(image));
//
//       // Save the image to the gallery
//       await saveImageToGallery(tempFile);
//
//       // Clean up: Delete the temporary file
//       await tempFile.delete();
//     }
//   }
//
//   Future<void> saveImageToGallery(File imageFile) async {
//     // Save the image file to the gallery
//     final result = await ImageGallerySaver.saveFile(imageFile.path);
//     final PermissionStatus status = await Permission.storage.request();
//     if(status.isGranted){
//       if (result['isSuccess']) {
//         if (kDebugMode) {
//           print("Image saved to gallery");
//           print(result);
//         }
//       } else {
//         if (kDebugMode) {
//           print("Failed to save image: ${result['error']}");
//         }
//       }
//     }else{
//       if (kDebugMode) {
//         await Permission.storage.request();
//         print("Permission to access storage denied");
//       }
//     }
//   }
// }