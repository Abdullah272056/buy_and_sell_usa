import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../controller/cart_page_controller.dart';
import '../../../controller/checkout_page_controller.dart';
import '../../../data_base/note.dart';
import '../../../static/Colors.dart';
import '../../common_page/product_details.dart';
import '../../common_page/product_list.dart';
import '../cart_view_page.dart';



class CheckoutPage extends StatelessWidget {

  final checkoutPageController = Get.put(CheckoutPageController());
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
                height: MediaQuery.of(context).size.height / 22,
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
                    "SHOPPING CART",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )),


                ],
              ),

              Expanded(child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20,right: 20,top: 10),

                child:SingleChildScrollView(
                  child: Column(
                    children: [

                      //user name input
                      _buildTextFieldUserFirstName(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                        labelText: "First Name*",
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildTextFieldUserLastName(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                        labelText: "Last Name*",
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
                      userCountrySelect(),

                      const SizedBox(
                        height: 20,
                      ),
                      userStateSelect(),

                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextFieldUserZip(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.edit_location_outlined, color: input_box_icon_color),
                        labelText: "Zip Code*",
                      ),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(child: Align(
                            alignment: Alignment.topLeft,
                            child:  Text("Your Orders",
                              style: TextStyle(
                                  color:text_color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.left,

                            ),
                          ),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(child: Align(
                            alignment: Alignment.topLeft,
                            child:  Text("Product",
                              style: TextStyle(
                                  color:text_color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,

                            ),
                          ),),
                        ],
                      ),

                      Obx(() =>   ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: checkoutPageController.cartList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {

                            return cartItem(checkoutPageController.cartList[index]);

                          }),),

                      Row(
                        children: [
                          Expanded(child: Container(height: .8,
                            color: Colors.black,
                          ))
                        ],
                      ),


                      Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child:  Text("Sub Total: ",
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: text_color,
                                    fontSize: 15
                                ),
                              ),),
                            Expanded(child:   Align(
                              alignment: Alignment.centerRight,
                               child: Text(
                                   "\$ "+"${checkoutPageController.totalPrice}",
                                  // totalPriceCalculate(cartViewPageController.cartList,
                                  // cartViewPageController.sellerGroupList[index].seller.toString()),

                                  style: TextStyle(fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                      fontSize: 16
                                  ),
                                )
                              // child:Obx(()=> Text(
                              //   "\$ "+"10",
                              //   // totalPriceCalculate(cartViewPageController.cartList,
                              //   //     cartViewPageController.sellerGroupList[index].seller.toString()),
                              //   //
                              //   style: TextStyle(fontWeight: FontWeight.w600,
                              //       color: Colors.blue,
                              //       fontSize: 16
                              //   ),
                              // )),
                            )),



                          ],
                        ) ,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child:  Text("Tax: ",
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: text_color,
                                    fontSize: 15
                                ),
                              ),),
                            Expanded(child:   Align(
                              alignment: Alignment.centerRight,

                              child:Obx(()=> Text(
                            "\$ "+"${checkoutPageController.totalTaxAmount}",
                                    // totalPriceCalculate(cartViewPageController.cartList,
                                    // cartViewPageController.sellerGroupList[index].seller.toString()),

                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                    fontSize: 16
                                ),
                              )),
                            )),



                          ],
                        ) ,
                      ),
                      Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child:  Text("Total: ",
                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: text_color,
                                    fontSize: 15
                                ),
                              ),),
                            Expanded(child:   Align(
                              alignment: Alignment.centerRight,
                              child:Obx(()=> Text(
                                "\$ "+"${checkoutPageController.totalTaxAmount.value+checkoutPageController.totalPrice.value}",

                                style: TextStyle(fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                    fontSize: 16
                                ),
                              )),

                            )),



                          ],
                        ) ,
                      ),



                      SizedBox(height: 20,),

                      _buildPlaceOrderButton(),


                      SizedBox(height: 10,)




                    ],
                  ),
                )



              )),


            ],
          )

      )
    );



  }


  Widget cartItem(CartNote response){
    return  Padding(padding: const EdgeInsets.only(right:10,top: 8,left: 10,bottom: 8),
      child: Row(

        children: [

          Text(
            response.productQuantity.toString()+" x ",
            // response.productName,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: TextStyle(
                color:text_color,
                fontSize: 14,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
          Expanded(child:   Text(
          response.productName,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          maxLines: 1,
          style: TextStyle(
              color:text_color,
              fontSize: 14,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold),
        ),),
          SizedBox(width: 10,),
          Text(
            "\$ "+"${double.parse(response.productQuantity)*double.parse(response.productDiscountedPrice)}",
            // totalPriceCalculate(cartViewPageController.cartList,
            // cartViewPageController.sellerGroupList[index].seller.toString()),

            style: TextStyle(fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontSize: 16
            ),
          )


        ],
      ),
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
              value: checkoutPageController.selectStateId.value != null &&
                  checkoutPageController.selectStateId.value.isNotEmpty ?
              checkoutPageController.selectStateId.value : null,
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

              items: checkoutPageController.stateList.map((list) {
                return DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [


                      Expanded(child: Center(
                        child: Text(
                            list["name"].toString(),
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
                  value: list["id"].toString(),
                );

              },
              ).toList(),
              onChanged:(String? value){
                String data= checkoutPageController.selectStateId(value.toString());
                // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
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
              value: checkoutPageController.selectCountryId.value != null &&
                  checkoutPageController.selectCountryId.value.isNotEmpty ?
              checkoutPageController.selectCountryId.value : null,
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

              items: checkoutPageController.countryList.map((list) {
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
          checkoutPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },

        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,


          // maxLength: 13,
          // autofocus: false,
          focusNode:checkoutPageController.firstNameControllerFocusNode.value,
          onSubmitted:(_){
            checkoutPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: checkoutPageController.firstNameController.value,
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
              color:checkoutPageController.inputLevelTextColor.value,
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
          checkoutPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:checkoutPageController.lastNameControllerFocusNode.value,
          onSubmitted:(_){
            checkoutPageController.emailAddressControllerFocusNode.value.requestFocus();
          },
          controller: checkoutPageController.lastNameController.value,
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
              color:checkoutPageController.inputLevelTextColor.value,
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
          checkoutPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:checkoutPageController.emailAddressControllerFocusNode.value,
          onSubmitted:(_){
            checkoutPageController.phoneControllerFocusNode.value.requestFocus();
          },
          controller: checkoutPageController.emailAddressController.value,
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
              color:checkoutPageController.inputLevelTextColor.value,
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
          checkoutPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:checkoutPageController.phoneControllerFocusNode.value,
          onSubmitted:(_){
            checkoutPageController.addressControllerFocusNode.value.requestFocus();
          },
          controller: checkoutPageController.phoneController.value,
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
              color:checkoutPageController.inputLevelTextColor.value,
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
          checkoutPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:checkoutPageController.addressControllerFocusNode.value,
          onSubmitted:(_){
           // checkoutPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: checkoutPageController.addressController.value,
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
              color:checkoutPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,
          minLines: 3,
          maxLines: 7,
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
          checkoutPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:checkoutPageController.townOrCityControllerFocusNode.value,
          onSubmitted:(_){
             checkoutPageController.zipCodeControllerFocusNode.value.requestFocus();
          },
          controller: checkoutPageController.townOrCityController.value,
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
              color:checkoutPageController.inputLevelTextColor.value,
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
          checkoutPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:checkoutPageController.zipCodeControllerFocusNode.value,
          onSubmitted:(_){
            // checkoutPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: checkoutPageController.zipCodeController.value,
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
              color:checkoutPageController.inputLevelTextColor.value,
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


  Widget _buildPlaceOrderButton() {
    return ElevatedButton(
      onPressed: () {
        // String userEmailTxt = logInPageController.userEmailController.value.text;

        String firstName=checkoutPageController.firstNameController.value.text;
        String lastName=checkoutPageController.lastNameController.value.text;
        String email=checkoutPageController.emailAddressController.value.text;
        String phone=checkoutPageController.phoneController.value.text;
        String address=checkoutPageController.addressController.value.text;
        String townCity=checkoutPageController.townOrCityController.value.text;
        String zipCode=checkoutPageController.zipCodeController.value.text;


            // _showToast("state="+checkoutPageController.selectStateId.value);
            // _showToast("country="+checkoutPageController.selectCountryId.value);

        if (_inputValid(f_name: firstName, l_name: lastName, email: email, phone: phone,
            address: address, town_city: townCity, zipCode: zipCode,
            selectedState: checkoutPageController.selectStateId.value, selectedCountry: checkoutPageController.selectCountryId.value)== false) {
          checkoutPageController.updateUserBillingInfoList(
              token: checkoutPageController.userToken,
              firstname: firstName,
              lastName:lastName,
              emailAddress: email,
              phoneNumber: phone,
              address: address,
              townCity: townCity,
              zipCode: zipCode,
              stateId: checkoutPageController.selectStateId.value,
              countryId: checkoutPageController.selectCountryId.value
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
          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "PLACE ORDER",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
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
      _showToast("First name can't empty!");
      return;
    }
    if (l_name.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Last name can't empty!");
      return;
    }
    if (email.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Email can't empty!");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(email)) {
      Fluttertoast.cancel();
      _showToast("Enter valid email!");
      return;
    }

    if (phone.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Phone can't empty!");
      return;
    }
    if (address.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Address can't empty!");
      return;
    }
    if (town_city.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Town or City can't empty!");
      return;
    }
    if (selectedState.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Please select State!");
      return;
    }
    if (selectedCountry.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Please select Country!");
      return;
    }
    if (zipCode.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Zip code can't empty!");
      return;
    }



    return false;
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

