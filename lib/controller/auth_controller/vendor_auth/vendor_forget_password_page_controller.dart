
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/common/toast.dart';
import 'package:get/get.dart';

import '../../../api_service/api_service.dart';
import '../../../static/Colors.dart';
import 'package:http/http.dart' as http;

import '../../../view/auth/user/email_verification.dart';
import '../../../view/auth/vendor_or_seller/vendor_email_verification.dart';
class VendorForgetPasswordPageController extends GetxController {
  final emailController = TextEditingController().obs;
  var userNameLevelTextColor = hint_color.obs;



  sendEmailForOtp({
    required String email,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Checking");

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_RESET_PASSWORD'),
              //var response = await http.post(Uri.parse('http://192.168.68.106/bijoytech_ecomerce/api/reset-password'),
              body: {
                'email': email,
              }
          );
          Get.back();
          // _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            showToastShort("success");
            // var data = jsonDecode(response.body);


            // Get.to(SignUpScreen());

            Get.to(() => VendorEmailVerificationScreen(), arguments: [
              {"email": email},
              {"second": 'Second'}
            ]);


          }
          else if (response.statusCode == 401) {

            var data = jsonDecode(response.body);
            showToastShort("User name or password not match!");
          }
          else {

            var data = jsonDecode(response.body);
            // _showToast(data['message']);
          }


        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {


          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      showToastShort("No Internet Connection!");
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

  inputValid(String email) {
    if (email.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("E-mail can't empty!");
      return;
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      Fluttertoast.cancel();
      showToastLong("Enter valid email!");
      return;
    }
    return false;
  }


}