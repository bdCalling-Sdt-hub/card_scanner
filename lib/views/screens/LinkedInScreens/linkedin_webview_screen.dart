


import 'dart:typed_data';

import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';


class LinkedInWebViewScreen extends StatefulWidget {
  const LinkedInWebViewScreen({super.key});


  @override
  State<LinkedInWebViewScreen> createState() => _LinkedInWebViewScreenState();
}

class _LinkedInWebViewScreenState extends State<LinkedInWebViewScreen> {

  StorageController storageController = Get.put(StorageController());
  final ScreenshotController screenshotController = ScreenshotController();
  late final WebViewController controller;


  Future<Uint8List?> captureAndSaveImage() async{
    final Uint8List? uint8list = await screenshotController.capture();
    print("Uint8list:============>>> $uint8list");
    return uint8list;
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.linkedin.com/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LinkedIn'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: WebViewWidget(
            controller: controller
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        await captureAndSaveImage().then((value) => storageController.getLinkedInImage(imageBytes: value));
        },
        backgroundColor: AppColors.black_500,
        child: Icon(Icons.camera_alt, color: AppColors.green_500,),
      ),
    );
  }
}