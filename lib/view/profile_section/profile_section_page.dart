import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/dash_board/wish_list_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api_service/api_service.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/order_controller/order_page_controller.dart';
import '../../controller/profile_section_controllert/account_details_page_controller.dart';
 import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../controller/profile_section_controllert/address_page_controller.dart';
import '../../controller/profile_section_controllert/profile_section_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/note.dart';
import '../../../static/Colors.dart';

import '../auth/user/change_password_page.dart';
import '../auth/user/fotget_password_page.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';
import '../common/login_warning.dart';
import '../dash_board/dash_board_page.dart';
import 'account _details_page.dart';
import 'address_page.dart';
import '../order/order_page.dart';



class ProfileSectionPage extends StatelessWidget {
  final profileSectionPageController = Get.put(ProfileSectionPageController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {

        Get.deleteAll();
        Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());
        return true;

      },
      child: Scaffold(
          body:Container(
              decoration: BoxDecoration(
                color:fnf_title_bar_bg_color,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 16,
                    // height: 50,
                  ),
                  Flex(direction: Axis.horizontal,
                    children: [
                      SizedBox(width: 15,),
                      // IconButton(
                      //   iconSize: 20,
                      //   icon:Icon(
                      //     Icons.arrow_back_ios_new,
                      //     color: Colors.white,
                      //   ),
                      //   onPressed: () {
                      //     Get.back();
                      //   },
                      // ),
                      SizedBox(width: 5,),
                      Expanded(child: Text(
                        "PROFILE SECTION",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                      )),


                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 35,
                    // height: 50,
                  ),
                  //SizedBox(height: 10,),
                  Expanded(child: Container(
                    color: Colors.white,

                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(height: 10,),

                          if(profileSectionPageController.userToken.isNotEmpty &&
                              profileSectionPageController.userToken.value!=null&&
                              profileSectionPageController.userToken.value!="null")...{

                            Row(
                              children: [
                                _buildCardItem(
                                  item_marginLeft: 20,
                                  item_marginRight: 10,
                                  name: "MY ORDERS",
                                  imageLink: 'assets/images/orders.png',
                                  onClick: 1,),

                                _buildCardItem(
                                  item_marginLeft: 10,
                                  item_marginRight: 20,
                                  name: "BILLING ADDRESS",
                                  imageLink: 'assets/images/icon_address.png',
                                  onClick: 2,),

                              ],
                            ),

                            Row(
                              children: [
                                _buildCardItem(
                                  item_marginLeft: 20,
                                  item_marginRight: 10,
                                  name: "ACCOUNT DETAILS ",
                                  imageLink: 'assets/images/icon_account.png',
                                  onClick: 3,),
                                _buildCardItem(
                                  item_marginLeft: 10,
                                  item_marginRight: 20,
                                  name: "WISHLIST",
                                  imageLink: 'assets/images/icon_love.png',
                                  onClick: 4,),

                              ],
                            ),
                            Row(
                              children: [
                                _buildCardItem(
                                  item_marginLeft: 20,
                                  item_marginRight: 10,
                                  name: "CHANGE PASSWORD",
                                  imageLink: 'assets/images/change_password.png',
                                  onClick: 5,),

                                _buildCardItem(
                                  item_marginLeft: 10,
                                  item_marginRight: 20,
                                  name: "LOGOUT",
                                  imageLink: 'assets/images/icon_logout.png',
                                  onClick: 6,),



                              ],
                            )
                          }
                          else...{

                            Row(
                              children: [
                                _buildCardItem(
                                  item_marginLeft: 20,
                                  item_marginRight: 10,
                                  name: "SIGN IN",
                                  imageLink: 'assets/images/icon_log_in_account.png',
                                  onClick: 11,),

                                _buildCardItem(
                                  item_marginLeft: 10,
                                  item_marginRight: 20,
                                  name: "CREATE ACCOUNT",
                                  imageLink: 'assets/images/icon_create_account.png',
                                  onClick: 12,),



                              ],
                            ),

                            Row(
                              children: [
                                _buildCardItem(
                                  item_marginLeft: 20,
                                  item_marginRight: 10,
                                  name: "FORGET YOUR PASSWORD",
                                  imageLink: 'assets/images/change_password.png',
                                  onClick: 13,),


                              ],
                            )

                          }
                        ],
                      ),
                    ),
                  ))
                ],
              )
          )
      ),
    );




  }

  Widget _buildCardItem({
    required double item_marginLeft,
    required double item_marginRight,
    required String imageLink,
    required String name,
    required int onClick,
  }) {
    return InkResponse(
      onTap: (){

        if(onClick==1){
        //  _showToast("orders");

          if(profileSectionPageController.userToken.isNotEmpty &&
              profileSectionPageController.userToken.value!=null&&profileSectionPageController.userToken.value!="null"){
            Get.to(OrderPage())?.then((value) => Get.delete<OrderPageController>());

          }else{
            showLoginWarning();

          }

          return;
        }
        if(onClick==2){


          if(profileSectionPageController.userToken.isNotEmpty &&
              profileSectionPageController.userToken.value!=null&&profileSectionPageController.userToken.value!="null"){
            Get.to(() => AddressPage(),
              //     arguments: [
              //   {"productId": productDetailsController.relatedProductList[index]["id"].toString()},
              //   {"second": 'Second data'}
              // ]

            )?.then((value) => Get.delete<AddressPageController>());
          }else{
            showLoginWarning();

          }



         // _showToast("address");
          return;
        }
        if(onClick==3){
       //   _showToast("account details");


          if(profileSectionPageController.userToken.isNotEmpty &&
              profileSectionPageController.userToken.value!=null&&profileSectionPageController.userToken.value!="null"){
            Get.to(() => AccountDetailsPage(),
              //     arguments: [
              //   {"productId": productDetailsController.relatedProductList[index]["id"].toString()},
              //   {"second": 'Second data'}
              // ]

            )?.then((value) => Get.delete<AccountDetailsPageController>());
          }else{
            showLoginWarning();

          }


          return;
        }
        if(onClick==4){
          //wish list
          if(profileSectionPageController.userToken.isNotEmpty &&
              profileSectionPageController.userToken.value!=null&&profileSectionPageController.userToken.value!="null"){
            Get.to(WishListPage())?.then((value) => Get.delete<AccountDetailsPageController>());
          }else{
            showLoginWarning();

          }



          return;
        }

        if(onClick==5){


          if(profileSectionPageController.userToken.isNotEmpty &&
              profileSectionPageController.userToken.value!=null&&profileSectionPageController.userToken.value!="null"){
            Get.to(ChangePasswordScreen());
          }else{
            showLoginWarning();

          }



          return;
        }
        if(onClick==6){

          if(profileSectionPageController.userToken.isNotEmpty &&
              profileSectionPageController.userToken.value!=null&&profileSectionPageController.userToken.value!="null"){


            profileSectionPageController.getUserAccountLogOut(profileSectionPageController.userToken.value);

          }else{
            showLoginWarning();

          }



          return;
        }


        ///before login
        if(onClick==11){

          profileSectionPageController.saveUserInfoRemove(
                userName:"",
                userToken:"");
            Get.deleteAll();
            Get.to(LogInScreen());

          return;
        }
        if(onClick==12){

          profileSectionPageController.saveUserInfoRemove(
                userName:"",
                userToken:"");
            Get.deleteAll();
            Get.to(SignUpScreen());


          return;
        }
        if(onClick==13){

          profileSectionPageController.saveUserInfoRemove(
                userName:"",
                userToken:"");
            Get.deleteAll();
            Get.to(ForgetPasswordScreen());

          return;
        }


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
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: fnf_small_text_color,
                        fontSize: (Get.width/27),
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





}

