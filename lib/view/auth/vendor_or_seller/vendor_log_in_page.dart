
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/auth/user/sign_up_page.dart';
import 'package:fnf_buy/view/auth/vendor_or_seller/vendor_fotget_password_page.dart';
import 'package:fnf_buy/view/auth/vendor_or_seller/vendor_sign_up_page.dart';
import 'package:get/get.dart';
import '../../../api_service/login_api_service.dart';
import '../../../controller/auth_controller/user_auth/log_in_page_controller.dart';
import '../../../controller/auth_controller/vendor_auth/vendor_log_in_page_controller.dart';
import '../../../static/Colors.dart';
import '../user/fotget_password_page.dart';


class VendorLogInScreen extends StatelessWidget {

  final logInPageController = Get.put(VendorLogInPageController());
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
    return Center(
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

                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [

                     Text(
                       'SELLER/VENDOR\nLOGIN',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontFamily: 'PT-Sans',
                         fontSize: 22,
                         fontWeight: FontWeight.bold,
                         color:hint_color,
                       ),
                     )
                   ],
                 ),
              const SizedBox(
                height: 20,
              ),
              //user email input
              _buildTextFieldUserEmail(
                obscureText: false,
                prefixedIcon: const Icon(Icons.email, color: input_box_icon_color),
                labelText: "Email Address",
              ),
              const SizedBox(
                height: 25,
              ),


              //password input
              _buildTextFieldPassword(
                obscureText: true,
                prefixedIcon: const Icon(Icons.lock, color: input_box_icon_color),
                labelText: "Password",
              ),

              const SizedBox(
                height: 45,
              ),
              _buildLoginButton(),
              const SizedBox(
                height: 25,
              ),

              // InkWell(
              //   child: const Text(
              //     'Forgot Password',
              //     style: TextStyle(
              //       fontFamily: 'PT-Sans',
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //       color:forgotten_password_text_color,
              //     ),
              //   ),
              //   onTap: () {
              //     Get.to(VendorForgetPasswordScreen());
              //   },
              // ),

              const SizedBox(
                height: 10,
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




  void showLoadingDialog112(String email) {
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
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const Text("Verify Your Email Address",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
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
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),


                  Container(
                    margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Fluttertoast.cancel();

                        Get.back();

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
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin:
                    const EdgeInsets.only(left: 10.0, right: 10.0),
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
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
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

  void userNotActiveDialog1(BuildContext context, String email, String userId) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Container(
            height: 300,
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
                                  fontSize: 14,
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
                                Navigator.of(context).pop();
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
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Cancel",
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
                                Navigator.of(context).pop();
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
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Verify Mail",
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
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  //user email input field create
  Widget _buildTextFieldUserEmail({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      // height: 70,

      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          logInPageController.userEmailLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
         // maxLength: 13,
          // autofocus: false,

          focusNode:logInPageController.userEmailControllerFocusNode.value,
          onSubmitted:(_){
           logInPageController.passwordControllerFocusNode.value.requestFocus();
          },
          controller: logInPageController.userEmailController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),
            // contentPadding:  EdgeInsets.all(17),
            prefixIcon: prefixedIcon,
            prefixIconColor: input_box_icon_color,

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
            ),
            labelStyle: TextStyle(
              color:logInPageController.userEmailLevelTextColor.value,
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
     logInPageController.passwordLevelTextColor.value = hasFocus ? hint_color : hint_color;
    },
    child:  Obx(() =>


        TextField(
          controller: logInPageController.passwordController.value,
          cursorColor:awsCursorColor,
          cursorWidth: 1.5,

          obscureText: logInPageController.isObscure.value,
          // obscuringCharacter: "*",
          focusNode:logInPageController.passwordControllerFocusNode.value,
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
                  logInPageController.isObscure.value ? Icons.visibility_off : Icons.visibility,
                ),

                // Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  logInPageController.updateIsObscure(!logInPageController.isObscure.value);
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
              color: logInPageController.passwordLevelTextColor.value,
            ),
          ),
        )),
    )

    );
  }

  //login button create
  Widget _buildLoginButton() {
    return ElevatedButton(
        onPressed: () {

          String userEmailTxt = logInPageController.userEmailController.value.text;
          String passwordTxt = logInPageController.passwordController.value.text;



          if (logInPageController.inputValid(userEmailTxt, passwordTxt)== false) {

            logInPageController.vendorLogIn(email: userEmailTxt, password: passwordTxt);

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
            "Login",
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
          "Don't have an Account? ",
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            color: Colors.black.withOpacity(.7),
          ),
        ),
        InkWell(
          child: const Text(
            'Create Account',
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:forgotten_password_text_color,
            ),
          ),
          onTap: () {
            Get.to(VendorSignUpScreen());

          },
        ),
      ],
    );
  }

}


