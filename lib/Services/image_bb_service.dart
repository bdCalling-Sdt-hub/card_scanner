

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;

class ImageBBService extends GetxController{

  String imageBBApiKey = "30847777af0ce6b464c34af996d1e15c";
  bool isLoading = false;
  bool isDownloading = false;

  Future<String> uploadImage({required File imageFile}) async{
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    isLoading = true;
    update();

    try{
      var response = await http.post(
          Uri.parse('https://api.imgbb.com/1/upload'),
          body: {
            "key" : imageBBApiKey,
            "image" : base64Image,
          }
      );
      isLoading = false;
      update();
      var responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      String imageUrl = responseData['data']['url'];
      return imageUrl;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      isLoading = false;
      update();
    }
    return "";
  }

  Future<String> downloadImage({required String imageUrl}) async{
    isDownloading = true;
    update();
    try{
      var response = await http.get(Uri.parse(imageUrl));
      isDownloading = false;
      update();

      if(response.statusCode == 200){
        final Uint8List bytes = response.bodyBytes;
        final Directory tempDir = await path_provider.getTemporaryDirectory();
        File imageFile = File('${tempDir.path}/card_image.jpg');
        await imageFile.writeAsBytes(bytes);

        return imageFile.path;
      } else{
        throw Exception('Failed to download image: ${response.statusCode}');
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar("Please create your own e-card before sending email,", "No Image url found!");
      isDownloading = false;
      update();
      return "$e";
    }finally{
      isDownloading = false;
      update();
    }
  }

  Future<String> imageCompressor({required String imagePath}) async {
    if (kDebugMode) {
      print("===============>>> Image compressor called");
    }
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/${DateTime.now().microsecondsSinceEpoch}.jpg';
    if (kDebugMode) {
      print("The compressed app: $targetPath");
    }
    try{
      final result = await FlutterImageCompress.compressAndGetFile(imagePath, targetPath, minHeight: 1080, minWidth: 1080, quality: 50);
      return result!.path;
    }catch(e){
      return "Something went wrong: $e";
    }
  }
}