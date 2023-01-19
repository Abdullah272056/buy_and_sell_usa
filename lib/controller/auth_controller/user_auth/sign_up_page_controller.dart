
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../static/Colors.dart';

class SignUpPageController extends GetxController {

  ///input box controller
  final userNameController = TextEditingController().obs;
  final userEmailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final  userNameControllerFocusNode = FocusNode().obs;
  final  userEmailControllerFocusNode = FocusNode().obs;
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



}