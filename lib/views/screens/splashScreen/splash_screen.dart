
import 'dart:async';

import 'package:card_scanner/Helpers/prefs_helper.dart';
import 'package:card_scanner/Models/contacts_model.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/screens/onboardingScreen/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/storage_controller.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  StorageController storageController = Get.put(StorageController());


  @override
  void initState() {
    // TODO: implement initState
    final user = FirebaseAuth.instance.currentUser;
    storageController.loadContacts();
    loadGroupContacts();
    if (kDebugMode) {
      print("=====${user?.uid}");
    }
    if (kDebugMode) {
      print("=====${user?.getIdToken()}");
    }
    Timer(const Duration(seconds: 3), () {
      if(PrefsHelper.signedIn){
        Get.toNamed(AppRoutes.homeScreen);
      }else{
        Get.to(OnBoardingScreen());
      }
    });
    super.initState();
  }

  Future<void> loadGroupContacts() async {
    storageController.groupedContactsList = await PrefsHelper.getGroupedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
            width: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.splashImg)
              )
            ),
          // child: SvgPicture.asset("assets/images/onboardImg1.svg"),
        ),
      ),
    );
  }
}
