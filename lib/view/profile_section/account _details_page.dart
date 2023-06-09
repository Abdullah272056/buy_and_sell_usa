
import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/common/toast.dart';
import 'package:fnf_buy/view/profile_section/profile_section_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
import '../../controller/profile_section_controllert/account_details_page_controller.dart';
 import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/checkout_step_controller/checkout_page_controller.dart';
import '../../controller/profile_section_controllert/image_full_view_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../../static/Colors.dart';
import '../cart/cart_page.dart';
import '../common/login_warning.dart';
import '../dash_board/dash_board_page.dart';
import '../dash_board/wish_list_page.dart';
import 'image_full_view_screen.dart';

class AccountDetailsPage extends StatelessWidget {

  final accountDetailsPageController = Get.put(AccountDetailsPageController());
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
                    "My Account",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
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
                        if(accountDetailsPageController.userToken.isNotEmpty &&
                            accountDetailsPageController.userToken.value!="null"&&
                            accountDetailsPageController.userToken.value!=null){
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
              SizedBox(
                height: 6,
                // height: 50,
              ),

              Expanded(child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20,right: 20,top: 10),

                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),


                      _buildImageSection(),



                      //user name input
                      _buildTextFieldUserFirstName(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                        labelText: "Name",
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),

                      // _buildTextFieldUserLastName(
                      //   obscureText: false,
                      //   prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                      //   labelText: "Last Name",
                      // ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildTextFieldUserEmail(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.email, color: input_box_icon_color),
                        labelText: "Email Address",
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildTextFieldUserPhone(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.phone, color: input_box_icon_color),
                        labelText: "Phone",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildTextFieldUserMobile(
                        obscureText: false,
                        prefixedIcon: const Icon(Icons.mobile_screen_share, color: input_box_icon_color),
                        labelText: "Mobile",
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
                        labelText: "Town/City",
                      ),


                      const SizedBox(
                        height: 20,
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



                      SizedBox(height: 20,),


                      _buildAccountDetailsUpdateButton(),

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

  Widget _buildImageSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Stack(
          children: [
            InkResponse(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.black26,
                    child:InkResponse(
                      child: Obx(() => FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/loading.png',
                        image: "https://fnfbuy.bizoytech.com/public/frontend/profile/"+accountDetailsPageController.imageLink.value,
                        // accountDetailsPageController.imageLink.value,
                        imageErrorBuilder: (context, url, error) => Image.asset(
                          'assets/images/loading.png',
                          fit: BoxFit.cover,
                        ),
                      )),
                    )),
              ),
              onTap: () {


                Get.to(() => ImageFullViewPage(), arguments: [
                  {"imageLink": "https://fnfbuy.bizoytech.com/public/frontend/profile/"+accountDetailsPageController.imageLink.value.toString()},
                ])?.then((value) => Get.delete<ImageFullViewPageController>());



                // if (_imageLink.isNotEmpty) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               ProfileFullScreenImage(_imageLink)));
                // }

              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 80,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    IconButton(
                        onPressed: () {
                          accountDetailsPageController.openBottomSheet();
                        //  showModalBottomSheet(context: context, builder: ( (builder) =>_buildImageUploadBottomSheet()));
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: fnf_color,
                          size: 27,
                        ))
                  ],
                ),
              ],
            )
          ],
        ),
       Obx(() =>  Text(
         accountDetailsPageController.userName.value,
         style: TextStyle(
           fontSize: 20,
           //fontSize: MediaQuery.of(context).size.height / 25,
           fontWeight: FontWeight.w500,
           color: text_color,
         ),
       ),),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  // Widget userStateSelect1() {
  //   return Column(
  //     children: [
  //       Container(
  //         // height: 50,
  //           alignment: Alignment.center,
  //          // margin: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20,),
  //           decoration: BoxDecoration(
  //               color:Colors.white,
  //               border: Border(
  //
  //                 left: BorderSide(width: 1.0, color: hint_color),
  //                 right: BorderSide(width:1.0, color: hint_color),
  //                 bottom: BorderSide(width: 1.0, color: hint_color),
  //                 top: BorderSide(width: 1.0, color: hint_color),
  //               ),
  //               borderRadius: BorderRadius.circular(5)),
  //           child: Obx(()=>DropdownButton2(
  //             //  buttonHeight: 40,
  //             //   menuMaxHeight:55,
  //             itemPadding: EdgeInsets.only(left: 5,right: 0),
  //             value: accountDetailsPageController.selectStateId.value != null &&
  //                 accountDetailsPageController.selectStateId.value.isNotEmpty ?
  //             accountDetailsPageController.selectStateId.value : null,
  //             underline:const SizedBox.shrink(),
  //             hint:Row(
  //               children: const [
  //                 SizedBox(width: 5,),
  //                 Expanded(child: Center(child: Text("Selected State",
  //                     style: TextStyle(
  //                         color: text_color,
  //                         fontSize: 15,
  //                         fontWeight: FontWeight.normal)),))
  //               ],
  //             ),
  //             isExpanded: true,
  //             /// icon: SizedBox.shrink(),
  //             buttonPadding: const EdgeInsets.only(left: 0, right: 0),
  //
  //             items: accountDetailsPageController.stateList.map((list) {
  //               return DropdownMenuItem(
  //                 alignment: Alignment.center,
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.max,
  //                   children: [
  //
  //
  //                     Expanded(child: Center(
  //                       child: Text(
  //                         list.stateName,
  //                           // list["name"].toString(),
  //                           textAlign: TextAlign.center,
  //                           style:  TextStyle(
  //                               color: text_color,
  //                               //color: intello_text_color,
  //                               fontSize: 15,
  //                               fontWeight: FontWeight.normal)),
  //                     ),),
  //
  //
  //
  //
  //                   ],
  //                 ),
  //
  //
  //                 // value: list["id"].toString(),
  //                 value: list.stateId.toString(),
  //               );
  //
  //             },
  //             ).toList(),
  //             onChanged:(String? value){
  //               String data= accountDetailsPageController.selectStateId(value.toString());
  //              //  _showToast("Id ="+checkoutPageController.selectStateId(value.toString()));
  //             },
  //
  //           ))
  //       ),
  //
  //     ],
  //   )
  //   ;
  // }
  Widget userStateSelect() {
    return Column(
      children: [
        Container(
          // height: 50,
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20,),
            decoration: BoxDecoration(
                color:Colors.white,
                border: const Border(

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
              value: accountDetailsPageController.selectStateId.value != null &&
                  accountDetailsPageController.selectStateId.value.isNotEmpty ?
              accountDetailsPageController.selectStateId.value : null,
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

              items: accountDetailsPageController.stateList.map((list) {
                return DropdownMenuItem(
                  alignment: Alignment.center,


                  // value: list["id"].toString(),
                  value: list.stateId.toString(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [


                      Expanded(child: Center(
                        child: Text(
                            list.stateName,
                            // list["name"].toString(),
                            textAlign: TextAlign.center,
                            style:  const TextStyle(
                                color: text_color,
                                //color: intello_text_color,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                      ),),




                    ],
                  ),
                );

              },
              ).toList(),
              onChanged:(String? value){
                String data= accountDetailsPageController.selectStateId(value.toString());
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
              value: accountDetailsPageController.selectCountryId.value != null &&
                  accountDetailsPageController.selectCountryId.value.isNotEmpty ?
              accountDetailsPageController.selectCountryId.value : null,
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

              items: accountDetailsPageController.countryList.map((list) {
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
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },

        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,


          // maxLength: 13,
          // autofocus: false,
          focusNode:accountDetailsPageController.firstNameControllerFocusNode.value,
          onSubmitted:(_){
            accountDetailsPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.firstNameController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
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
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:accountDetailsPageController.lastNameControllerFocusNode.value,
          onSubmitted:(_){
            accountDetailsPageController.emailAddressControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.lastNameController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
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
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:accountDetailsPageController.emailAddressControllerFocusNode.value,
          onSubmitted:(_){
            accountDetailsPageController.phoneControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.emailAddressController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
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
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:accountDetailsPageController.phoneControllerFocusNode.value,
          onSubmitted:(_){
            accountDetailsPageController.mobileControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.phoneController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
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
  Widget _buildTextFieldUserMobile({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:accountDetailsPageController.mobileControllerFocusNode.value,
          onSubmitted:(_){
            accountDetailsPageController.addressControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.mobileController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
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
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:accountDetailsPageController.addressControllerFocusNode.value,
          onSubmitted:(_){
           // checkoutPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.addressController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,
          // minLines: 3,
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
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:accountDetailsPageController.townOrCityControllerFocusNode.value,
          onSubmitted:(_){
            accountDetailsPageController.zipCodeControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.townOrCityController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
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
          accountDetailsPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },
        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,
          // maxLength: 13,
          // autofocus: false,

          focusNode:accountDetailsPageController.zipCodeControllerFocusNode.value,
          onSubmitted:(_){
            // checkoutPageController.lastNameControllerFocusNode.value.requestFocus();
          },
          controller: accountDetailsPageController.zipCodeController.value,
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
              color:accountDetailsPageController.inputLevelTextColor.value,
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

  Widget _buildAccountDetailsUpdateButton() {
    return ElevatedButton(
      onPressed: () {
        // String userEmailTxt = logInPageController.userEmailController.value.text;

        String firstName=accountDetailsPageController.firstNameController.value.text;
        String lastName=accountDetailsPageController.lastNameController.value.text;
        String email=accountDetailsPageController.emailAddressController.value.text;
        String phone=accountDetailsPageController.phoneController.value.text;
        String address=accountDetailsPageController.addressController.value.text;
        String townCity=accountDetailsPageController.townOrCityController.value.text;
        String zipCode=accountDetailsPageController.zipCodeController.value.text;
        String mobile=accountDetailsPageController.mobileController.value.text;


            // _showToast("state="+checkoutPageController.selectStateId.value);
            // _showToast("country="+checkoutPageController.selectCountryId.value);

        if (_inputValid(f_name: firstName,  email: email, phone: phone,
            address: address, town_city: townCity, zipCode: zipCode,
            selectedState: accountDetailsPageController.selectStateId.value,
            selectedCountry: accountDetailsPageController.selectCountryId.value)== false) {
          accountDetailsPageController.updateUserAccountDetails(
              token: accountDetailsPageController.userToken.value,
              firstname: firstName,
              emailAddress: email,
              phoneNumber: phone,
              address: address,
              townCity: townCity,
              zipCode: zipCode,
              stateId: accountDetailsPageController.selectStateId.value,
              countryId: accountDetailsPageController.selectCountryId.value,
              mobile: mobile
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
  _inputValid({required String f_name ,
    required String selectedState, required String selectedCountry,
    required String email, required String phone,required String address,
    required String town_city,required String zipCode}) {

    if (f_name.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("First name can't empty!");
      return;
    }

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

