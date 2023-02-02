
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/controller/auth_controller/vendor_auth/vendor_email_verification_page_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../api_service/api_service.dart';
import '../../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../../static/Colors.dart';
import 'package:http/http.dart' as http;

import '../../../view/auth/vendor_or_seller/vendor_email_verification.dart';
import '../../../view/common/toast.dart';
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

          // showToastLong(response.statusCode.toString());

          Get.back();
          if (response.statusCode == 200) {
            showToastShort("success");

            var data = jsonDecode(response.body);
            saveUserInfo(
                userName: data["data"]["name"].toString(),
                userToken: data["data"]["token"].toString());

            Get.deleteAll();
             Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());

          }
          else if (response.statusCode == 401) {
            showToastShort("User name or password not match!");
          }
          else if (response.statusCode == 404) {
            userNotActiveDialog(email);
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
      showToastShort("No Internet Connection!");
    }
  }

  void userNotActiveDialog(String email) {
    Get.bottomSheet(
        ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10, bottom: 10),
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: const Text("Verify Your Email Address",
                            style: TextStyle(
                                color: text_color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10, bottom: 10),
                                child: const Text("We need to verify your email address!",
                                    style: TextStyle(
                                        color: hint_color,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 0, bottom: 10),
                                child: Text(email,
                                    style:  TextStyle(
                                        color: fnf_color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          )),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Container(
                                  margin:
                                  const EdgeInsets.only(left: 00.0, right: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();

                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7))),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient:  LinearGradient(
                                            colors: [
                                              hint_color,
                                              hint_color
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.circular(7.0)),
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Cancel",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'PT-Sans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                  const EdgeInsets.only(left: 10.0, right: 00.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Fluttertoast.cancel();

                                      Get.back();

                                      userResendOtp(email: email);




                                      // _sendOtp(userId: userId);

                                      // Navigator.push(context,MaterialPageRoute(builder: (context)=> SendOtpForVerifyScreen(),));

                                      //_showToast("verify page");
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7))),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient:  LinearGradient(
                                            colors: [
                                              fnf_color,
                                              fnf_color
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.circular(7.0)),
                                      child: Container(
                                        height: 45,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Verify Mail",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'PT-Sans',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                )

              ],
            ),
          ],
        ),


        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),

          ),
        ),
        isScrollControlled: true


      //  resizeToAvoidBottomInset: false
      // isScrollControlled: true,
    );
  }

  userResendOtp({
    required String email,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Sending...");
          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_RESEND_OTP_VENDOR'),
              body: {
                'email': email,
              }
          );
          Get.back();
          //  _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            showToastShort(
                "Otp send successfully!\n Please check your email!"
            );
            Get.to(() => VendorEmailVerificationScreen(), arguments: [
              {"productId": email},
              {"second": 'Second data'}
            ])?.then((value) => Get.delete<VendorEmailVerifyPageController>());
          }

          else {
            // Get.back();
            var data = jsonDecode(response.body);
            showToastLong("Otp Invalid!");
          }


        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {
          // Get.back();

          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      showToastLong("No Internet Connection!");
    }
  }

  //input text validation check
  inputValid(String userEmail, String password) {
    if (userEmail.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Email can't empty!");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(userEmail)) {
      Fluttertoast.cancel();
      showToastShort("Enter valid email!");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Password can't empty!");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      showToastShort("Password must be 8 character!");
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



}