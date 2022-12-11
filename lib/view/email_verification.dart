
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';

import '../api_service/api_service.dart';
import '../controller/email_verification_page_controller.dart';
import '../static/Colors.dart';


class EmailVerificationScreen extends StatelessWidget {


  final emailVerifyPageController = Get.put(EmailVerifyPageController());





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(


              children: [
                Expanded(child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 55,
                        ),
                        Padding(
                            padding:
                            const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                            child: Column(
                              children: [

                                const SizedBox(
                                  height: 40,
                                ),

                                Image.asset(
                                  "assets/images/fnf_logo.png",
                                  width: 158,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),

                                Container(
                                  margin:const EdgeInsets.only(right: 20.0,top: 00,left: 10,bottom: 0),
                                  child: const Align(alignment: Alignment.topCenter,
                                    child: Text(
                                      "Please enter the verification code, was send to your email",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: fnf_small_color,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),),
                                ),

                                // if(_isCountingStatus==false)...[
                                //   Container(
                                //     margin:const EdgeInsets.only(right: 20.0,top: 20,left: 10,bottom: 0),
                                //     child: Align(alignment: Alignment.topCenter,
                                //       child: Text(
                                //         _startTxt,
                                //         textAlign: TextAlign.center,
                                //         style: const TextStyle(
                                //             color: fnf_color,
                                //             fontSize: 18,
                                //             fontWeight: FontWeight.w400),
                                //       ),),
                                //   ),
                                // ]
                                // else...[
                                //   Container(
                                //     margin:const EdgeInsets.only(right: 20.0,top: 15,left: 10,bottom: 0),
                                //     child: Align(alignment: Alignment.topCenter,
                                //       child: InkResponse(
                                //         onTap: (){
                                //
                                //          // _userSendCodeWithEmail();
                                //
                                //         },
                                //         child: const Text(
                                //           "Resend Code",
                                //           textAlign: TextAlign.center,
                                //           style: TextStyle(
                                //               color: hint_color,
                                //               fontSize: 15,
                                //               fontWeight: FontWeight.w400),
                                //         ),
                                //       ),),
                                //   ),
                                // ],


                                Container(
                                  margin:const EdgeInsets.only(right: 20.0,top: 15,left: 10,bottom: 0),
                                  child: Align(alignment: Alignment.topCenter,
                                    child: InkResponse(
                                      onTap: (){

                                        // _userSendCodeWithEmail();

                                      },
                                      child: const Text(
                                        "Resend Code",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: fnf_color,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),),
                                ),


                                const SizedBox(
                                  height: 30,
                                ),
                                _buildTextFieldOTPView1(),


                              ],
                            )),
                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: _buildBottomDesign(),
                        ),)


                      ],
                    )
                  ],
                )),

              ],
            ),
          ),
        ],
      ),


    );
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


  Widget _buildBottomDesign() {
    return Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),

          boxShadow: [BoxShadow(

              color:Colors.grey.withOpacity(.3),
              //  blurRadius: 20.0, // soften the shadow
              blurRadius:20, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset:const Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              )
          )],

        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 00, top: 15, right: 00, bottom: 0),
            child: Column(
              children: [

                Expanded(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Flex(direction: Axis.horizontal,
                          children: [
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("1");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "1",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("2");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "2",
                                  textAlign: TextAlign.center,

                                  style:emailVerifyPageController. keyboardTextStyle,
                                ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("3");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "3",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),

                          ],
                        ),

                        Flex(direction: Axis.horizontal,
                          children: [
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("4");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "4",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("5");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "5",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("6");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "6",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),

                          ],
                        ),

                        Flex(direction: Axis.horizontal,
                          children: [
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("7");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "7",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("8");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "8",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("9");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "9",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),

                          ],
                        ),

                        Flex(direction: Axis.horizontal,
                          children: [
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("x");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 10, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child:Image.asset(
                                  'assets/images/icon_backspace.png',
                                  height: 20,
                                  width: 30,
                                  color: fnf_color,
                                ),
                                // Text(
                                //   "x",
                                //   textAlign: TextAlign.center,
                                //
                                //   style: keyboardTextStyle,
                                // ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){
                                typeKeyboard("0");
                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
                                child: Text(
                                  "0",
                                  textAlign: TextAlign.center,

                                  style: emailVerifyPageController.keyboardTextStyle,
                                ),
                              ),
                            ),),
                            Expanded(child:InkWell(
                              onTap: (){

                               // _showToast(inputText);
                                if(emailVerifyPageController.inputText.value.length<6||emailVerifyPageController.inputText.value.length>6){

                                  _showToast("Input six digit pin");

                                }
                                else{
                                 // _userVerify(userId: _userId,otp:inputText );
                                  //_userVerify(userId: _userId,otp:inputText );
                                }

                              },
                              child: Container(
                                padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 10, bottom:emailVerifyPageController. keyboardfontBottomPadding),
                                child:Image.asset('assets/images/submit_icon.png',
                                  height: 30,
                                  width: 30,
                                  color: fnf_color,

                                ),

                              ),
                            ),),



                          ],
                        ),

                      ],
                    )

                ),


                const SizedBox(height: 15,),

              ],
            )));
  }

  ///otp field box
  Widget _buildTextFieldOTPView1() {
    return  Flex(direction: Axis.horizontal,
      children: [
        Expanded(child: Container(
          height: 55,
          decoration: BoxDecoration(
              color:box_bg_color,
              borderRadius: BorderRadius.circular(6)),
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
          padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
          child: Center(
            child:   Obx(() =>
                Text(
                  emailVerifyPageController.firstDigitPin.value,
                  textAlign: TextAlign.center,

                  style: emailVerifyPageController.otpInputBoxTextStyle,
                )
            )
            ,
          ),
        ),),
        Expanded(child: Container(
          height: 55,
          decoration: BoxDecoration(
              color:box_bg_color,
              borderRadius: BorderRadius.circular(6)),
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
          padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
          child:Center(
            child: Obx(() => Text(
              emailVerifyPageController.secondDigitPin.value,
              textAlign: TextAlign.center,

              style: emailVerifyPageController.otpInputBoxTextStyle,
            )),
          ),
        ),),
        Expanded(child: Container(
          height: 55,
          decoration: BoxDecoration(
              color:box_bg_color,
              borderRadius: BorderRadius.circular(6)),
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
          padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
          child: Center(
            child: Obx(() =>Text(
              emailVerifyPageController.thirdDigitPin.value,
              textAlign: TextAlign.center,

              style: emailVerifyPageController.otpInputBoxTextStyle,
            )),
          ),
        ),),
        Expanded(child: Container(
          height: 55,
          decoration: BoxDecoration(
              color:box_bg_color,
              borderRadius: BorderRadius.circular(6)),
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
          padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
          child: Center(
            child: Obx(() =>Text(
              emailVerifyPageController.fourthDigitPin.value,
              textAlign: TextAlign.center,

              style: emailVerifyPageController.otpInputBoxTextStyle,
            )),
          ),
        ),),
        Expanded(child: Container(
          height: 55,
          decoration: BoxDecoration(
              color:box_bg_color,
              borderRadius: BorderRadius.circular(6)),
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
          padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
          child: Center(
            child:Obx(() =>
                Text(
                  emailVerifyPageController.fifthDigitPin.value,
                  textAlign: TextAlign.center,

                  style: emailVerifyPageController.otpInputBoxTextStyle,
                )

            ),
          ),
        ),),
        Expanded(child: Container(
          height: 55,
          decoration: BoxDecoration(
              color:box_bg_color,
              borderRadius: BorderRadius.circular(6)),
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
          padding:EdgeInsets.only(left: 00, top: emailVerifyPageController.keyboardfontTopPadding, right: 00, bottom: emailVerifyPageController.keyboardfontBottomPadding),
          child: Center(child: Obx(() =>
          Text(
            emailVerifyPageController.sixthDigitPin.value,
            textAlign: TextAlign.center,

            style: emailVerifyPageController.otpInputBoxTextStyle,
          )),
          ),
        ),),

      ],
    );
  }


  ///input otp text combination
  void typeKeyboard(String typeKey) {
    if (typeKey == "x") {
      if (emailVerifyPageController.inputText.value.length > 1) {
        emailVerifyPageController.inputText(emailVerifyPageController.inputText.value.substring(0, emailVerifyPageController.inputText.value.length - 1));
        // inputText = emailVerifyPageController.inputText.value.substring(0, emailVerifyPageController.inputText.value.length - 1);
      } else {
        emailVerifyPageController.inputText("");
        // inputText = "";
      }
    }
    else {
      String abc = emailVerifyPageController.inputText.value + typeKey;
      if(abc.length<=6){
        emailVerifyPageController.inputText(emailVerifyPageController.inputText.value + typeKey);
        // inputText = emailVerifyPageController.inputText.value + typeKey;
      }

    }
    setText(emailVerifyPageController.inputText.value);
  }


  ///input text set in text box
  void setText(String inputText){

    if(inputText.isEmpty){
      emailVerifyPageController.firstDigitPin("-");
      emailVerifyPageController.secondDigitPin("-");
      emailVerifyPageController.thirdDigitPin("-");
      emailVerifyPageController.fourthDigitPin("-");
      emailVerifyPageController.fifthDigitPin("-");
      emailVerifyPageController.sixthDigitPin("-");
      return;
    }
    if(inputText.length==1){
      emailVerifyPageController.firstDigitPin(inputText[0].toString());
      emailVerifyPageController.secondDigitPin("-");
      emailVerifyPageController.thirdDigitPin("-");
      emailVerifyPageController.fourthDigitPin("-");
      emailVerifyPageController.fifthDigitPin("-");
      emailVerifyPageController.sixthDigitPin("-");
      return;
    }
    if(inputText.length==2){
      emailVerifyPageController.firstDigitPin(inputText[0].toString());
      emailVerifyPageController.secondDigitPin(inputText[1].toString());
      emailVerifyPageController.thirdDigitPin("-");
      emailVerifyPageController.fourthDigitPin("-");
      emailVerifyPageController.fifthDigitPin("-");
      emailVerifyPageController.sixthDigitPin("-");
      return;
    }
    if(inputText.length==3){
      emailVerifyPageController.firstDigitPin(inputText[0].toString());
      emailVerifyPageController.secondDigitPin(inputText[1].toString());
      emailVerifyPageController.thirdDigitPin(inputText[2].toString());
      emailVerifyPageController.fourthDigitPin("-");
      emailVerifyPageController.fifthDigitPin("-");
      emailVerifyPageController.sixthDigitPin("-");
      return;
    }
    if(inputText.length==4){
      emailVerifyPageController.firstDigitPin(inputText[0].toString());
      emailVerifyPageController.secondDigitPin(inputText[1].toString());
      emailVerifyPageController.thirdDigitPin(inputText[2].toString());
      emailVerifyPageController.fourthDigitPin(inputText[3].toString());
      emailVerifyPageController.fifthDigitPin("-");
      emailVerifyPageController.sixthDigitPin("-");
      return;
    }
    if(inputText.length==5){
      emailVerifyPageController.firstDigitPin(inputText[0].toString());
      emailVerifyPageController.secondDigitPin(inputText[1].toString());
      emailVerifyPageController.thirdDigitPin(inputText[2].toString());
      emailVerifyPageController.fourthDigitPin(inputText[3].toString());
      emailVerifyPageController.fifthDigitPin(inputText[4].toString());
      emailVerifyPageController.sixthDigitPin("-");

      return;
    }
    if(inputText.length==6){
      emailVerifyPageController.firstDigitPin(inputText[0].toString());
      emailVerifyPageController.secondDigitPin(inputText[1].toString());
      emailVerifyPageController.thirdDigitPin(inputText[2].toString());
      emailVerifyPageController.fourthDigitPin(inputText[3].toString());
      emailVerifyPageController.fifthDigitPin(inputText[4].toString());
      emailVerifyPageController.sixthDigitPin(inputText[5].toString());

      return;

    }

  }


  ///input otp text combination
  void typeKeyboard1(String typeKey) {
    // setState(() {
    //   if (typeKey == "x") {
    //     if (emailVerifyPageController.inputText.value.length > 1) {
    //       emailVerifyPageController.inputText(emailVerifyPageController.inputText.value.substring(0, emailVerifyPageController.inputText.value.length - 1));
    //       // inputText = emailVerifyPageController.inputText.value.substring(0, emailVerifyPageController.inputText.value.length - 1);
    //     } else {
    //       emailVerifyPageController.inputText("");
    //       // inputText = "";
    //     }
    //   }
    //   else {
    //     String abc = emailVerifyPageController.inputText.value + typeKey;
    //     if(abc.length<=6){
    //       emailVerifyPageController.inputText(emailVerifyPageController.inputText.value + typeKey);
    //       // inputText = emailVerifyPageController.inputText.value + typeKey;
    //     }
    //
    //   }
    //   setText(emailVerifyPageController.inputText.value);
    // });
  }


  ///input text set in text box
  void setText1(String inputText){

    // setState(() {
    //   if(inputText.isEmpty){
    //     emailVerifyPageController.firstDigitPin("-");
    //     emailVerifyPageController.secondDigitPin("-");
    //     emailVerifyPageController.thirdDigitPin("-");
    //     emailVerifyPageController.fourthDigitPin("-");
    //     emailVerifyPageController.fifthDigitPin("-");
    //     emailVerifyPageController.sixthDigitPin("-");
    //     return;
    //   }
    //   if(inputText.length==1){
    //     emailVerifyPageController.firstDigitPin(inputText[0].toString());
    //     emailVerifyPageController.secondDigitPin("-");
    //     emailVerifyPageController.thirdDigitPin("-");
    //     emailVerifyPageController.fourthDigitPin("-");
    //     emailVerifyPageController.fifthDigitPin("-");
    //     emailVerifyPageController.sixthDigitPin("-");
    //     return;
    //   }
    //   if(inputText.length==2){
    //     emailVerifyPageController.firstDigitPin(inputText[0].toString());
    //     emailVerifyPageController.secondDigitPin(inputText[1].toString());
    //     emailVerifyPageController.thirdDigitPin("-");
    //     emailVerifyPageController.fourthDigitPin("-");
    //     emailVerifyPageController.fifthDigitPin("-");
    //     emailVerifyPageController.sixthDigitPin("-");
    //     return;
    //   }
    //   if(inputText.length==3){
    //     emailVerifyPageController.firstDigitPin(inputText[0].toString());
    //     emailVerifyPageController.secondDigitPin(inputText[1].toString());
    //     emailVerifyPageController.thirdDigitPin(inputText[2].toString());
    //     emailVerifyPageController.fourthDigitPin("-");
    //     emailVerifyPageController.fifthDigitPin("-");
    //     emailVerifyPageController.sixthDigitPin("-");
    //     return;
    //   }
    //   if(inputText.length==4){
    //     emailVerifyPageController.firstDigitPin(inputText[0].toString());
    //     emailVerifyPageController.secondDigitPin(inputText[1].toString());
    //     emailVerifyPageController.thirdDigitPin(inputText[2].toString());
    //     emailVerifyPageController.fourthDigitPin(inputText[3].toString());
    //     emailVerifyPageController.fifthDigitPin("-");
    //     emailVerifyPageController.sixthDigitPin("-");
    //     return;
    //   }
    //   if(inputText.length==5){
    //     emailVerifyPageController.firstDigitPin(inputText[0].toString());
    //     emailVerifyPageController.secondDigitPin(inputText[1].toString());
    //     emailVerifyPageController.thirdDigitPin(inputText[2].toString());
    //     emailVerifyPageController.fourthDigitPin(inputText[3].toString());
    //     emailVerifyPageController.fifthDigitPin(inputText[4].toString());
    //     emailVerifyPageController.sixthDigitPin("-");
    //
    //     return;
    //   }
    //   if(inputText.length==6){
    //     emailVerifyPageController.firstDigitPin(inputText[0].toString());
    //     emailVerifyPageController.secondDigitPin(inputText[1].toString());
    //     emailVerifyPageController.thirdDigitPin(inputText[2].toString());
    //     emailVerifyPageController.fourthDigitPin(inputText[3].toString());
    //     emailVerifyPageController.fifthDigitPin(inputText[4].toString());
    //     emailVerifyPageController.sixthDigitPin(inputText[5].toString());
    //
    //     return;
    //
    //   }
    //
    // });

  }

}

