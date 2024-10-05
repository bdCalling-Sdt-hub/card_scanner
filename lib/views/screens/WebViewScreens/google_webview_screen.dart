

import 'package:card_scanner/Helpers/screen_shot_helper.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';


class GoogleWebViewScreen extends StatefulWidget {
  const GoogleWebViewScreen({super.key});


  @override
  State<GoogleWebViewScreen> createState() => _GoogleWebViewScreenState();
}

class _GoogleWebViewScreenState extends State<GoogleWebViewScreen> {

  StorageController storageController = Get.put(StorageController());
  final ScreenshotController screenshotController = ScreenshotController();
  ScreenShotHelper screenShotHelper = ScreenShotHelper();
  late final WebViewController controller;

  // Future<Uint8List?> captureAndSaveImage() async{
  //   final Uint8List? uint8list = await screenshotController.capture();
  //   print("Uint8list:============>>> $uint8list");
  //   return uint8list;
  // }

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
      ..loadRequest(Uri.parse('https://www.google.com/webhp'));
    controller.setOnConsoleMessage((message) {
      // controller.reload();
      // Get.snackbar(message.message, "");

      if (kDebugMode) {
        print("message: =========>> ${message.message}");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: CustomText(text:'Google Search'.tr, fontSize: 20, fontWeight: FontWeight.w500,)),
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomBackButton(
            onTap: (){Get.back();},
            icon: Icons.arrow_back,
          ),
        ),
        actions: [
          SizedBox(width: 50.w,),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: WebViewWidget(
            controller: controller
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await screenShotHelper.captureAndSaveImage(screenshotController: screenshotController).then((value) => storageController.getOnlineImage(imageBytes: value));
        },
        backgroundColor: AppColors.black_500,
        child: Icon(Icons.camera_alt, color: AppColors.green_500,),
      ),
    );
  }
}