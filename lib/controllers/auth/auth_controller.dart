
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/views/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool isChecked = false.obs;
  RxBool ifSignIn = false.obs;
  ///<<<=================== Sign In Repo ===============================>>>


  Future<void> signInRepo()async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).timeout(Duration(seconds: 30));
      final user = FirebaseAuth.instance.currentUser;
      if(user?.email != null){
        if(user!.emailVerified){
          Get.toNamed(AppRoutes.homeScreen);
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

  ///<<<=================== Sign Out Repo ===============================>>>
  Future<void> signOutRepo()async {
    await FirebaseAuth.instance.signOut();
  }

}