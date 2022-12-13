import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;



import '../../controller/log_in_page_controller.dart';
import '../api_service/api_service.dart';
import '../controller/password_set_page_controller.dart';
import '../controller/sign_up_page_controller.dart';
import '../static/Colors.dart';
import 'log_in_page.dart';


class PasswordSetScreen extends StatelessWidget {

  final passwordSetPageController = Get.put(PasswordSetPageController());
  var width;
  var height;
  @override
  Widget build(BuildContext context) {
    width =MediaQuery.of(context).size.width;
    height =MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor:  backGroundColor,
          body: LayoutBuilder(builder: (context,constraints){

            if(constraints.maxWidth<600){
              return _buildBodyDesign();
            }
            else{
              return Center(child:
              Container(
                // height: 100,
                width: 500,
                child: _buildBodyDesign(),
                // color: Colors.amber,
              ),);

            }

          },)




      ),
    );


  }


  Widget _buildBodyDesign() {
    return  Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 20),

          // padding: const EdgeInsets.symmetric(
          //   horizontal: 40,
          // ).copyWith(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    ///ratio 1:2.25
                    Image.asset(
                      "assets/images/icon_forgot.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.fill,
                      color: forgotten_password_text_color,
                    )
                  ],
                ),
              ),


              Container(
                margin:const EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                child: const Align(alignment: Alignment.center,
                  child: Text(
                    "Create Password",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        color:text_color,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                margin:const EdgeInsets.only(right: 20.0,top: 10,left: 10,bottom: 0),
                child: const Align(alignment: Alignment.center,
                  child: Text(
                    "Create a password for your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: hint_color,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),),
              ),
              const SizedBox(
                height: 50,
              ),


              //password input
              _buildTextFieldPassword(
                // hintText: 'Password',
                obscureText: true,
                prefixedIcon: const Icon(Icons.lock, color: input_box_icon_color),
                labelText: "Password",
              ),
              const SizedBox(
                height: 25,
              ),
              //password input
              _buildTextFieldConfirmPassword(
                // hintText: 'Password',
                obscureText: true,
                prefixedIcon: const Icon(Icons.lock, color: input_box_icon_color),
                labelText: "Confirm Password",
              ),

              const SizedBox(
                height: 45,
              ),
              _buildSaveButton(),
              const SizedBox(
                height: 30,
              ),

              _buildSignUpQuestion(),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
      _showToast("resumed");
    }
  }



//password input field create
  Widget _buildTextFieldPassword({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Material(
    color:transparent,
    child:

    Focus(
      onFocusChange: (hasFocus) {
        passwordSetPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
    },
    child:  Obx(() =>


        TextField(
          controller: passwordSetPageController.passwordController.value,
          cursorColor:awsCursorColor,
          cursorWidth: 1.5,

          obscureText: passwordSetPageController.isObscurePassword.value,
          // obscuringCharacter: "*",
          focusNode:passwordSetPageController.passwordControllerFocusNode.value,
          onSubmitted:(_){
            passwordSetPageController.confirmPasswordControllerFocusNode.value.requestFocus();
          },
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            // border: InputBorder.none,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            // labelText: 'Password',
            // contentPadding: const EdgeInsets.all(17),
            contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),

            suffixIcon: IconButton(
                color: input_box_icon_color,
                icon: Icon(
                  passwordSetPageController.isObscurePassword.value ? Icons.visibility_off : Icons.visibility,
                ),

                // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  passwordSetPageController.updateIsObscurePassword(!passwordSetPageController.isObscurePassword.value);
                }),

            // filled: true,
            fillColor: Colors.white,
            prefixIcon: prefixedIcon,
            prefixIconColor: input_box_icon_color,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
            ),
            labelText: labelText,
            labelStyle:  TextStyle(
              color: passwordSetPageController.passwordLevelTextColor.value,
            ),
          ),
        )),
    )

    );
  }

  //password input field create
  Widget _buildTextFieldConfirmPassword({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Material(
        color:transparent,
        child:

        Focus(
          onFocusChange: (hasFocus) {
            passwordSetPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
          },
          child:  Obx(() =>


              TextField(
                controller: passwordSetPageController.confirmPasswordController.value,
                cursorColor:awsCursorColor,
                cursorWidth: 1.5,

                obscureText: passwordSetPageController.isObscureConfirmPassword.value,
                // obscuringCharacter: "*",
                focusNode:passwordSetPageController.confirmPasswordControllerFocusNode.value,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  // labelText: 'Password',
                  // contentPadding: const EdgeInsets.all(17),
                  contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),
                  suffixIcon: IconButton(
                      color: input_box_icon_color,
                      icon: Icon(
                        passwordSetPageController.isObscureConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
                      ),

                      // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        passwordSetPageController.updateIsObscureConfirmPassword(!passwordSetPageController.isObscureConfirmPassword.value);
                      }),

                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: prefixedIcon,
                  prefixIconColor: input_box_icon_color,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: hint_color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'PTSans',
                  ),

                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
                  ),
                  labelText: labelText,
                  labelStyle:  TextStyle(
                    color: passwordSetPageController.passwordLevelTextColor.value,
                  ),
                ),
              )),
        )

    );
  }



  //login button create
  Widget _buildSaveButton() {
    return ElevatedButton(
        onPressed: () {

          String passwordTxt = passwordSetPageController.passwordController.value.text;
          String confirmPasswordTxt = passwordSetPageController.confirmPasswordController.value.text;

          if (_inputValid(password: passwordTxt, confirmPassword: confirmPasswordTxt)== false) {
            newPassword(otp: passwordSetPageController.useOtp.value,
                email: passwordSetPageController.userEmail.value,
                password: confirmPasswordTxt);

          }


        },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [button_bg_color,button_bg_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 50,
          alignment: Alignment.center,
          child:  const Text(
            "Save",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  //join now asking
  Widget _buildSignUpQuestion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [


         Text(
          "Already have an Account? ",
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.black.withOpacity(.7),
          ),
        ),
        InkWell(
          child: const Text(
            'Sign In',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:forgotten_password_text_color,
            ),
          ),
          onTap: () {

            Get.to(LogInScreen());

          },
        ),
      ],
    );
  }

  //input text validation check
  _inputValid({required String password, required String confirmPassword}) {

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

    if (password != confirmPassword) {
      Fluttertoast.cancel();
      _showToast("Confirm Password does not match!");
      return;
    }

    return false;
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


  // new password set api call
  newPassword({
    required String otp,
    required String email,
    required String password,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Checking");

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_SET_NEW_PASSWORD'),
           // var response = await http.post(Uri.parse('http://192.168.68.106/bijoytech_ecomerce/api/new-password'),
              body: {
                'otp': otp,
                'email': email,
                'password': password
              }
          );
          Get.back();
         // _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            // _showToast("success");
            var data = jsonDecode(response.body);
            Get.to(LogInScreen());

          }

          else {

            var data = jsonDecode(response.body);
            _showToast(data['data']);
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
      _showToast("No Internet Connection!");
    }
  }

}


