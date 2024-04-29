
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../Models/contacts_model.dart';


class StorageController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    contacts = [];
    loadContacts();
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

  ///<<<<<<<<<<<<<<<<<<<<<<<<<<< Phone Local Storage All Methods >>>>>>>>>>>>>>>>>>>>>>>>>>

  ///<<<=================== Load contacts from mobile storage ===============>>>

  Future<void> loadContacts() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/contacts.json');
      if (file.existsSync()) {
        final data = await file.readAsString();
        final List<dynamic> jsonList = json.decode(data);
          contacts = jsonList.map((json) => ContactsModel.fromJson(json)).toList();
          update();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading contacts: $e");
      }
    }
  }

  ///<<<==================== Save contacts method ===========================>>>

  Future<void> saveContacts() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/contacts.json');
      if (kDebugMode) {
        print("Directory:>>>>>>>>${directory.path}");
      }
      await file.writeAsString(json.encode(contacts.map((c) => c.toJson()).toList()));
    } catch (e) {
      if (kDebugMode) {
        print("Error saving contacts: $e");
      }
    }
  }

  ///<<<-------------------- Generate Id ------------------------------------>>>
  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> getGalleryImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(pickedFile != null){
      imagePath = pickedFile.path;
    }
    update();
  }

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

  Future<void> updateContact() async {
    if (imagePath != null && imagePath!.isNotEmpty) {
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
            phoneNumber: phoneController.text,
            address: addressController.text,
          );
          update();
          saveContacts();
        }
    }
  }


  Future<void> deleteContact(String id) async {
      contacts.removeWhere((contact) => contact.id == id);
      update();
      Get.snackbar("The contact is deleted","");
      saveContacts();
  }

}