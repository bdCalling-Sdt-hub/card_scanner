
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ScreenShotHelper{

  final GlobalKey _qrImageKey = GlobalKey();

  ///==============Capture image repo=========================>>>
  Future<void> captureAndSaveImage(ScreenshotController screenshotController) async{
    final Uint8List? uint8List = await screenshotController.capture();
    print("uint8List $uint8List");
    if(uint8List != null){
      final PermissionStatus status = await Permission.storage.request();
      if(status.isGranted){
        final result = await ImageGallerySaver.saveImage(uint8List);
        if(result['isSuccess']){
          if (kDebugMode) {
            print("Image saved to gallery");
          }else{
            if (kDebugMode) {
              print("Failed to save image: ${result['error']}");
            }
          }
        }
      }else{
        if (kDebugMode) {
          await Permission.storage.request();
          print("Permission to access storage denied");
        }
      }
    }
  }


  ///RepaintBoundary(
  //           key: _qrImageKey,
  //           child: QrImageView(
  //
  //           ),
  //         ),

  Future<void> _saveQRToGallery(BuildContext context) async {
    try {
      // Capture the rendered QR code image
      RenderRepaintBoundary boundary =
      _qrImageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save the image to the gallery
      final result = await ImageGallerySaver.saveImage(pngBytes);
      if (kDebugMode) {
        print("success $result");
      }

      // Show a confirmation dialog
    } catch (e) {
      if (kDebugMode) {
        print('Failed to save QR code: $e');
      }
      // Show an error dialog
    }
  }
}