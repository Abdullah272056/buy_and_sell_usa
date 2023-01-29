import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../api_service/api_service.dart';
import '../../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../../controller/auth_controller/user_auth/sign_up_page_controller.dart';
import '../../../static/Colors.dart';

import '../../common/toast.dart';
import '../../dash_board/dash_board_page.dart';
import 'log_in_page.dart';


class SignUpScreen extends StatelessWidget {

  final signUpPageController = Get.put(SignUpPageController());
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

                prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                labelText: "Your Name",

              ),
              const SizedBox(
                height: 25,
              ),
              _buildTextFieldUserEmail(
                // hintText: 'Email Address',
                obscureText: false,

                prefixedIcon: const Icon(Icons.email, color: input_box_icon_color),
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
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
      showToastLong("resumed");
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
            // contentPadding: const EdgeInsets.all(17),
            contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),

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
            // contentPadding: const EdgeInsets.all(17),
            contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),

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
            // contentPadding: const EdgeInsets.all(17),
            contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),

            suffixIcon: IconButton(
                color: input_box_icon_color,
                icon: Icon(
                  signUpPageController.isObscurePassword.value ? Icons.visibility_off : Icons.visibility,
                ),

                // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  signUpPageController.updateIsObscurePassword(!signUpPageController.isObscurePassword.value);
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
                  // contentPadding: const EdgeInsets.all(17),
                  contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),
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
            userSignUp(name: userNameTxt, email: userEmailTxt, password: confirmPasswordTxt);

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
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 50,
          alignment: Alignment.center,
          child:  const Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 17,
              fontWeight: FontWeight.w500,
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
      showToastLong("Name can't empty!");
      return;
    }
    if (userEmail.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Email can't empty!");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(userEmail)) {
      Fluttertoast.cancel();
      showToastLong("Enter valid email!");
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Password can't empty!");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      showToastLong("Password must be 8 character!");
      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.cancel();
      showToastLong("Confirm Password does not match!");
      return;
    }

    return false;
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


  userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Checking");

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_SIGN_UP'),
              // var response = await http.post(Uri.parse('http://192.168.68.106/bijoytech_ecomerce/api/login'),
              body: {
                'name': name,
                'email': email,
                'password': password
              }
          );
          Get.back();
           // _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            // _showToast("success");
            var data = jsonDecode(response.body);
            saveUserInfo(
                userName: data["data"]["name"].toString(),
                userToken: data["data"]["token"].toString());

            Get.deleteAll();
            Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());

          }
          else if (response.statusCode == 404) {
            var data = jsonDecode(response.body);
            if(data["message"]["name"]!=null){
              showToastLong(data["message"]["name"][0].toString());
              return;
            }

            if(data["message"]["email"]!=null){
              showToastLong(data["message"]["email"][0].toString());
              return;
            }

            if(data["message"]["password"]!=null){
              showToastLong(data["message"]["password"][0].toString());
              return;
            }

          }
          else {

            var data = jsonDecode(response.body);
            //_showToast(data['message']);
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
      showToastLong("No Internet Connection!");
    }
  }


  ///user info with share pref
  void saveUserInfo({required String userName,required String userToken,}) async {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, userName);
      storage.write(pref_user_token, userToken);
      storage.write(pref_user_type, "user");
    } catch (e) {
      //code
    }

  }


}


