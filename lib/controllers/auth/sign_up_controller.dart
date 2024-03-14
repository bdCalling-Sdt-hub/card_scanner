
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isChecked = false.obs;
}