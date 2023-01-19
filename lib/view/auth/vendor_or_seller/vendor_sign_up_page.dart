
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fnf_buy/view/auth/vendor_or_seller/vendor_log_in_page.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller/vendor_auth/vendor_sign_up_page_controller.dart';
import '../../../static/Colors.dart';

class VendorSignUpScreen extends StatelessWidget {

  final signUpPageController = Get.put(VendorSignUpPageController());
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
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    ///ratio 1:2.25
                    Image.asset(
                      "assets/images/fnf_logo.png",
                      width: 113,
                      height: 50,
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'SELLER/VENDOR\nSIGN UP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:hint_color,
                    ),
                  )


                ],
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




              _buildTextFieldUserInput(
                labelText: "Full Name*",
                textEditingController:signUpPageController.fullNameController.value,
                focusNode: signUpPageController.fullNameControllerFocusNode.value,
                nextFocusNode: signUpPageController.companyNameControllerFocusNode.value,
              ),


              const SizedBox(
                height: 20,
              ),

              _buildTextFieldUserInput(
                labelText: "Company Name*",
                textEditingController:signUpPageController.companyNameController.value,
                focusNode: signUpPageController.companyNameControllerFocusNode.value,
                nextFocusNode: signUpPageController.storeCompanyWebsiteControllerFocusNode.value,

              ),
              const SizedBox(
                height: 20,
              ),
              _buildTextFieldUserInput(
                labelText: "Website Link (optional)",
                textEditingController:signUpPageController.storeCompanyWebsiteController.value,
                focusNode: signUpPageController.storeCompanyWebsiteControllerFocusNode.value,
                nextFocusNode: signUpPageController.phoneNoControllerFocusNode.value,

              ),
              const SizedBox(
                height: 20,
              ),
              _buildTextFieldUserInput(
                labelText: "Phone No*",
                textEditingController:signUpPageController.phoneNoController.value,
                focusNode: signUpPageController.phoneNoControllerFocusNode.value,
                nextFocusNode: signUpPageController.mobileNoControllerFocusNode.value,

              ),
              const SizedBox(
                height: 20,
              ),
              _buildTextFieldUserInput(
                labelText: "Mobile No",
                textEditingController:signUpPageController.mobileNoController.value,
                focusNode: signUpPageController.mobileNoControllerFocusNode.value,
                nextFocusNode: signUpPageController.addressControllerFocusNode.value,

              ),
              const SizedBox(
                height: 20,
              ),
              _buildTextFieldUserInput(
                labelText: "Address*",
                textEditingController:signUpPageController.addressController.value,
                focusNode: signUpPageController.addressControllerFocusNode.value,
                nextFocusNode: signUpPageController.cityControllerFocusNode.value,

              ),

              const SizedBox(
                height: 20,
              ),



              userCountrySelect(),

              const SizedBox(
                height: 20,
              ),

              userStateSelect(),
              const SizedBox(
                height: 20,
              ),






              _buildTextFieldUserInput(
                labelText: "City*",
                textEditingController:signUpPageController.cityController.value,
                focusNode: signUpPageController.cityControllerFocusNode.value,
                nextFocusNode: signUpPageController.zipCodeControllerFocusNode.value,

              ),

              const SizedBox(
                height: 20,
              ),
              _buildTextFieldUserInput(
                labelText: "Zip Code*",
                textEditingController:signUpPageController.zipCodeController.value,
                focusNode: signUpPageController.zipCodeControllerFocusNode.value,
                nextFocusNode: signUpPageController.userEmailControllerFocusNode.value,
              ),

              const SizedBox(
                height: 20,
              ),
              _buildTextFieldUserInput(
                labelText: "Email*",
                textEditingController:signUpPageController.userEmailController.value,
                focusNode: signUpPageController.userEmailControllerFocusNode.value,
                nextFocusNode: signUpPageController.passwordControllerFocusNode.value,
              ),

              const SizedBox(
                height: 20,
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


  ///start
  //user input field create
  Widget _buildTextFieldUserInput({
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
    required TextEditingController textEditingController,
    required FocusNode focusNode,
    required FocusNode nextFocusNode,
  }) {
    return Container(
      color:transparent,
      child: TextField(
        cursorColor: awsCursorColor,
        cursorWidth: 1.5,


        // autofocus: false,

        focusNode:focusNode,
        onSubmitted:(_){
          nextFocusNode.requestFocus();
        },
        controller: textEditingController,
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



  Widget userStateSelect() {
    return Column(
      children: [
        Container(
          // height: 50,
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20,),
            decoration: BoxDecoration(
                color:Colors.white,
                border: Border(

                  left: BorderSide(width: 1.0, color: hint_color),
                  right: BorderSide(width:1.0, color: hint_color),
                  bottom: BorderSide(width: 1.0, color: hint_color),
                  top: BorderSide(width: 1.0, color: hint_color),
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Obx(()=>DropdownButton2(
              //  buttonHeight: 40,
              //   menuMaxHeight:55,
              itemPadding: EdgeInsets.only(left: 5,right: 0),
              value: signUpPageController.selectStateId.value != null &&
                  signUpPageController.selectStateId.value.isNotEmpty ?
              signUpPageController.selectStateId.value : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 5,),
                  Expanded(child: Center(child: Text("Selected State",
                      style: TextStyle(
                          color: text_color,
                          fontSize: 15,
                          fontWeight: FontWeight.normal)),))
                ],
              ),
              isExpanded: true,
              /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 0),

              items: signUpPageController.stateList.map((list) {
                return DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [


                      Expanded(child: Center(
                        child: Text(
                            list.stateName,
                            // list["name"].toString(),
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                                color: text_color,
                                //color: intello_text_color,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                      ),),




                    ],
                  ),


                  // value: list["id"].toString(),
                  value: list.stateId.toString(),
                );

              },
              ).toList(),
              onChanged:(String? value){
                String data= signUpPageController.selectStateId(value.toString());
                //  _showToast("Id ="+checkoutPageController.selectStateId(value.toString()));
              },

            ))
        ),

      ],
    )
    ;
  }

  Widget userCountrySelect() {
    return Column(
      children: [
        Container(
          // height: 50,
            alignment: Alignment.center,
            //  margin: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20,),
            decoration: BoxDecoration(
                color:Colors.white,
                border: Border(

                  left: BorderSide(width: 1.0, color: hint_color),
                  right: BorderSide(width:1.0, color: hint_color),
                  bottom: BorderSide(width: 1.0, color: hint_color),
                  top: BorderSide(width: 1.0, color: hint_color),
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Obx(()=>DropdownButton2(
              //  buttonHeight: 40,
              //   menuMaxHeight:55,
              itemPadding: EdgeInsets.only(left: 5,right: 0),
              value: signUpPageController.selectCountryId.value != null &&
                  signUpPageController.selectCountryId.value.isNotEmpty ?
              signUpPageController.selectCountryId.value : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 5,),
                  Expanded(child: Center(child: Text("Selected Country",
                      style: TextStyle(
                          color: text_color,
                          fontSize: 15,
                          fontWeight: FontWeight.normal)),))
                ],
              ),
              isExpanded: true,
              /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 0),

              items: signUpPageController.countryList.map((list) {
                return DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [


                      Expanded(child: Center(
                        child: Text(
                            list.c_name.toString(),
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                                color: text_color,
                                //color: intello_text_color,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                      ),),




                    ],
                  ),

                  // Text(list["country_name"].toString()),
                  value: list.c_id.toString(),
                );

              },
              ).toList(),
              onChanged:(String? value){
                //  String data= checkoutPageController.selectCountryId(value.toString());
                // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
              },

            ))
        ),

      ],
    )
    ;
  }


  //login button create
  Widget _buildSignUpButton() {
    return ElevatedButton(
        onPressed: () {


          String userEmailTxt = signUpPageController.userEmailController.value.text;
          String passwordTxt = signUpPageController.passwordController.value.text;
          String confirmPasswordTxt = signUpPageController.confirmPasswordController.value.text;



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

            Get.to(VendorLogInScreen());

          },
        ),
      ],
    );
  }





}


