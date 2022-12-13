import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../static/Colors.dart';

class PasswordSetPageController extends GetxController {

  dynamic argumentData = Get.arguments;
  var userEmail="".obs;
  var useOtp="".obs;
  @override
  void onInit() {
    userEmail(argumentData[0]['email']);
    useOtp(argumentData[1]['otp'].toString());
    _showToast(argumentData[0]['email']);
    _showToast(argumentData[1]['otp'].toString());

    super.onInit();
  }
  ///input box controller
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final  passwordControllerFocusNode = FocusNode().obs;
  final  confirmPasswordControllerFocusNode = FocusNode().obs;


  ///input box color and operation
  var userEmailLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;
  var emailFocusNode = FocusNode().obs;
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;



  updateUserNameLevelTextColor(Color value) {
    userEmailLevelTextColor(value);
  }

  updateIsObscureConfirmPassword(var value) {
    isObscureConfirmPassword(value);
  }


  updateIsObscurePassword(var value) {
    isObscurePassword(value);
  }
  updatePasswordLevelTextColor(Color value) {
    passwordLevelTextColor(value);
  }

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:toast_bg_color,
        textColor: toast_text_color,
        fontSize: 16.0);
  }

}