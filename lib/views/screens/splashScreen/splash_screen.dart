
import 'dart:async';

import 'package:card_scanner/utils/app_images.dart';
import 'package:card_scanner/views/screens/onboardingScreen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds: 3), () {
      Get.to(OnBoardingScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
            width: 300,
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
