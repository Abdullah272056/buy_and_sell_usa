
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../static/Colors.dart';

class LogInPageController extends GetxController {

  ///input box controller
  final userEmailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final  userEmailControllerFocusNode = FocusNode().obs;
  final  passwordControllerFocusNode = FocusNode().obs;

  ///input box color and operation
  var userEmailLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;
  var emailFocusNode = FocusNode().obs;
  var isObscure = true.obs;



  updateUserNameLevelTextColor(Color value) {
    userEmailLevelTextColor(value);
  }

  updateIsObscure(var value) {
    isObscure(value);
  }
  updatePasswordLevelTextColor(Color value) {
    passwordLevelTextColor(value);
  }



}