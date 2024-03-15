import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/views/screens/Auth/signup_screen.dart';
import 'package:card_scanner/views/screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'views/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Name Card Scanner',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primaryColor,
          ),
          home: HomeScreen(),
          // home: const SplashScreen(),
          // home: SignUpScreen(),
        );
      },
    );
  }
}

