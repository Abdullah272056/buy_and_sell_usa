
import 'package:flutter/material.dart';

import 'package:fnf_buy/view/auth/vendor_or_seller/vendor_log_in_page.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller/vendor_auth/vendor_forget_password_page_controller.dart';
import '../../../static/Colors.dart';


class VendorForgetPasswordScreen extends StatelessWidget {

  final forgetPasswordPageController = Get.put(VendorForgetPasswordPageController());

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
                width: 550,
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
          // contentPadding: const EdgeInsets.all(15),
          contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),
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

            Get.to(VendorLogInScreen());

          },
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () {
        String emailTxt = forgetPasswordPageController.emailController.value.text;
        if (forgetPasswordPageController.inputValid(emailTxt) == false) {

          forgetPasswordPageController.sendEmailForOtp(email: emailTxt);

          // Get.to(EmailVerificationScreen(),
          //     arguments: [
          //       {"first": 'First data'},
          //       {"second": 'Second data'}
          //     ]
          // );



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











}
