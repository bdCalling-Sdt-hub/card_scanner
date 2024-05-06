
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/views/screens/CardSync/card_sync_screen.dart';
import 'package:card_scanner/views/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../Helpers/prefs_helper.dart';
import '../../views/screens/Auth/signin_screen.dart';
import 'package:googleapis/drive/v3.dart' as drive;

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


  ///<<<=================== Sign Up Repo ===============================>>>
  Future<void> signUpRepo()async {
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) async{
        await firebaseFireStore.collection("users").doc(value.user?.uid).set(
          {
            "name" : emailController.text,
            "email" : emailController.text,
            "phone" : phoneNumberController.text
          }
        );
      });
      Get.toNamed(AppRoutes.signInScreen);
      Get.snackbar("New Account Created", "");
    }catch(e){
      Get.snackbar("$e", "");
    }
  }

  ///<<<=================== Sign In Repo ===============================>>>


  Future<void> signInRepo()async {
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).timeout(Duration(seconds: 30));
      final user = firebaseAuth.currentUser;
      if(user?.email != null){
        if(user!.emailVerified){
          Get.toNamed(AppRoutes.homeScreen);
          Get.snackbar("Successfully logged in", "");
        }else{
          Get.snackbar("Something went wrong:", "please check your email and password!");
        }
      }else{
        Get.snackbar("Something went wrong:", "please check your email and password!");
      }
    }catch(e){
      Get.snackbar("$e", "");
      if (kDebugMode) {
        print(e);
      }
    }
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
    await user?.sendEmailVerification().then((value){
      Get.snackbar("Link sent", "A link has been sent to your email", animationDuration: Duration(seconds: 5));
    });
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
  googleSignInRepo() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive']).signIn();
      // final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      //
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );
      // await FirebaseAuth.instance.signInWithCredential(credential);
      // if (kDebugMode) {
      //   print("Credential Token: ${credential.accessToken}");
      // }

      if (googleUser != null) {
        handleSignInSuccess(googleUser);
      }

      if (kDebugMode) {
        print(googleUser?.email);
        print(googleUser?.id);
      }

    }catch(e){
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void handleSignInSuccess(GoogleSignInAccount account) async {
    // if (driveApi == null) {
    //   final client = await getClient(account);
    //   driveApi = drive.DriveApi(client);
    // }
  }
  // Future<http.Client> getClient(GoogleSignInAccount account) async {
  //   final authHeaders = await account.authHeaders;
  //   // return http.Client()
  //   //   ..defaultHeaders = {
  //   //     'Authorization': authHeaders['Authorization'],
  //   //   };
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