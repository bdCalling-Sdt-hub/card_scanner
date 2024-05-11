
import 'package:card_scanner/controllers/storage_controller.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/views/screens/CardSync/card_sync_screen.dart';
import 'package:card_scanner/views/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../Helpers/prefs_helper.dart';
import '../../views/screens/Auth/signin_screen.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';

class AuthController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool isChecked = false.obs;
  RxBool ifSignIn = false.obs;

  var firebaseAuth = FirebaseAuth.instance;
  var firebaseFireStore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;


  ///<<<=================== Sign Up Repo ===============================>>>
  Future<void> signUpRepo()async {
    isLoading = true;
    update();
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) async{
        await firebaseFireStore.collection("users").doc(value.user?.uid).set(
          {
            "name" : nameController.text,
            "email" : emailController.text,
            "phone" : phoneNumberController.text
          }
        );
      });

      Get.toNamed(AppRoutes.signInScreen);
      Get.snackbar("New Account Created", "");
    }catch(e){
      Get.snackbar("Try again!", "Something went wrong.");
    }
    isLoading = false;
    update();

  }

  ///<<<=================== Sign In Repo ===============================>>>


  Future<void> signInRepo()async {
    isLoading = true;
    update();
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).timeout(Duration(seconds: 30));
      final user = firebaseAuth.currentUser;
      if(user?.email != null){
        Get.toNamed(AppRoutes.homeScreen);
        Get.snackbar("Successfully logged in", "");
      }else{
        Get.snackbar("Something went wrong:", "please check your email and password!");
      }
    }catch(e){
      Get.snackbar("$e", "");
      if (kDebugMode) {
        print(e);
      }
    }
    isLoading = false;
    update();
  }

  ///<<<=================== Reset Password Repo ==========================>>>

  Future<void> resetPassRepo()async {
    try{
      await firebaseAuth.sendPasswordResetEmail(email: emailController.text);
      Get.snackbar("Password reset link sent to your email!", "");
      Get.offAllNamed(AppRoutes.signInScreen);
    }catch(e){
      Get.snackbar("$e", "");
    }
  }

  ///<<<=================== Verify Email ================================>>>

  Future<void> verifyEmailRepo() async {
    var emailVerifyResponse = await user?.sendEmailVerification().then((value){
      Get.snackbar("Link sent", "A link has been sent to your email", animationDuration: Duration(seconds: 5));
    });
    print("Email verify: $emailVerifyResponse");
  }

  ///<<<=================== Sign Out Repo ===============================>>>
  Future<void> signOutRepo()async {
    try{
      await firebaseAuth.signOut();
      Get.offAll(SignInScreen());
      PrefsHelper.removeAllPrefData();
      Get.snackbar("You are signed out", "");
    }catch(e){
      Get.snackbar("$e", "");
    }
  }

  ///<<<====================== Google SignIn/ SignOut Repo ==================>>>
  drive.DriveApi? driveApi;
  // String? accessToken;
  // googleSignInRepo() async {
  //   try{
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive']).signIn();
  //     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     if (kDebugMode) {
  //       print("Credential Token: ${credential.accessToken}");
  //       accessToken = credential.accessToken;
  //     }
  //
  //     if (googleUser != null) {
  //       // handleSignInSuccess(googleUser);
  //       uploadFile();
  //     }
  //
  //     if (kDebugMode) {
  //       print(googleUser?.email);
  //       print(googleUser?.id);
  //     }
  //
  //   }catch(e){
  //     if (kDebugMode) {
  //       print("Error: $e");
  //     }
  //   }
  // }

  // void handleSignInSuccess(GoogleSignInAccount account) async {
  //   if (driveApi == null) {
  //     final client = await getClient(account);
  //     driveApi = drive.DriveApi(client);
  //   }
  // }
  // Future<http.Client> getClient(GoogleSignInAccount account) async {
  //   final authHeaders = await account.authHeaders;
  //   return http.Client()..headers['Authorization'] = authHeaders['Authorization'];
  // }

  //
  // Future<void> uploadFile() async {
  //   try {
  //     ByteData data = await rootBundle.load('assets/images/contactsImage.png');
  //     List<int> bytes = data.buffer.asUint8List(); // Change this to your file path
  //     // var fileMetadata = drive.File()..name = 'MyFile.png';
  //     var request = http.Request('POST', Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=media'));
  //     request.headers['Authorization'] = accessToken!;
  //     request.bodyBytes =bytes;
  //     request.headers['Content-Type'] = 'application/octet-stream';
  //     var response = await request.send();
  //     print('Uploaded file ID: ${response.statusCode} ${response.stream  }');
  //   } catch (e) {
  //     print('Upload failed: $e');
  //   }
  // }
  static String? accessToken;
  StorageController storageController = Get.put(StorageController());

  Future<void> googleSignInRepo() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive']).signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (kDebugMode) {
        print("Credential Token: ${credential.accessToken}");
        accessToken = credential.accessToken;
      }

      if (googleUser != null) {
        // await uploadFile();
        await storageController.saveContactsInGoogle(accessToken: accessToken); // Upload file after successful sign-in
      }

      if (kDebugMode) {
        print(googleUser?.email);
        print(googleUser?.id);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> uploadFile() async {
    try {
      if (accessToken == null) {
        if (kDebugMode) {
          print('Access token is null');
        }
        return;
      }

      final ByteData data = await rootBundle.load('assets/images/contactsImage.png');
      final List<int> bytes = data.buffer.asUint8List();

      final http.Response response = await http.post(
        Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=media'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/octet-stream',
        },
        body: bytes,
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('File uploaded successfully');
        }
        Get.back();
      } else {
        if (kDebugMode) {
          print('File upload failed with status code ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Upload failed: $e');
      }
    }
  }


  //////////////////////////////////////////////////////////////////////////////

  // Future<void> saveContacts() async {
  //   try {
  //     // Encode contacts list to JSON
  //     final contactsJson = json.encode(contacts.map((c) => c.toJson()).toList());
  //
  //     // Write contacts JSON to a temporary file
  //     final directory = await getTemporaryDirectory();
  //     final file = File('${directory.path}/contacts.json');
  //     await file.writeAsString(contactsJson);
  //
  //     // Upload the contacts JSON file to Google Drive
  //     await uploadFile(file);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Error saving contacts: $e");
  //     }
  //   }
  // }
  //
  // Future<void> uploadFile(File file) async {
  //   try {
  //     if (accessToken == null) {
  //       print('Access token is null');
  //       return;
  //     }
  //
  //     // Read file bytes
  //     final List<int> bytes = await file.readAsBytes();
  //
  //     // Create an HTTP request to upload the file to Google Drive
  //     final http.Response response = await http.post(
  //       Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=media'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/octet-stream',
  //       },
  //       body: bytes,
  //     );
  //
  //     // Check the response status code
  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully');
  //     } else {
  //       print('File upload failed with status code ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Upload failed: $e');
  //   }
  // }


  googleSignOutRepo() async{
    try{
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut().then((value) {
        if(value == null){
          Get.snackbar("Google logout successful", "");
          Get.offAll(CardSyncScreen());
          if (kDebugMode) {
            print("Value $value");
          }
        }
      },
      );
    }catch(e){
      Get.snackbar("Something went wrong, try again!", "");
    }
  }

}