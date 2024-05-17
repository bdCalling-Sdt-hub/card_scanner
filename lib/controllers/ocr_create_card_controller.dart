import 'dart:io';
import 'dart:convert';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../Models/gemimi_response_model.dart';

class OCRCreateCardController extends GetxController{

  final _apiKey = "AIzaSyCq6XUjfldc78sJ88tRjYZrA-BH3SvDfC8";
  GeminiResponseModel? geminiResponseModel;
  TextRecognizer textRecognizer = TextRecognizer();

  List responseList = [];
  String? imagePath;
  List captureImageList = [];
  List textList = [];
  bool isLoading  = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  ///<<<==================== Text Formatting by Gemini Api ==================>>>

  Future<String> textFormatRepo({required String extractedText}) async {
    isLoading = true;
    update();
    if (kDebugMode) {
      print("==========>>$extractedText");
    }
    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$_apiKey");
    final headers = {'Content-Type': 'application/json'};
    var bodyData = {
      "contents": [
        {
          "parts": [
            {"text": "$extractedText, ${"I need only from the text name, designation, company name, email, phone number and address with no key, value pair just only values with '/' separated, if not get the desired value then give blank text".tr} "}
          ]
        }
      ]
    };
    try {
      var response =
      await http.post(url, body: jsonEncode(bodyData), headers: headers);
      isLoading = false;
      update();
      if (kDebugMode) {
        print(response.body);
      }
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (response.statusCode == 200) {
        geminiResponseModel = GeminiResponseModel.fromJson(jsonDecode(response.body));
        final text = geminiResponseModel?.candidates?[0].content?.parts?[0].text;
        if(text != null ){
          var responseText = text.replaceAll(RegExp(r'([*\-\n])'), '');
          if (kDebugMode) {
            print("responseText:::: $responseText");
          }
          List<String> parts = responseText.split('/').map((e) => e.trim()).toList();

          // Extract values and assign them to variables
          String name = parts[0];
          String designation = parts[1];
          String companyName = parts[2];
          String email = parts[3];
          String phoneNumber = parts[4];
          String address = parts.sublist(5).join(', '); // Join remaining parts for address

          StorageController.nameController.text = name;
          StorageController.designationController.text = designation;
          StorageController.companyController.text = companyName;
          StorageController.emailController.text = email;
          StorageController.phoneController.text = phoneNumber;
          StorageController.addressController.text = address;

          Get.to(CreateOrEditCardScreen(screenTitle: AppStrings.createCard));


          // Print the extracted values
          if (kDebugMode) {
            print('Name: $name \nDesignation: $designation \nCompany Name: $companyName \nEmail: $email \nPhone Number: $phoneNumber \nAddress: $address');
          }
        }

        return response.body.toString();
      } else {
        Get.snackbar("Invalid value".tr, "Something went wrong".tr, backgroundColor: AppColors.primaryColor);
        return "Something went wrong";
      }
    } catch (error) {
      Get.snackbar("Invalid value".tr, "Something went wrong".tr, backgroundColor: AppColors.primaryColor);
      if (kDebugMode) {
        print("Error: $error");
      }
      return "Something went wrong";
    }
  }

  ///<<<=================== Get Camera Image ================================>>>
  bool isBothSide = true;

  Future<String?>selectImageCamera({bool? isOcr}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages != null) {
      imagePath = getImages.path;
      update();
      StorageController.imagePath = imagePath;
      if (kDebugMode) {
        print("================>>> $imagePath");
      }
      if(isOcr == true){
        // await processImage(imagePath!);
      }
      captureImageList.add(imagePath);
      update();
      return imagePath;
    }
    return "";
  }

  ///<<<================== Get Gallery Image ================================>>>
  Future<String?>selectImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages != null) {
      imagePath = getImages.path;
      update();
      StorageController.imagePath = imagePath;
      if (kDebugMode) {
        print("================>>> $imagePath");
      }

      await processImage(imagePath!);

      captureImageList.add(imagePath);
      update();
      return imagePath;
    }
    return "";
  }

  ///<<<================== Extract Text From Image ==========================>>>
  Future<String> processImage(String imgPath) async {
    if (kDebugMode) {
      print("============>>>> $imgPath");
    }
    // TODO: implement processImage
    final image = InputImage.fromFile(File(imgPath));

    final recognized = await textRecognizer.processImage(image);
    if (kDebugMode) {
      print("||||||${recognized.text}");
    }
    StorageController.imagePath = imgPath;
    update();
    return recognized.text;
    // textFormatRepo(extractedText: recognized.text);
  }

  ///<<<================== another side call =================================>>>
  // Future<void> anotherSide()async {
  //   showDialog(context: Get.context, builder: builder)
  // }

}
