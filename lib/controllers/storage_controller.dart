import 'dart:convert';
import 'dart:io';

import 'package:card_scanner/Services/image_bb_service.dart';
import 'package:card_scanner/controllers/ocr_create_card_controller.dart';
import 'package:card_scanner/views/screens/CreateCard/create_edit_card_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

import '../Helpers/prefs_helper.dart';
import '../Models/contacts_model.dart';
import '../core/routes/app_routes.dart';
import '../utils/app_strings.dart';
import 'package:path/path.dart' as p;

import '../views/screens/ContactsScreen/contact_details_screen.dart';

class StorageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    loadContacts().then((value) => initializeSelectionList());
    allContactsForGroup.clear();
    groupedContactsList = PrefsHelper.groupedContactsList;
    super.onInit();
  }


  ImageBBService imageBBService = ImageBBService();

  List<ContactsModel> contacts = [];
  static List<String> capturedImageList = [];
  static TextEditingController nameController = TextEditingController();
  static TextEditingController designationController = TextEditingController();
  static TextEditingController companyController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController mobilePhoneController = TextEditingController();
  static TextEditingController landPhoneController = TextEditingController();
  static TextEditingController faxController = TextEditingController();
  static TextEditingController websiteController = TextEditingController();
  static TextEditingController noteController = TextEditingController();
  static TextEditingController addressController = TextEditingController();
  final picker = ImagePicker();
  static String? imagePath;
  String? id;
  bool isLoading = false;

  TextEditingController groupNameController = TextEditingController();
  List<ContactsModel> allContactsForGroup = [];
  List<ContactsModel> singleGroupContacts = [];
  List<ContactGroup> groupedContactsList = [];

  Set<ContactsModel> selectedGroupContactsSet = <ContactsModel>{};
  RxList<ContactsModel> selectedGroupContacts = <ContactsModel>[].obs;
  static String appTitle = "";

  RxBool isLandPhone = false.obs;
  RxBool isFax = false.obs;
  RxBool isWebsite = false.obs;
  List formFieldsList = [
    "Land Phone".tr,
    "Fax".tr,
    "Website".tr,
  ];

  ///<<<============ Clear all controller ======================>>>>

  void clearControllers(){
    imagePath = "";
    id = "";
    nameController.text = "";
    designationController.text = "";
    companyController.text = "";
    emailController.text = "";
    mobilePhoneController.text = "";
    landPhoneController.text = "";
    faxController.text = "";
    websiteController.text = "";
    addressController.text = "";
    capturedImageList = [];
    noteController.text = "";
    capturedImageList = [];
  }

  ///<<<=============== Sorting Repo ==================================>>>
  RxBool isTapped = false.obs;
  List sortsList = ["Sorts by person name".tr, "Sorts by company name".tr];

  sortBy({required int index}) {
    if (index == 0) {
      contacts
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      update();
    } else if (index == 1) {
      contacts.sort((a, b) =>
          a.companyName.toLowerCase().compareTo(b.companyName.toLowerCase()));
      update();
    }
    isTapped.value = false;
  }

  ///<<<============= To remove duplicate contacts ===========================>>>

  void addSelectedContact(ContactsModel contact) {
    selectedGroupContactsSet.add(contact);
    selectedGroupContacts.value = selectedGroupContactsSet.toList();
  }

  void addMultipleSelectedContacts(List<ContactsModel> contacts) {
    selectedGroupContactsSet.addAll(contacts);
    selectedGroupContacts.value = selectedGroupContactsSet.toList();
  }

  ///<<<==================== Update Group Repo ==============================>>>

  upDateGroupContactRepo({required int groupIndex}) {
    ContactGroup contactGroup = ContactGroup(
        name: groupNameController.text, contactsList: selectedGroupContacts);
    groupedContactsList[groupIndex] = contactGroup;
    PrefsHelper.saveGroupedList(groupedContactsList);
    update();
    Get.back();
    Get.back();
    Future.delayed(
      Duration(seconds: 1),
      () {
        groupNameController.clear();
        selectedGroupContacts.clear();
      },
    );
  }

  ///<<<===================== Reload Group Contacts =========================>>>
  void reloadGroupContacts({required List<ContactsModel> groupContactList, required int index}) {
    // Iterate through the groupContactList to find matches in contacts
    for (var groupContact in groupContactList) {
      // Find the index of the contact in the contacts list
      int contactIndex = contacts.indexWhere((contact) => contact.id == groupContact.id);
      if (contactIndex != -1) {
        // Update the contact in groupedContactsList if a match is found
        int listIndex = groupedContactsList[index].contactsList.indexWhere((contact) => contact.id == groupContact.id);
        if (listIndex != -1) {
          groupedContactsList[index].contactsList[listIndex] = contacts[contactIndex];
          if (kDebugMode) {
            print("=============> Updated contact:");
            print("Name: ${groupedContactsList[index].contactsList[listIndex].name}");
            print("ID: ${groupedContactsList[index].contactsList[listIndex].id}");
          }
        }
      }
    }
    groupedContactsList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }


  ///<<<===================== Create group repo ==============================>>>
  List<ContactsModel> groupListAdded({required int index}) {
    ContactsModel contactsModel = ContactsModel(
        id: selectedGroupContacts[index].id,
        imageUrl: selectedGroupContacts[index].imageUrl,
        name: selectedGroupContacts[index].name,
        designation: selectedGroupContacts[index].designation,
        companyName: selectedGroupContacts[index].companyName,
        email: selectedGroupContacts[index].email,
        mobilePhone: selectedGroupContacts[index].mobilePhone,
        landPhone: selectedGroupContacts[index].landPhone,
        fax: selectedGroupContacts[index].fax,
        website: selectedGroupContacts[index].website,
        address: selectedGroupContacts[index].address,
        note: selectedGroupContacts[index].note,
        capturedImageList: selectedGroupContacts[index].capturedImageList);
    singleGroupContacts.add(contactsModel);
    // ContactGroup group = ContactGroup(name: groupNameController.text, contacts: [contactsModel]);
    return singleGroupContacts;
  }

  ///===================>> Delete Group Repo <<===============================
  deleteGroupRepo({required int index}) {
    groupedContactsList.removeAt(index);
    PrefsHelper.saveGroupedList(groupedContactsList);
    update();
  }

  ///===================>> Delete Group Contact Repo <<===============================
  deleteGroupContactRepo({required int groupIndex, required int listIndex}) {
    groupedContactsList[groupIndex].contactsList.removeAt(listIndex);
    PrefsHelper.saveGroupedList(groupedContactsList);
    update();
    Get.back();
  }

  ///==================== new group repo==============================>>>///
  List<ContactsModel> groupList = [];
  int groupCount = 0;

  createGroup() {
    isLoading = true;
    update();
    groupList.clear();
    for (int index = 0; index < selectedGroupContacts.length; index++) {
      groupList = groupListAdded(index: index);
    }
    ContactGroup contactGroup =
        ContactGroup(name: groupNameController.text, contactsList: groupList);
    groupedContactsList.add(contactGroup);
    PrefsHelper.saveGroupedList(groupedContactsList);
    PrefsHelper.setList("selectedGroupContacts", selectedGroupContacts);
    update();
    selectedGroupContacts.clear();
    groupNameController.text = "";
    groupCount += 1;
    Get.back();
    isLoading = false;
    update();
    Get.snackbar(AppStrings.groupIsCreated, "");
    if (kDebugMode) {
      print(
          "storageController.groupedContactsList: ${groupedContactsList[0].name}, ${groupedContactsList[0].contactsList[0].email}");
    }
  }

  int unGroupedContacts = 0;

  Future<int> groupUpdateStatus(int groupedContactsCount) async {
    if (PrefsHelper.unGroupedContacts.isEqual(0)) {
      unGroupedContacts = allContactsForGroup.length - groupedContactsCount;
    } else {
      unGroupedContacts =
          await PrefsHelper.getInt("unGroupedContacts") - groupedContactsCount;
    }
    PrefsHelper.setInt('unGroupedContacts', unGroupedContacts);
    if (unGroupedContacts < 0) {
      return 0;
    }
    return unGroupedContacts;
  }

  void removeSelectedContactsFromAll() async {
    allContactsForGroup
        .removeWhere((element) => selectedGroupContacts.contains(element));
  }

  ///<<<========================= Excel export repo ================================>>>>
  Future<void> exportToExcel({required List<ContactsModel> contactList}) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Contacts'];
    CellStyle cellStyle = CellStyle(
      // backgroundColorHex: "#1AFF1A",
      fontFamily: getFontFamily(FontFamily.Calibri),
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );

    // Add header row
    List<TextCellValue> headers = [
      TextCellValue("ID"),
      TextCellValue("Image URL"),
      TextCellValue("Name"),
      TextCellValue("Designation"),
      TextCellValue("Company Name"),
      TextCellValue("Email"),
      TextCellValue("Mobile"),
      TextCellValue("Telephone"),
      TextCellValue("Fax"),
      TextCellValue("Website"),
      TextCellValue("Address"),
      TextCellValue("Note"),
      TextCellValue("capturedImageList"),
    ];

    sheetObject.appendRow(headers);

    // Add data rows
    for (var contact in contactList) {
      String capturedImages = contact.capturedImageList.join(', ') ?? '';

      List<TextCellValue> data = [
        TextCellValue(contact.id),
        TextCellValue(contact.imageUrl),
        TextCellValue(contact.name),
        TextCellValue(contact.designation),
        TextCellValue(contact.companyName),
        TextCellValue(contact.email),
        TextCellValue(contact.mobilePhone),
        TextCellValue(contact.landPhone ?? ""),
        TextCellValue(contact.fax ?? ""),
        TextCellValue(contact.website ?? ""),
        TextCellValue(contact.address),
        TextCellValue(contact.note ?? ""),
        TextCellValue(capturedImages),
      ];
      sheetObject.appendRow(data);
    }

    // Save the file in the documents directory
    Directory? directory;
    if (Platform.isAndroid) {
      directory =
          await getExternalStorageDirectory(); // Get external storage directory
    } else if (Platform.isIOS) {
      directory =
          await getApplicationDocumentsDirectory(); // Get application documents directory
    } else {
      directory =
          await getApplicationDocumentsDirectory(); // Default to application documents directory
    }

    String filePath = p.join(directory!.path, 'Contacts.xlsx');
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.encode()!);

    if (kDebugMode) {
      print('Excel file created at $filePath');
    }

    // Provide the option to share the file
    Share.shareFiles([filePath], text: 'Here is your contacts Excel file.');
    // var xFile = XFile(filePath);
    //
    // if (kDebugMode) {
    //   print('Excel file created at $filePath');
    // }
    //
    //   Share.shareXFiles([xFile], text: 'Here is your contacts Excel file.');

    // Provide the option to share the file
  }

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<< Phone Local Storage CRUD All Methods >>>>>>>>>>>>>>>>>>>>>>>>>>

  ///<<<--------------------- Load contacts from mobile storage --------------->>>

  Future<void> loadContacts() async {
    allContactsForGroup.clear();
    isLoading = true;
    update();
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
      update();
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
    print("Imagepath:=========>> $imagePath");
    imagePath ?? "https://shorturl.at/sPWcH";
    if (imagePath != null) {
      id = generateId();
      contacts.add(ContactsModel(
        id: id.toString(),
        imageUrl: imagePath.toString(),
        name: nameController.text,
        designation: designationController.text,
        companyName: companyController.text,
        email: emailController.text,
        mobilePhone: mobilePhoneController.text,
        landPhone: landPhoneController.text,
        fax: faxController.text,
        website: websiteController.text,
        address: addressController.text,
        note: noteController.text,
        capturedImageList: OCRCreateCardController.capturedImageList,
      ));
      update();
      saveContacts();
      imagePath = "";
      nameController.clear();
      designationController.clear();
      companyController.clear();
      emailController.clear();
      mobilePhoneController.clear();
      addressController.clear();
      landPhoneController.clear();
      faxController.clear();
      websiteController.clear();
      OCRCreateCardController.capturedImageList = [];
    }
  }

  ///<<<---------------------- Update contacts method ------------------------>>>

  Future<void> updateContact() async {
    if (kDebugMode) {
      print("-=-=-=-=-=-=-=--=-=-${noteController.text}");
    }
    if (imagePath != null) {
      final existingContactIndex = contacts.indexWhere((contact) => contact.id == id);

      if (existingContactIndex != -1) {
        // Update contact details
        contacts[existingContactIndex] = ContactsModel(
            id: id.toString(),
            imageUrl: imagePath.toString(),
            name: nameController.text,
            designation: designationController.text,
            companyName: companyController.text,
            email: emailController.text,
            mobilePhone: mobilePhoneController.text,
            landPhone: landPhoneController.text,
            fax: faxController.text,
            website: websiteController.text,
            address: addressController.text,
            note: noteController.text,
            capturedImageList: capturedImageList);
        update();
        saveContacts();
      }
    }
  }

  ///<<<---------------------- Delete contacts method ------------------------>>>

  Future<void> deleteContact(String id) async {
    contacts.removeWhere((contact) => contact.id == id);
    update();
    Get.snackbar("The contact is deleted".tr, "", duration: Duration(milliseconds: 800));
    saveContacts();
    // Get.offAllNamed(AppRoutes.homeScreen);
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

  Future<void> getOnlineImage({Uint8List? imageBytes}) async {
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
    if (imagePath != null) {
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
      await imageBBService.imageCompressor(imagePath: croppedFile.path).then((value) => imageBBService.uploadImage(imageFile: File(value))).then((value){
        // capturedImageList.add(value);
        imagePath = value;
      });
      // imagePath = croppedFile.path;
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
      final groupContactsJson = json.encode(groupedContactsList.map((e) => e.toJson()).toList());

      // Decode the JSON strings to maps
      final contactsMap = json.decode(contactsJson);
      final groupContactsMap = json.decode(groupContactsJson);

      // Merge the two maps
      final combinedContacts = {
        'contacts': contactsMap,
        'groupedContacts': groupContactsMap
      };

      // Encode the combined map back to a JSON string
      final combinedJson = json.encode(combinedContacts);

      // Write contacts JSON to a temporary file
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/combinedContacts.json');

      await file.writeAsString(combinedJson);

      await downloadFileId();

      // Upload the contacts JSON file to Google Drive
      if (fileId == null) {
        await uploadFile(file, accessToken);
      } else {
        await updateFile(fileId!, file, accessToken);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving contacts: $e");
      }
    }
  }

  var firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  ///<<<====================== upload file repo ===============================>>>
  Future<void> uploadFile(File file, String? accessToken) async {
    try {
      if (accessToken == null) {
        if (kDebugMode) {
          print('Access token is null');
        }
        return;
      }

      // Read file bytes
      final List<int> bytes = await file.readAsBytes();

      // Set the filename
      final String fileName =
          file.path.split('/').last; // Extract filename from file path

      // Create metadata for the file
      final Map<String, dynamic> metadata = {
        'name': fileName, // Set the filename
      };

      // Encode metadata to JSON
      json.encode(metadata);

      // Create an HTTP request to upload the file to Google Drive
      final http.Response response = await http.post(
        Uri.parse(
            'https://www.googleapis.com/upload/drive/v3/files?uploadType=media&name=$metadata'),
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
        uploadFileId(fileId!);
        Get.snackbar("File uploaded successfully".tr, "");
        if (kDebugMode) {
          print('File uploaded successfully $fileId');
        }
      } else {
        if (kDebugMode) {
          print(
              'File upload failed with status code ${response.statusCode} \n${response.contentLength}');
        }
      }
    } catch (e) {
      Get.snackbar("Upload failed".tr, "");
      if (kDebugMode) {
        print('Upload failed: $e');
      }
    }
  }

  ///<<<====================== update file repo ===============================>>>
  Future<void> updateFile(String fileId, File file, String? accessToken) async {
    try {
      if (accessToken == null) {
        if (kDebugMode) {
          print("Access token is null");
        }
        return;
      }

      final List<int> bytes = await file.readAsBytes();
      // Update file content
      final http.Response updateResponse = await http.patch(
        Uri.parse(
            'https://www.googleapis.com/upload/drive/v3/files/$fileId?uploadType=media'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: bytes,
      );

      if (updateResponse.statusCode == 200) {
        Get.snackbar("File updated successfully".tr, "");
        if (kDebugMode) {
          print('File updated successfully');
        }
      } else {
        if (kDebugMode) {
          print(
              'File update failed with status code ${updateResponse.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        Get.snackbar("Operation failed".tr, "");
        print('Operation failed: $e');
      }
    }
  }

  ///<<<====================== download file repo =============================>>>
  Future<void> downloadFile(String? accessToken) async {
    try {
      if (accessToken == null) {
        Get.snackbar("Upload contacts before downloading!".tr, "");
        if (kDebugMode) {
          print('Access token is null');
        }
        return;
      }
      await downloadFileId();
      final http.Response downloadResponse = await http.get(
        Uri.parse(
            'https://www.googleapis.com/drive/v3/files/$fileId?alt=media'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (downloadResponse.statusCode == 200) {
        // Process downloaded content
        final List<int> fileBytes = downloadResponse.bodyBytes;
        final Map<String, dynamic> fileContent = jsonDecode(utf8.decode(fileBytes));

        final List<ContactsModel> downloadedContacts = (fileContent['contacts'] as List)
            .map((item) => ContactsModel.fromJson(item))
            .toList();
        final List<ContactGroup> downloadedGroupedContacts = (fileContent['groupedContacts'] as List)
            .map((item) => ContactGroup.fromJson(item))
            .toList();

        for (var content in downloadedContacts) {
          if (!contacts.any((contact) => contact.id == content.id)) {
            contacts.add(content);
          }
        }

        for (var group in downloadedGroupedContacts) {
          if (kDebugMode) {
            print("group.name::::: ${group.name}");
          }
          if(!groupedContactsList.any((element) => element.name == group.name)){
            groupedContactsList.add(group);
          }
        }
        PrefsHelper.groupedContactsList = groupedContactsList;
        PrefsHelper.saveGroupedList(groupedContactsList);
        saveContacts();
        update();

        Get.snackbar("Contact successfully downloaded".tr, "");
        if (kDebugMode) {
          print(downloadedContacts);
          print(downloadedGroupedContacts);
        }
      } else {
        Get.snackbar("Download failed".tr, "");
        if (kDebugMode) {
          print(
              'File download failed with status code ${downloadResponse.statusCode}');
        }
      }
    } catch (e) {
      Get.snackbar("Download failed".tr, "$e");
      if (kDebugMode) {
        print(e);
      }
    }
  }

  ///<<<=========== FileID upload and download in Firebase FireStore =========>>>

  Future<void> uploadFileId(String fileId) async {
    User? user = auth.currentUser;
    if (user != null) {
      String userEmail = user.email!;
      // Upload fileId under the user's email document in FireStore
      await firebaseFireStore.collection('userFiles').doc(userEmail).set({
        'fileId': fileId,
      });
      if (kDebugMode) {
        print('File ID uploaded successfully for user: $userEmail');
      }
    } else {
      if (kDebugMode) {
        print('User is not authenticated.');
      }
    }
  }

  Future<void> downloadFileId() async {
    User? user = auth.currentUser;
    if (user != null) {
      String userEmail = user.email!;
      // Query FireStore to get the fileId associated with user's email
      DocumentSnapshot snapshot = await firebaseFireStore
          .collection('userFiles') // Collection where user emails are stored
          .doc(userEmail) // Document name is user's email
          .get();

      if (snapshot.exists) {
        // Assuming 'fileId' is a field in the document
        fileId = snapshot['fileId'];
        if (kDebugMode) {
          print("FileID downloaded: $fileId");
        }
        // Now you can use the fileId to download the file
        // Download logic...
      } else {
        if (kDebugMode) {
          print('No file associated with this user.');
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}


