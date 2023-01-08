import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/dash_board/wish_list_page.dart';
import 'package:get/get.dart';

import '../../../api_service/api_service.dart';
import '../../../controller/address_page_controller.dart';
import '../../../controller/cart_page_controller.dart';
import '../../../controller/product_details_controller.dart';
import '../../../controller/profile_section_page_controller.dart';
import '../../../controller/wish_list_page_controller.dart';
import '../../../data_base/note.dart';
import '../../../static/Colors.dart';
import '../../auth/change_password_page.dart';
import '../../common_page/product_details.dart';
import '../../common_page/product_list.dart';
import '../cart_view_page.dart';
import 'address_page.dart';
import 'order_page.dart';



class ProfileSectionPage extends StatelessWidget {
  final profileSectionPageController = Get.put(ProfileSectionPageController());
  @override
  Widget build(BuildContext context) {
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
                    "PROFILE SECTION",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),
                  )),


                ],
              ),
              SizedBox(height: 10,),
              Expanded(child: Container(
                color: Colors.white,

                child: Column(
                  children: [
                    Expanded(child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              _buildCardItem(
                                item_marginLeft: 20,
                                item_marginRight: 10,
                                name: "ORDERS",
                                imageLink: 'assets/images/orders.png',
                                onClick: 1,),

                              _buildCardItem(
                                item_marginLeft: 10,
                                item_marginRight: 20,
                                name: "ADDRESS",
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
                          ),


                        ],
                      ),
                    ))


                    /// add to cart button section

                  ],
                ),

              ))
            ],
          )

      )
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
          _showToast("orders");

          Get.to(OrderPage());

          return;
        }
        if(onClick==2){

          Get.to(() => AddressPage(),
            //     arguments: [
            //   {"productId": productDetailsController.relatedProductList[index]["id"].toString()},
            //   {"second": 'Second data'}
            // ]

          )?.then((value) => Get.delete<AddressPageController>());

          _showToast("address");
          return;
        }
        if(onClick==3){
          _showToast("account details");

          return;
        }
        if(onClick==4){
          //wish list

          Get.to(WishListPage());

          return;
        }

        if(onClick==5){

          Get.to(ChangePasswordScreen());

          return;
        }
        if(onClick==6){


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

