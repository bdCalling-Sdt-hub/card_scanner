import 'dart:convert';
import 'dart:io';

import 'package:card_scanner/controllers/auth/auth_controller.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../Models/contacts_model.dart';

class StorageController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   designationController.dispose();
  //   companyController.dispose();
  //   emailController.dispose();
  //   phoneController.dispose();
  //   addressController.dispose();
  //   id = '';
  //   imagePath = '';
  //   super.dispose();
  // }

  List<ContactsModel> contacts = [];
  static TextEditingController nameController = TextEditingController();
  static TextEditingController designationController = TextEditingController();
  static TextEditingController companyController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  final picker = ImagePicker();
  static String? imagePath;
  String? id;
  bool isLoading = false;

  TextEditingController groupNameController = TextEditingController();
  List<ContactsModel> allContactsForGroup = [];
  List<ContactsModel> singleGroupContacts = [];
  List<ContactGroup> groupedContactsList = [];
  RxList selectedGroupContacts = [].obs;
  static String appTitle = "";


  ///<<<===================== Create group repo ==============================>>>
  List<ContactsModel> createGroup({required int index}) {
    ContactsModel contactsModel = ContactsModel(
        id: selectedGroupContacts[index].id,
        imageUrl: selectedGroupContacts[index].imageUrl,
        name: selectedGroupContacts[index].name,
        designation: selectedGroupContacts[index].designation,
        companyName: selectedGroupContacts[index].companyName,
        email: selectedGroupContacts[index].email,
        phoneNumber: selectedGroupContacts[index].phoneNumber,
        address: selectedGroupContacts[index].address);
    singleGroupContacts.add(contactsModel);
    // ContactGroup group = ContactGroup(name: groupNameController.text, contacts: [contactsModel]);
    return singleGroupContacts;
  }


  ///<<<<<<<<<<<<<<<<<<<<<<<<<<< Phone Local Storage CRUD All Methods >>>>>>>>>>>>>>>>>>>>>>>>>>

  ///<<<--------------------- Load contacts from mobile storage --------------->>>

  Future<void> loadContacts() async {
    allContactsForGroup.clear();
    isLoading = true;
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/contacts.json');
      if (file.existsSync()) {
        final data = await file.readAsString();
        final List<dynamic> jsonList = json.decode(data);
        contacts =
            jsonList.map((json) => ContactsModel.fromJson(json)).toList();
        allContactsForGroup.addAll(contacts);
        update();
      }
      isLoading = false;
    } catch (e) {
      if (kDebugMode) {
        print("Error loading contacts: $e");
      }
    }
  }

  ///<<<---------------------- Save contacts method -------------------------->>>

  Future<void> saveContacts() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/contacts.json');
      if (kDebugMode) {
        print("Directory:>>>>>>>>${directory.path}");
      }
      await file
          .writeAsString(json.encode(contacts.map((c) => c.toJson()).toList()));
    } catch (e) {
      if (kDebugMode) {
        print("Error saving contacts: $e");
      }
    }
  }

  ///<<<---------------------- Add contacts method -------------------------->>>

  Future<void> addContact() async {
    if (imagePath != null && imagePath!.isNotEmpty) {
      id = generateId();
      contacts.add(ContactsModel(
        id: id.toString(),
        imageUrl: imagePath.toString(),
        name: nameController.text,
        designation: designationController.text,
        companyName: companyController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
      ));
      update();
      saveContacts();
      imagePath = "";
      nameController.clear();
      designationController.clear();
      companyController.clear();
      emailController.clear();
      phoneController.clear();
      addressController.clear();
    }
  }

  ///<<<---------------------- Update contacts method ------------------------>>>

  Future<void> updateContact() async {
    if (imagePath != null && imagePath!.isNotEmpty) {
      final existingContactIndex =
      contacts.indexWhere((contact) => contact.id == id);
      if (existingContactIndex != -1) {
        // Update contact details
        contacts[existingContactIndex] = ContactsModel(
          id: id.toString(),
          imageUrl: imagePath.toString(),
          name: nameController.text,
          designation: designationController.text,
          companyName: companyController.text,
          email: emailController.text,
          phoneNumber: phoneController.text,
          address: addressController.text,
        );
        update();
        saveContacts();
      }
    }
  }

  ///<<<---------------------- Delete contacts method ------------------------>>>

  Future<void> deleteContact(String id) async {
    contacts.removeWhere((contact) => contact.id == id);
    update();
    Get.snackbar("The contact is deleted", "");
    saveContacts();
  }

///=============================================================================

  ///<<<-------------------- Generate Id ------------------------------------>>>
  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  ///<<<====================== Image Selection ===============================>>>

  ///<<<---------------------- Gallery Image --------------------------------->>>
  Future<void> getGalleryImage() async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
      cropImage(imgPath: imagePath!);
    }
    update();
  }

  ///<<<---------------------- Camera Image --------------------------------->>>
  Future<void> getCameraImage() async {
    XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
      cropImage(imgPath: imagePath!);
    }
  }

  ///<<<---------------------- LinkedIn Image -------------------------------->>>
  File? file;

  Future<void> getLinkedInImage({Uint8List? imageBytes}) async {
    if (imageBytes != null) {
      file = await DefaultCacheManager().putFile(
        'profile_image.jpg',
        imageBytes,
      );
    }
    if (kDebugMode) {
      print("image path: $file");
    }
    imagePath = file?.path;
    if(imagePath != null){
      cropImage(imgPath: imagePath!);
    }
  }

  ///<<<------------------------- Crop Image --------------------------------->>>

  Future<void> cropImage({required String imgPath}) async {
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
      update();
      Get.offAll(CreateOrEditCardScreen(screenTitle: appTitle));
    }
  }

  ///<<<========================= Card Export Section =========================>>>

  int count = 0;
  List<bool> isSelected = [];
  List<ContactsModel> selectedContacts = [];

  initializeSelectionList() {
    isSelected = List.generate(contacts.length, (index) => false);
    update();
  }

  toggleSelection({required int index}) {
    isSelected[index] = !isSelected[index];

    if (kDebugMode) {
      print("Selected Items: $isSelected");
    }

    if (isSelected[index]) {
      selectedContacts.add(contacts[index]);
      count += 1;
    } else {
      selectedContacts.remove(contacts[index]);
      count -= 1;
    }
    update();
  }

  unSelectAll() {
    isSelected = List.generate(contacts.length, (index) => false);
    count = 0;
    update();
  }



  ///<<<<<<<<<<<<<<<<<<<<<<<<<<< Google Drive All Methods >>>>>>>>>>>>>>>>>>>>>>>>>>

  String? fileId;
  ///<<<===================== save contacts repo =============================>>>

  Future<void> saveContactsInGoogle({String? accessToken}) async {
    try {
      // Encode contacts list to JSON
      final contactsJson = json.encode(contacts.map((c) => c.toJson()).toList());

      // Write contacts JSON to a temporary file
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/contacts.json');
      await file.writeAsString(contactsJson);

      // Upload the contacts JSON file to Google Drive
      if(fileId == null){
        await uploadFile(file, accessToken);
      }else{
        await updateFile(fileId!, file, accessToken);
      }

    } catch (e) {
      if (kDebugMode) {
        print("Error saving contacts: $e");
      }
    }
  }

  ///<<<====================== upload file repo ===============================>>>
  Future<void> uploadFile(File file, String? accessToken) async {
    try {
      if (accessToken == null) {
        print('Access token is null');
        return;
      }

      // Read file bytes
      final List<int> bytes = await file.readAsBytes();

      // Set the filename
      final String fileName = file.path.split('/').last; // Extract filename from file path

      // Create metadata for the file
      final Map<String, dynamic> metadata = {
        'name': fileName, // Set the filename
      };

      // Encode metadata to JSON
      final String metadataJson = json.encode(metadata);

      // Create an HTTP request to upload the file to Google Drive
      final http.Response response = await http.post(
        Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=media&name=$metadata'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/octet-stream',
        },
        body: bytes,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        fileId = responseData['id'];
        if (kDebugMode) {
          print('File uploaded successfully $fileId');
        }
      } else {
        if (kDebugMode) {
          print('File upload failed with status code ${response.statusCode} \n${response.contentLength}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Upload failed: $e');
      }
    }
  }

  ///<<<====================== update file repo ===============================>>>
  Future<void> updateFile(String fileId,File file, String? accessToken )async {
    try{
      if(accessToken == null){
        if (kDebugMode) {
          print("Access token is null");
        }
        return;
      }

      final List<int> bytes = await file.readAsBytes();
      // Update file content
      final http.Response updateResponse = await http.patch(
        Uri.parse('https://www.googleapis.com/upload/drive/v3/files/$fileId?uploadType=media'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bytes,
      );

      if (updateResponse.statusCode == 200) {
        if (kDebugMode) {
          print('File updated successfully');
        }
      } else {
        if (kDebugMode) {
          print('File update failed with status code ${updateResponse.statusCode}');
        }
      }

    }catch(e){
      if (kDebugMode) {
        print('Operation failed: $e');
      }
    }
  }

  ///<<<====================== download file repo =============================>>>
  Future<void> downloadFile(String? accessToken)async {
    try {
      if (accessToken == null) {
        if (kDebugMode) {
          Get.snackbar("Upload contacts before downloading!", "");
          print('Access token is null');
        }
        return;
      }
      final http.Response downloadResponse = await http.get(
        Uri.parse('https://www.googleapis.com/drive/v3/files/$fileId?alt=media'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (downloadResponse.statusCode == 200) {
        // Process downloaded content
        final List<int> fileBytes = downloadResponse.bodyBytes;
        final String fileContent = utf8.decode(fileBytes);
        if (kDebugMode) {
          print(fileContent);
        }

      }else {
        if (kDebugMode) {
          print('File download failed with status code ${downloadResponse.statusCode}');
        }
      }
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Future<void> uploadFile(File file, String? accessToken) async {
  //   try {
  //     if (accessToken == null) {
  //       print('Access token is null');
  //       return;
  //     }
  //
  //     // Read file bytes
  //     final List<int> bytes = await file.readAsBytes();
  //     // Set the filename
  //     final String fileName = file.path.split('/').last; // Extract filename from file path
  //     print(fileName);
  //
  //     // Create metadata for the file
  //     final Map<String, dynamic> metadata = {
  //       'name': fileName, // Set the filename
  //     };
  //
  //     // Encode metadata to JSON
  //     final String metadataJson = json.encode(metadata);
  //
  //     // Create an HTTP request to upload the file to Google Drive
  //     final http.Response response = await http.post(
  //       Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=media'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         // 'Content-Type': 'application/octet-stream',
  //         // 'Content-Length': bytes.length.toString(),
  //       },
  //       body: bytes,
  //     );
  //
  //     // Check the response status code
  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully');
  //     } else {
  //       print('File upload failed with status code ${response.statusCode} \n ${response.body} \n ${response.bodyBytes}');
  //     }
  //   } catch (e) {
  //     print('Upload failed: $e');
  //   }
  // }

}
