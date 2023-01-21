
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api_service/api_service.dart';
import '../../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../../static/Colors.dart';
import 'package:http/http.dart' as http;

import '../../../view/dash_board/dash_board_page.dart';
import '../../dash_board_controller/dash_board_page_controller.dart';

class VendorLogInPageController extends GetxController {

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

  vendorLogIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Checking...");

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_VENDOR_LOGIN'),

              body: {
                'email': email,
                'password': password,
              }
          );

           _showToast(response.statusCode.toString());

          Get.back();
          if (response.statusCode == 200) {
            _showToast("success");

            var data = jsonDecode(response.body);
            saveUserInfo(
                userName: data["data"]["name"].toString(),
                userToken: data["data"]["token"].toString());

            Get.deleteAll();
             Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());

          }
          else if (response.statusCode == 401) {
            _showToast("User name or password not match!");
          }
          else {
            var data = jsonDecode(response.body);
            // _showToast(data['message']);
          }
          //   Get.back();

        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {
          //   Get.back();

          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {

      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  //input text validation check
  inputValid(String userEmail, String password) {
    if (userEmail.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Email can't empty!");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(userEmail)) {
      Fluttertoast.cancel();
      _showToast("Enter valid email!");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Password can't empty!");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      _showToast("Password must be 8 character!");
      return;
    }

    return false;
  }

  ///user info with share pref
  void saveUserInfo({required String userName,required String userToken,}) async {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, userName);
      storage.write(pref_user_token, userToken);
      storage.write(pref_user_type, "vendor");
      // _showToast(userToken.toString());
    } catch (e) {
      //code
    }
  }

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
                    height:50,
                    width: 50,
                    margin: EdgeInsets.only(top: 10),
                    child: CircularProgressIndicator(
                      backgroundColor: awsStartColor,
                      color: awsEndColor,
                      strokeWidth: 6,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child:Text(
                      message,
                      style: const TextStyle(fontSize: 25,),
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
        backgroundColor: Colors.white,
        textColor: fnf_color,
        fontSize: 16.0);
  }

}