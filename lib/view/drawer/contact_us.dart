import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/drawer_controller/contact_us_controller.dart';
import '../../controller/drawer_controller/faq_controller.dart';
import '../../controller/drawer_controller/privacy_policy_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';
import '../checkout step/checkout_page.dart';
import '../product/product_details.dart';

class ContactUsPage extends StatelessWidget {
  var width;
  var height;
  final contactUsController = Get.put(ContactUsController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width =MediaQuery.of(context).size.width;
    height =MediaQuery.of(context).size.height;
    return Scaffold(
        body:Container(
            decoration: BoxDecoration(
              color:fnf_title_bar_bg_color,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  // height: 50,
                ),

                Flex(direction: Axis.horizontal,
                  children: [
                    SizedBox(width: 5,),
                    IconButton(
                      iconSize: 20,
                      icon:Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () {

                        //   _showToast("back");


                        Get.back();
                      },
                    ),
                    SizedBox(width: 5,),
                    Expanded(child: Text(
                      "CONTACT US",
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),
                    )),


                  ],
                ),

                SizedBox(
                    height: 7
                  // height: 50,
                ),


                Expanded(
                    child:Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [


                              Text(
                                "Contact Information",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                                style: TextStyle(
                                    color:fnf_color,
                                    fontSize: 18,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w700),
                              ),
                             SizedBox(height: 10,),
                             Obx(() =>  Text(
                               contactUsController.contactInfoMessage.value,
                               // overflow: TextOverflow.ellipsis,
                               // softWrap: false,
                               // maxLines: 1,
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                   color:fnf_small_text_color,
                                   fontSize: 15,
                                   decoration: TextDecoration.none,
                                   fontWeight: FontWeight.w500),
                             ),),


                              Row(
                                children: [

                                  Obx(() => _buildCardItem(
                                    item_marginLeft: 0,
                                    item_marginRight: 10,
                                    name: "Phone NUmber",
                                    imageLink: 'assets/images/phone_number.png',
                                    nameValue: contactUsController.phoneNumber.value,),),

                                  Obx(() =>  _buildCardItem(
                                    item_marginLeft: 10,
                                    item_marginRight: 0,
                                    name: "Email ADDRESS",
                                    imageLink: 'assets/images/email.png',
                                    nameValue: contactUsController.emailAddress.value,),),





                                ],
                              ),
                              Row(
                                children: [

                                  Obx(() =>   _buildCardItem(
                                    item_marginLeft: 0,
                                    item_marginRight: 10,
                                    name: "Address",
                                    imageLink: 'assets/images/icon_address.png',
                                    nameValue:contactUsController.address.value,),),

                                  Obx(() => _buildCardItem(
                                    item_marginLeft: 10,
                                    item_marginRight: 0,
                                    name: "Fax",
                                    imageLink: 'assets/images/fax.png',
                                    nameValue: contactUsController.faxNumber.value,),),





                                ],
                              ),


                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text(
                                    "Frequent Asked Questions",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color:fnf_color,
                                        fontSize: 18,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),

                              Obx(() =>  ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: contactUsController.faqList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    // _showToast(cartPageController.cartList[index].productPhoto.toString());
                                    return Obx(() => faqListItem(contactUsController.faqList[index],contactUsController.faqListExpandedStatusList[index],index));
                                  })),

                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    "Send Us a Message",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color:fnf_color,
                                        fontSize: 18,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),

                              Row(
                                children: [
                                  Text(
                                    "Your Name",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color:text_color,
                                        fontSize: 15,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              _buildTextFieldUserName(hintText: "Enter Your Name"),
                              SizedBox(height: 20,),


                              Row(
                                children: [
                                  Text(
                                    "Your Name",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color:text_color,
                                        fontSize: 15,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              _buildTextFieldEmail(hintText: "Enter Your Email"),
                              SizedBox(height: 20,),

                              Row(
                                children: [
                                  Text(
                                    "Your Message",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color:text_color,
                                        fontSize: 15,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              _buildTextFieldMessage(hintText: "Enter Your Message"),

                              SizedBox(height: 10,),
                              _buildSendMessageButton(),
                            ],
                          ),
                        )



                    )


                )

              ],
            )

        )
    );



  }

  Widget faqListItem(var response,int expandedStatus,int index){
    return  InkWell(
      onTap: (){
        if(expandedStatus==1){
          contactUsController.faqListExpandedStatusList[index]=0;
        }
        else{
          contactUsController.faqListExpandedStatusList[index]=1;
        }

      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: hint_color.withOpacity(0.2),)
        ),
        margin:const EdgeInsets.only(left:0, top: 00, right: 0, bottom: 10   ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            Row(
              children: [
                Expanded(child: Container(
                  color: hint_color.withOpacity(0.2),
                  margin:const EdgeInsets.only(left:0, top: 00, right: 0, bottom: 5  ),
                  padding:const EdgeInsets.only(left:0, top: 10, right: 0, bottom: 10  ),
                  // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),

                      Expanded(child: Text(
                        response["title"].toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 2,
                        style: TextStyle(
                            color:text_color,
                            fontSize: 15,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      )),

                      SizedBox(width: 10,),

                      if(expandedStatus==1)...{
                        Icon(
                          Icons.arrow_drop_up,
                          color: Colors.black,
                          size: 22.0,
                        ),
                      }
                      else...{
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.black,
                          size: 22.0,
                        ),

                      },


                      SizedBox(width: 10,)
                    ],
                  ),

                ),),

              ],
            ),

            if(expandedStatus==1)...{

              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 20),
                  //color: Colors.yellow,
                  child: Text(
                    response["description"].toString(),
                    textAlign: TextAlign.left,

                    style: TextStyle(
                        color:hint_color,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )

            }


          ],
        ),
      ),
    );
  }

  Widget _buildCardItem({
    required double item_marginLeft,
    required double item_marginRight,
    required String imageLink,
    required String name,
    required String nameValue,

  }) {
    return InkResponse(
      onTap: (){




      },
      child: Container(
        margin:  EdgeInsets.only(left: item_marginLeft, right: item_marginRight,bottom: 10,top: 10),
        width: (Get.width/2)-30,
        decoration: BoxDecoration(
          color: Colors.white ,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(

              color: Colors.grey.withOpacity(.25) ,
              //  blurRadius: 20.0, // soften the shadow
              blurRadius: 20 , // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              )
          )],
        ),
        //   height: 150,
        child: Container(
          margin: const EdgeInsets.only(right: 10.0,top: 20,bottom: 20,left: 10),
          // height: double.infinity,
          // width: double.infinity,

          child: Center(
            child: Column(
              children: [


                Align(
                  alignment: Alignment.topCenter,

                  child: Image.asset(
                    imageLink,
                    color: fnf_color,
                    width: (Get.width/9),
                    height: (Get.width/9),
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: text_color,
                        fontSize: (Get.width/27),
                        fontWeight: FontWeight.w600),
                    softWrap: false,
                    maxLines:2,
                  ),
                ),
                const SizedBox(height: 10,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    nameValue,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: fnf_small_text_color,
                        fontSize: (Get.width/32),
                        fontWeight: FontWeight.w500),
                    softWrap: false,
                    maxLines:2,
                  ),
                ),
                const SizedBox(height: 5,),




              ],
            ),
          ),
        ) ,
      ),

    );
  }


  void showLoginWarning( ) {

    Get.defaultDialog(
        contentPadding: EdgeInsets.zero,

        //  title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [

            Stack(
              children: [
                Container(

                    child:   Center(
                      child: Column(
                        children: [

                          Container(

                            margin:EdgeInsets.only(right:00.0,top: 0,left: 00,
                              bottom: 0,
                            ),
                            child:Image.asset(
                              "assets/images/fnf_logo.png",
                              // color: sohojatri_color,
                              // width: 81,
                              height: 40,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child:   Text(
                                "This section is Locked",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Go to login or Sign Up screen \nand try again ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.to(SignUpScreen());

                                //  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));

                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              child: Ink(

                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [sohojatri_color, sohojatri_color],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                child: Container(

                                  height: 40,
                                  alignment: Alignment.center,
                                  child:  Text(
                                    "SIGN UP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PT-Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 0),
                            child: InkWell(
                              onTap: (){
                                Get.back();
                                Get.to(LogInScreen());
                                //   Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                height: 40,
                                alignment: Alignment.center,
                                child:  Text(
                                  "LOG IN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PT-Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: sohojatri_color,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

                ),
                Align(alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),



                    child: InkWell(
                      onTap: (){
                        Get.back();


                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.deepOrangeAccent,
                        size: 22.0,
                      ),
                    ),
                  ),

                ),
              ],
            )

          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }

  //login button create
  Widget _buildSendMessageButton() {
    return ElevatedButton(
      onPressed: () {

        String userNameTxt = contactUsController.userNameController.value.text;
        String userEmailTxt = contactUsController.userEmailController.value.text;
        String messageTxt = contactUsController.messageController.value.text;

        if(userNameTxt.isEmpty){
          _showToast("Name can't Empty!");
          return;

        }
        if(userEmailTxt.isEmpty){
          _showToast("Email can't Empty!");
          return;

        }
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
          //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
        )
            .hasMatch(userEmailTxt)) {
          Fluttertoast.cancel();
          _showToast("Enter valid email!");
          return;
        }
        if(messageTxt.isEmpty){
          _showToast("Message can't Empty!");
          return;

        }

        contactUsController. contactUsMessageSend(name: userNameTxt, email: userEmailTxt, message: messageTxt);



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
            "Send Message",
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


  //user name input field create
  Widget _buildTextFieldUserName({
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          contactUsController.userEmailLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:contactUsController.userNameControllerFocusNode.value,
          onSubmitted:(_){
            contactUsController.userEmailControllerFocusNode.value.requestFocus();
          },
          controller: contactUsController.userNameController.value,
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
              color:contactUsController.userEmailLevelTextColor.value,
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
  Widget _buildTextFieldEmail({

    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          contactUsController.userEmailLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:contactUsController.userEmailControllerFocusNode.value,
          onSubmitted:(_){
            contactUsController.messageControllerFocusNode.value.requestFocus();
          },
          controller: contactUsController.userEmailController.value,
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
              color:contactUsController.userEmailLevelTextColor.value,
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
  Widget _buildTextFieldMessage({

    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          contactUsController.userEmailLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:contactUsController.messageControllerFocusNode.value,
          onSubmitted:(_){
            //contactUsController.userEmailControllerFocusNode.value.requestFocus();
          },
          controller: contactUsController.messageController.value,
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
              color:contactUsController.userEmailLevelTextColor.value,
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

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}

