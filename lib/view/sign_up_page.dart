import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';



import '../../controller/log_in_page_controller.dart';
import '../controller/sign_up_page_controller.dart';
import '../static/Colors.dart';
import 'log_in_page.dart';


class SignUpScreen extends StatelessWidget {

  final signUpPageController = Get.put(SignUpPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  backGroundColor,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
             // Background(),
              Center(
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
                                "assets/images/fnf_logo.png",
                                width: 180,
                                height: 80,
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),


                        // const Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text("Email",
                        //       style: TextStyle(
                        //           color: hint_color,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w400)),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        //user email input
                        _buildTextFieldUserName(
                          // hintText: 'name',
                          obscureText: false,

                          prefixedIcon: const Icon(Icons.email, color: input_box_icon_color),
                          labelText: "Your Name",

                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        _buildTextFieldUserEmail(
                          // hintText: 'Email Address',
                          obscureText: false,

                          prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                          labelText: "Email Address",

                        ),
                        const SizedBox(
                          height: 25,
                        ),

                        // const Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Text("Email",
                        //       style: TextStyle(
                        //           color: hint_color,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.w400)),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),

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
                        _buildSignUpButton(),
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
              )

            ],
          )

          ,
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



  //user name input field create
  Widget _buildTextFieldUserName({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          signUpPageController.userEmailLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:signUpPageController.userNameControllerFocusNode.value,
          onSubmitted:(_){
            signUpPageController.userEmailControllerFocusNode.value.requestFocus();
          },
          controller: signUpPageController.userNameController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(17),
            prefixIcon: prefixedIcon,
            prefixIconColor: input_box_icon_color,

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
            ),
            labelStyle: TextStyle(
              color:signUpPageController.userEmailLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
          //   LengthLimitingTextInputFormatter(
          //     13,
          //   ),
          // ],
        ),
      ),
    );
  }

  //user name input field create
  Widget _buildTextFieldUserEmail({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          signUpPageController.userEmailLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
         // maxLength: 13,
          // autofocus: false,

          focusNode:signUpPageController.userEmailControllerFocusNode.value,
          onSubmitted:(_){
            signUpPageController.passwordControllerFocusNode.value.requestFocus();
          },

          controller: signUpPageController.userEmailController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(17),
            prefixIcon: prefixedIcon,
            prefixIconColor: input_box_icon_color,

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
            ),
            labelStyle: TextStyle(
              color:signUpPageController.userEmailLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
          //   LengthLimitingTextInputFormatter(
          //     13,
          //   ),
          // ],
        ),
      ),
    );
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
        signUpPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
    },
    child:  Obx(() =>


        TextField(
          controller: signUpPageController.passwordController.value,
          cursorColor:awsCursorColor,
          cursorWidth: 1.5,

          obscureText: signUpPageController.isObscurePassword.value,
          // obscuringCharacter: "*",
          focusNode:signUpPageController.passwordControllerFocusNode.value,
          onSubmitted:(_){
            signUpPageController.confirmPasswordControllerFocusNode.value.requestFocus();
          },
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            // border: InputBorder.none,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            // labelText: 'Password',
            contentPadding: const EdgeInsets.all(17),
            suffixIcon: IconButton(
                color: input_box_icon_color,
                icon: Icon(
                  signUpPageController.isObscurePassword.value ? Icons.visibility_off : Icons.visibility,
                ),

                // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  signUpPageController.updateIsObscurePassword(!signUpPageController.isObscurePassword.value);
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
              color: signUpPageController.passwordLevelTextColor.value,
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
            signUpPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
          },
          child:  Obx(() =>


              TextField(
                controller: signUpPageController.confirmPasswordController.value,
                cursorColor:awsCursorColor,
                cursorWidth: 1.5,

                obscureText: signUpPageController.isObscureConfirmPassword.value,
                // obscuringCharacter: "*",
                focusNode:signUpPageController.confirmPasswordControllerFocusNode.value,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                  // border: InputBorder.none,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  // labelText: 'Password',
                  contentPadding: const EdgeInsets.all(17),
                  suffixIcon: IconButton(
                      color: input_box_icon_color,
                      icon: Icon(
                        signUpPageController.isObscureConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
                      ),

                      // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        signUpPageController.updateIsObscureConfirmPassword(!signUpPageController.isObscureConfirmPassword.value);
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
                    color: signUpPageController.passwordLevelTextColor.value,
                  ),
                ),
              )),
        )

    );
  }



  //login button create
  Widget _buildSignUpButton() {
    return ElevatedButton(
        onPressed: () {

          String userNameTxt = signUpPageController.userNameController.value.text;
          String userEmailTxt = signUpPageController.userEmailController.value.text;
          String passwordTxt = signUpPageController.passwordController.value.text;
          String confirmPasswordTxt = signUpPageController.confirmPasswordController.value.text;

          if (_inputValid(userName: userNameTxt, userEmail:userEmailTxt,
              password: passwordTxt, confirmPassword: confirmPasswordTxt)== false) {
            // userAutoLogIn();

        //    LogInApiService().userLogIn(userName: userNameTxt, password: passwordTxt);

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
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Container(

          height: 50,
          alignment: Alignment.center,
          child:  const Text(
            "Sign Up",
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
  _inputValid({required String userName,required String userEmail,
    required String password, required String confirmPassword}) {
    if (userName.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Name can't empty!");
      return;
    }
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
  void showLoadingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Wrap(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 20, bottom: 20),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const CircularProgressIndicator(
                          backgroundColor: awsStartColor,
                          color: awsEndColor,
                          strokeWidth: 5,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          message,
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ))
            ],
            // child: VerificationScreen(),
          ),
        );
      },
    );
  }


}


