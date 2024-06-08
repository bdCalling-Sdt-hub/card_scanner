import 'dart:io';
import 'dart:convert';
import 'package:card_scanner/Services/image_bb_service.dart';
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../Models/gemimi_response_model.dart';

class OCRCreateCardController extends GetxController{

  final _apiKey = "AIzaSyCq6XUjfldc78sJ88tRjYZrA-BH3SvDfC8";
  GeminiResponseModel? geminiResponseModel;
  TextRecognizer textRecognizer = TextRecognizer(script: TextRecognitionScript.chinese);
  ImageBBService imageBBService = ImageBBService();

  String? imagePath;
  static List<String> capturedImageList = [];
  List textList = [];
  bool isLoading  = false;


  ///<<<==================== Text Formatting by Gemini Api ==================>>>

  String cleanJsonString(String jsonString) {
    // Check if the JSON string contains backticks and newlines
    if (jsonString.contains('```json\n')) {
      // Remove backticks and newlines using RegExp
      jsonString = jsonString.replaceAll('```json\n', '').replaceAll('\n```', '');
    }
    return jsonString;
  }

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
            {"text": "$extractedText, 'Extract data from the above text and give the response as like this format: ${'{"imageUrl": "imageUrl", "name": "name", "designation": "designation", "company_name": "company name", "email": "email address", "mobile_phone": "mobile phone number", "land_phone": "land phone number", "fax": "fax number", "website": "web address", "address": "location address"}, if you get any data of the mentioned fields then please put it on the specific field and if get Chinese or Japanese  language then give response values in that language please'.tr}"}
          ]
        }
      ]
    };
    try {
      var response = await http.post(url, body: jsonEncode(bodyData), headers: headers).timeout(Duration(seconds: 30));
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
          RegExp pattern = RegExp(r'[\n*-]');
          final cleanText = cleanJsonString(text);
          Map<String, dynamic> responseText = jsonDecode(cleanText.replaceAll(pattern, ""));
          if (kDebugMode) {
            print("responseText:::: $responseText");
          }


          String imageUrl = responseText['imageUrl'] ?? '';
          String name = responseText['name'] ?? '';
          String designation = responseText['designation'] ?? '';
          String companyName = responseText['company_name'] ?? '';
          String email = responseText['email'] ?? '';
          String mobilePhone = responseText['mobile_phone'] ?? '';
          String landPhone = responseText['land_phone']?.toString() ?? ''; // Handle null value
          String fax = responseText['fax']?.toString() ?? ''; // Handle null value
          String website = responseText['website']?.toString() ?? ''; // Handle null value
          String address = responseText['address'] ?? '';
          // List<String> parts = responseText.split('/').map((e) => e.trim()).toList();
          //
          // // Extract values and assign them to variables
          // name = parts[0];
          // designation = parts[1];
          // companyName = parts[2];
          // email = parts[3];
          // phoneNumber = parts[4];
          // address = parts.sublist(5).join(', '); // Join remaining parts for address
          //

          if(imageUrl != ''){
            StorageController.imagePath = imageUrl;
          }
          StorageController.nameController.text = name;
          StorageController.designationController.text = designation;
          StorageController.companyController.text = companyName;
          StorageController.emailController.text = email;
          StorageController.mobilePhoneController.text = mobilePhone;
          StorageController.landPhoneController.text = landPhone;
          StorageController.faxController.text = fax;
          StorageController.websiteController.text = website;
          StorageController.addressController.text = address;


          Get.to(CreateOrEditCardScreen(screenTitle: AppStrings.createCard));


          // Print the extracted values
          if (kDebugMode) {
            print('ImageUrl: $imageUrl \nName: $name \nDesignation: $designation \nCompany Name: $companyName \nEmail: $email \nMobile Phone: $mobilePhone \nLand Phone: $landPhone \nFax: $fax \nWebsite: $website \nAddress: $address');
          }
        }

        return response.body.toString();
      } else {
        Get.snackbar("Invalid value".tr, "Something went wrong, Try again!".tr, backgroundColor: AppColors.primaryColor);
        return "Something went wrong";
      }
    } catch (error) {
      isLoading = false;
      update();
      Get.snackbar("Invalid value".tr, "Something went wrong".tr, backgroundColor: AppColors.primaryColor);
      if (kDebugMode) {
        print("Error: $error");
      }
      return "Something went wrong";
    }
  }

  ///<<<=================== Get Camera Image ================================>>>
  bool isBothSide = true;

  Future<String?>selectImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages != null) {
      imagePath = getImages.path;
      update();
      StorageController.imagePath = imagePath;
      // imagePath = await imageBBService.imageCompressor(imagePath: imagePath!);
      if (kDebugMode) {
        print("================>>> $imagePath");
      }
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
      return imagePath;
    }
    return "";
  }

  ///<<<================== Crop Image =======================================>>>
  Future<String?> cropImage({required String imgPath, bool? isOcr}) async {
    if (kDebugMode) {
      print("Image Path: $imgPath");
    }
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgPath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      imagePath = croppedFile.path;
      // imagePath = await imageBBService.imageCompressor(imagePath: croppedFile.path).then((value) => imageBBService.uploadImage(imageFile: File(value)));

      if(isOcr == true){
        isLoading = true;
        update();
        await imageBBService.imageCompressor(imagePath: croppedFile.path).then((value) => imageBBService.uploadImage(imageFile: File(value))).then((value){
          capturedImageList.add(value);
          if (kDebugMode) {
            print("ImageBB uploaded Image: $value");
          }
          StorageController.imagePath = value;
        });
        isLoading = false;
        update();
      }
      update();
    }
    return imagePath;
  }

  ///<<<================== Extract Text From Image ==========================>>>
  Future<String> processImage(String imgPath) async {
    if (kDebugMode) {
      print("============>>>> $imgPath");
    }
    // TODO: implement processImage
    final image = InputImage.fromFile(File(imgPath));

    final recognized = await textRecognizer.processImage(image);
    String text = '';
    for (TextBlock block in recognized.blocks) {
      for (TextLine line in block.lines) {
        text += '${line.text}\n';
      }
    }
    if (kDebugMode) {
      print("||||||$text");
    }
    // StorageController.imagePath = imgPath;
    update();
    return text;
    // textFormatRepo(extractedText: recognized.text);
  }

  ///<<<================== another side call =================================>>>
  // Future<void> anotherSide()async {
  //   showDialog(context: Get.context, builder: builder)
  // }

}
