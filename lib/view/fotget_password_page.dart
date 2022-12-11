
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/forget_password_page_controller.dart';
import '../static/Colors.dart';
import 'background.dart';
import 'email_verification_particular.dart';
import 'log_in_page.dart';

class ForgetPasswordScreen extends StatelessWidget {

  final forgetPasswordPageController = Get.put(ForgetPasswordPageController());
  late String userId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  backGroundColor,
        // backgroundColor: Colors.backGroundColor,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child:Stack(
              children: [

                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ).copyWith(
                        top: 10,
                        bottom: 60,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/icon_forgot.png",
                                  width: 80,
                                  height: 80,
                                  color: forgotten_password_text_color,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Forgot Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:fnf_bold_text_color,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Enter your email address associated with your account "
                                "we will send you a link to reset your password.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: hint_color1,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),

                          // Image.asset('assets/images/profile.jpg'),
                          const Text(
                            "",
                            style: TextStyle(
                              fontFamily: 'PT-Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                          // Image.asset('assets/images/profile.jpg'),



                          const SizedBox(
                            height: 50,
                          ),
                          _buildTextFieldEmail(
                            // hintText: 'Phone Number',
                            obscureText: false,

                            prefixedIcon: const Icon(Icons.email, color: input_box_icon_color),


                            labelText: "Email *",
                          ),

                          const SizedBox(
                            height: 40,
                          ),

                          _buildNextButton(),
                          const SizedBox(
                            height: 20,
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



        ),
      ),
    );


  }

  //user email input field create
  Widget _buildTextFieldEmail({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color: transparent,
      child: TextField(
        controller: forgetPasswordPageController.emailController.value,
        cursorColor: awsCursorColor,
        cursorWidth: 1.5,
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: prefixedIcon,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            color: hint_color,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color:hint_color,
            fontWeight: FontWeight.normal,
            fontFamily: 'PTSans',
          ),
        ),
        keyboardType: TextInputType.emailAddress,
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

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        String emailTxt = forgetPasswordPageController.emailController.value.text;
        if (_inputValid(emailTxt) == false) {
          // Get.to(EmailVerificationParticularScreen("dd"));

          // Get.to(() => EmailVerificationParticularScreen(), arguments: [
          //   {"first": 'First data'},
          //   {"second": 'Second data'}
          // ]);

          _sendEmailForOtp(emailTxt);
        } else {}


      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [button_bg_color,button_bg_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 50,
          alignment: Alignment.center,
          child: Text(
            "Next",
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
  _sendEmailForOtp(String email) async {
    // try {
    //   final result = await InternetAddress.lookup('example.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     _showLoadingDialog(context);
    //     try {
    //       Response response = await post(
    //           Uri.parse('$BASE_URL_API$SUB_URL_API_FORGRT_PASSWORD'),
    //           body: {
    //             'email': email,
    //           });
    //       Navigator.of(context).pop();
    //       if (response.statusCode == 200) {
    //         setState(() {
    //          // _showToast("success");
    //           var data = jsonDecode(response.body.toString());
    //           userId = data['data']["user_id"].toString();
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) =>
    //                       VerificationResetPasswordScreen(userId)));
    //         });
    //       } else if (response.statusCode == 401) {
    //         var data = jsonDecode(response.body.toString());
    //         _showToast(data['message']);
    //       } else {
    //         var data = jsonDecode(response.body.toString());
    //         //print(data['message']);
    //         _showToast(data['message']);
    //       }
    //     } catch (e) {
    //       Navigator.of(context).pop();
    //       print(e.toString());
    //     }
    //   }
    // } on SocketException catch (_) {
    //   Fluttertoast.cancel();
    //   _showToast("No Internet Connection!");
    // }
  }


  _inputValid(String email) {
    if (email.isEmpty) {
      Fluttertoast.cancel();
      _showToast("E-mail can't empty!");
      return;
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      Fluttertoast.cancel();
      _showToast("Enter valid email!");
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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                      children: const [
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: awsEndColor,
                          color: awsStartColor,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Checking...",
                          style: TextStyle(fontSize: 20,color:awsMixedColor),
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
