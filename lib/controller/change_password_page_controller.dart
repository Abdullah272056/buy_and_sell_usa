
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../static/Colors.dart';
import '../view/auth/log_in_page.dart';

class ChangePasswordPageController extends GetxController {

 //dynamic argumentData = Get.arguments;

  var userName="".obs;
  var userToken="".obs;
  @override
  void onInit() {
    super.onInit();
    retriveUserInfo();

  }
  ///input box controller
  final oldPasswordController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final  oldPasswordControllerFocusNode = FocusNode().obs;
  final  passwordControllerFocusNode = FocusNode().obs;
  final  confirmPasswordControllerFocusNode = FocusNode().obs;


  ///input box color and operation
  var userEmailLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;
  var isObscureOldPassword = true.obs;
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;


  updateUserNameLevelTextColor(Color value) {
    userEmailLevelTextColor(value);
  }

  updateIsObscureOldPassword(var value) {
    isObscureOldPassword(value);
  }
  updateIsObscurePassword(var value) {
    isObscurePassword(value);
  }
  updateIsObscureConfirmPassword(var value) {
    isObscureConfirmPassword(value);
  }




  updatePasswordLevelTextColor(Color value) {
    passwordLevelTextColor(value);
  }

  ///get user data from share pref
  retriveUserInfo() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name).toString());
      userToken(storage.read(pref_user_token).toString());

    }catch(e){

    }

  }

  newPasswordSet({
    required String userToken,
    required String oldPassword,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //  _showToast(token);
        try {
          showLoadingDialog("Changing...");
          var response = await post(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_CHANGE_PASSWORD}'),
              headers: {
                'Authorization': 'Bearer '+userToken,

              },
              body: {
                'old_password': oldPassword,
                'password': password,
                'password_confirmation': confirmPassword
              }
          );

          Get.back();
          if (response.statusCode == 200) {
            _showToast("Password Changed Successfully!");
             oldPasswordController.value.text="" ;
             passwordController.value.text="" ;
             confirmPasswordController.value.text="";

          }
          else if(response.statusCode==404){
            var data = jsonDecode(response.body);

            _showToast(data["data"]["error"].toString());

          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  //loading dialog crete
  void showLoadingDialog(String message) {

    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [
            Container(
              alignment: Alignment.center,
              // margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
              child:Column(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height:45,
                    width: 45,
                    margin: EdgeInsets.only(top: 10),
                    child: CircularProgressIndicator(
                      backgroundColor: awsStartColor,
                      color: fnf_color,
                      strokeWidth: 6,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child:Text(
                      message,
                      style: const TextStyle(fontSize: 22,
                      color: fnf_color
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
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