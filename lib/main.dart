import 'package:card_scanner/Helpers/permission_handler.dart';
import 'package:card_scanner/core/routes/app_routes.dart';
import 'package:card_scanner/global/dependency.dart';
import 'package:card_scanner/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Services/other_services.dart';
import 'firebase_options.dart';
import 'Helpers/prefs_helper.dart';
import 'package:permission_handler/permission_handler.dart';

import 'language/locales.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.getAllPrefData();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OtherService.checkConnection();
  PhonePermissionHandler permissionHandler = PhonePermissionHandler();
  // await permissionHandler.storageRequest(Permission.storage);
  // await permissionHandler.storagePermission();

//   var status = await Permission.storage.request();
//   if (status.isDenied) {
//     await Permission.storage.request();
//   }
//
// // You can also directly ask permission about its status.
//   if (await Permission.storage.isRestricted) {
//     print("Why this is restricted?");
//   }

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
          translations: Locales(),
          // locale: const Locale("en", "US"),
          defaultTransition: Transition.noTransition,
          locale: Locale(PrefsHelper.localizationLanguageCode,
              PrefsHelper.localizationCountryCode),
          fallbackLocale: const Locale("en", "US"),
          debugShowCheckedModeBanner: false,
          title: 'Name Card Scanner',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primaryColor,
          ),
          initialRoute: AppRoutes.splashScreen,
          navigatorKey: Get.key,
          getPages: AppRoutes.routes,
          // home: const SplashScreen(),
        );
      },
    );
  }
}

