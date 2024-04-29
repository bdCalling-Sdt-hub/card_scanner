import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/global/dependency.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Helpers/prefs_helper.dart';
import 'views/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.getAllPrefData();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Name Card Scanner',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primaryColor,
          ),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          // home: const SplashScreen(),
        );
      },
    );
  }
}

