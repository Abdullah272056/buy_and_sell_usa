
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/profile_section/profile_section_page.dart';
import 'package:get/get.dart';

import '../../../static/Colors.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
import '../../controller/profile_section_controllert/address_page_controller.dart';
import '../cart/cart_page.dart';
import '../common/login_warning.dart';
import '../common/toast.dart';
import '../dash_board/dash_board_page.dart';
import '../dash_board/wish_list_page.dart';




class AddressPage extends StatelessWidget {

  final addressPageController = Get.put(AddressPageController());
  var width;
  var height;


  @override
  Widget build(BuildContext context) {
    width =MediaQuery.of(context).size.width;
    height =MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
            color:fnf_title_bar_bg_color,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height / 25,
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
                      Get.back();
                    },
                  ),
                  SizedBox(width: 5,),
                  Expanded(child: Text(
                    "SHIPPING ADDRESS",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),
                  )),

                  Container(
                    margin: EdgeInsets.only(top: 0,right: 15),
                    child: InkWell(
                        onTap: (){
                          Get.deleteAll();
                          Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());
                        },
                        child: Icon(
                          Icons.home_outlined,
                          size: 25,
                          color: Colors.white,
                        )
                    ),
                  ),


                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: InkWell(

                      onTap: () {
                        if(addressPageController.userToken.isNotEmpty &&
                            addressPageController.userToken.value!="null"&&
                            addressPageController.userToken.value!=null){
                          // _showToast(homeController.userToken.toString());
                          //  _showToast("add favourite");
                          Get.to(WishListPage())?.then((value) => Get.delete<WishListPageController>());
                        }else{
                          showLoginWarning();
                        }

                      },
                      child:  Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){

                      Get.to(CartPage())?.then((value) => Get.delete<CartPageController>());
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20,),


                ],
              ),
              SizedBox(height: 5,),

              Expanded(child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20,right: 20,top: 10),

                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      //user name input
                      _buildTextFieldUserFirstName(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                        labelText: "First Name*",
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Expanded(child:  _buildTextFieldUserMiddleName(
                            obscureText: false,
                            prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                            labelText: "Middle Name",
                          )),
                          SizedBox(width: 10,),
                          Expanded(child:  _buildTextFieldUserLastName(
                            obscureText: false,
                            prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                            labelText: "Last Name",
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildTextFieldUserEmail(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.email, color: input_box_icon_color),
                        labelText: "Email Address*",
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildTextFieldUserPhone(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.phone, color: input_box_icon_color),
                        labelText: "Phone*",
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextFieldUserAddress(
                        obscureText: false,
                        //  prefixedIcon: const Icon(Icons.locatio, color: input_box_icon_color),
                        labelText: "Address*",
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildTextFieldUserTownOrCity(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.location_city, color: input_box_icon_color),
                        labelText: "Town/City*",
                      ),

                      const SizedBox(
                        height: 20,
                      ),


                      Row(children: [
                        Expanded(
                          flex: 5,
                          child:   userStateSelect(),
                        ),
                        SizedBox(width: 10,),

                        Expanded(
                          flex:4,
                          child: _buildTextFieldUserZip(
                          obscureText: false,
                          prefixedIcon: const Icon(Icons.edit_location_outlined, color: input_box_icon_color),
                          labelText: "Zip Code*",
                        ),)

                      ],),


                      const SizedBox(
                        height: 20,
                      ),

                      userCountrySelect(),


                      SizedBox(height: 20,),


                      _buildAccountDetailsUpdateButton(),

                      SizedBox(height: 20,)

                    ],
                  ),
                )



              )),


            ],
          )

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
              value: addressPageController.selectStateId.value != null &&
                  addressPageController.selectStateId.value.isNotEmpty ?
              addressPageController.selectStateId.value : null,
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

              items: addressPageController.stateList.map((list) {
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
                String data= addressPageController.selectStateId(value.toString());
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
              value: addressPageController.selectCountryId.value != null &&
                  addressPageController.selectCountryId.value.isNotEmpty ?
              addressPageController.selectCountryId.value : null,
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

              items: addressPageController.countryList.map((list) {
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

  //user name input field create
  Widget _buildTextFieldUserFirstName({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },

        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,


          // maxLength: 13,
          // autofocus: false,
          focusNode:addressPageController.firstNameControllerFocusNode.value,
          onSubmitted:(_){
            addressPageController.middleNameControllerFocusNode.value.requestFocus();
          },
          controller: addressPageController.firstNameController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black,  fontSize: 16),
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
              color:addressPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
                fontSize: 16
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

  //user middle Name input field create
  Widget _buildTextFieldUserMiddleName({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:addressPageController.middleNameControllerFocusNode.value,
          onSubmitted:(_){
            addressPageController.lastNameControllerFocusNode.value.requestFocus();
          },

          controller: addressPageController.middleNameController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            // contentPadding: const EdgeInsets.all(17),
            contentPadding:  EdgeInsets.only(left: 15, right: 15,top: height/50,bottom:height/50 ),

            prefixIcon: prefixedIcon,
            prefixIconColor: input_box_icon_color,

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
            ),
            labelStyle: TextStyle(
              color:addressPageController.inputLevelTextColor.value,

            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
                fontSize: 16
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

  //user Last Name input field create
  Widget _buildTextFieldUserLastName({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:addressPageController.lastNameControllerFocusNode.value,
          onSubmitted:(_){
            addressPageController.emailAddressControllerFocusNode.value.requestFocus();
          },
          controller: addressPageController.lastNameController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black,  fontSize: 16),
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
              color:addressPageController.inputLevelTextColor.value,
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




  //user Email input field create
  Widget _buildTextFieldUserEmail({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText
  }){
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:addressPageController.emailAddressControllerFocusNode.value,
          onSubmitted:(_){
            addressPageController.phoneControllerFocusNode.value.requestFocus();
          },
          controller: addressPageController.emailAddressController.value,
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
              color:addressPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
                fontSize: 16
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

  //user Phone input field create
  Widget _buildTextFieldUserPhone({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:addressPageController.phoneControllerFocusNode.value,
          onSubmitted:(_){
            addressPageController.addressControllerFocusNode.value.requestFocus();
          },
          controller: addressPageController.phoneController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black,  fontSize: 16),
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
              color:addressPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
                fontSize: 16
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

  //user address input field create
  Widget _buildTextFieldUserAddress({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:addressPageController.addressControllerFocusNode.value,
          onSubmitted:(_){
           // checkoutPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: addressPageController.addressController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black,  fontSize: 16),
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
              color:addressPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
                fontSize: 16
            ),
          ),
          keyboardType: TextInputType.text,
          // minLines: 1,
          // maxLines: 7,
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


  //user town or city input field create
  Widget _buildTextFieldUserTownOrCity({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:addressPageController.townOrCityControllerFocusNode.value,
          onSubmitted:(_){
            addressPageController.zipCodeControllerFocusNode.value.requestFocus();
          },
          controller: addressPageController.townOrCityController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black,  fontSize: 16),
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
              color:addressPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
              fontSize: 16
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

  //user zip input field create
  Widget _buildTextFieldUserZip({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          addressPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:addressPageController.zipCodeControllerFocusNode.value,
          onSubmitted:(_){
            // checkoutPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: addressPageController.zipCodeController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 16),
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
              color:addressPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
                fontSize: 16
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


  Widget _buildAccountDetailsUpdateButton() {
    return ElevatedButton(
      onPressed: () {
        // String userEmailTxt = logInPageController.userEmailController.value.text;

        String firstName=addressPageController.firstNameController.value.text;
        String lastName=addressPageController.lastNameController.value.text;
        String middleName=addressPageController.middleNameController.value.text;
        String email=addressPageController.emailAddressController.value.text;
        String phone=addressPageController.phoneController.value.text;
        String address=addressPageController.addressController.value.text;
        String townCity=addressPageController.townOrCityController.value.text;
        String zipCode=addressPageController.zipCodeController.value.text;


            // _showToast("state="+checkoutPageController.selectStateId.value);
            // _showToast("country="+checkoutPageController.selectCountryId.value);

        if (_inputValid(f_name: firstName, l_name: lastName, email: email, phone: phone,
            address: address, town_city: townCity, zipCode: zipCode,
            selectedState: addressPageController.selectStateId.value, selectedCountry: addressPageController.selectCountryId.value)== false) {
          addressPageController.updateUserBillingInfoList(
              token: addressPageController.userToken.value,
              firstname: firstName,
              lastName:lastName,
              middleName:middleName,
              emailAddress: email,
              phoneNumber: phone,
              address: address,
              townCity: townCity,
              zipCode: zipCode,
              stateId: addressPageController.selectStateId.value,
              countryId: addressPageController.selectCountryId.value
          );
        }
      },

      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [fnf_color,fnf_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          height: 45,
          alignment: Alignment.center,
          child:  const Text(
            "Update",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  //input text validation check
  _inputValid({required String f_name, required String l_name,
    required String selectedState, required String selectedCountry,
    required String email, required String phone,required String address,
    required String town_city,required String zipCode}) {

    if (f_name.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("First name can't empty!");
      return;
    }
    // if (l_name.isEmpty) {
    //   Fluttertoast.cancel();
    //   _showToast("Last name can't empty!");
    //   return;
    // }
    if (email.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Email can't empty!");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(email)) {
      Fluttertoast.cancel();
      showToastLong("Enter valid email!");
      return;
    }

    if (phone.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Phone can't empty!");
      return;
    }


    if (selectedState.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Please select State!");
      return;
    }
    if (selectedCountry.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Please select Country!");
      return;
    }
    if (town_city.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Town or City can't empty!");
      return;
    }

    if (zipCode.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Zip code can't empty!");
      return;
    }

    if (address.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Address can't empty!");
      return;
    }

    return false;
  }





}

