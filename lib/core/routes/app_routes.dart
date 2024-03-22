
import 'package:card_scanner/views/screens/AllCardsScreen/all_cards_screen.dart';
import 'package:card_scanner/views/screens/Auth/otp_screen.dart';
import 'package:card_scanner/views/screens/Auth/signup_screen.dart';
import 'package:card_scanner/views/screens/Group/group_screen.dart';
import 'package:card_scanner/views/screens/Group/selected_group_cards.dart';
import 'package:card_scanner/views/screens/home/home_screen.dart';
import 'package:card_scanner/views/screens/onboardingScreen/onboarding_screen.dart';
import 'package:get/get.dart';

import '../../views/screens/Auth/forgot_password_screen.dart';
import '../../views/screens/Auth/reset_password_screen.dart';
import '../../views/screens/CardExport/card_export_screen.dart';
import '../../views/screens/CardSync/card_sync_screen.dart';
import '../../views/screens/Group/create_group_screen.dart';
import '../../views/screens/SplashScreen/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String onBoardScreen = "/onboarding_screen";
  static String homeScreen = "/home_screen";
  static String signUpScreen = "/signup_screen";
  static String signInScreen = "/signin_screen";
  static String resetPasswordScreen = "/reset_password_screen";
  static String otpScreen = "/otp_screen";
  static String forgotPasswordScreen = "/forgot_password_screen";
  static String allCardsScreen = "/all_cards_screen";
  static String cardSyncScreen = "/card_sync_screen";
  static String cardExportScreen = "/card_export";
  static String groupScreen = "/group_screen";
  static String createGroupScreen = "/create_group_screen";
  static String selectedGroupCards = "/selected_group_cards";


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onBoardScreen, page: () => OnBoardingScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: signInScreen, page: () => SignUpScreen()),
    GetPage(name: resetPasswordScreen, page: () => ResetPasswordScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(name: allCardsScreen, page: () => AllCardsScreen()),
    GetPage(name: cardSyncScreen, page: () => CardSyncScreen()),
    GetPage(name: cardExportScreen, page: () => CardExportScreen()),
    GetPage(name: groupScreen, page: () => GroupScreen()),
    GetPage(name: createGroupScreen, page: () => CreateGroupScreen()),
    GetPage(name: selectedGroupCards, page: () => SelectedGroupCards()),
  ];
}