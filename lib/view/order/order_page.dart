import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../api_service/api_service.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
import '../../controller/order_controller/order_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../../static/Colors.dart';


import '../cart/cart_page.dart';
import '../dash_board/dash_board_page.dart';
import '../dash_board/wish_list_page.dart';
import '../profile_section/profile_section_page.dart';
import '../shimer/product_shimmir.dart';
import 'order_details_page.dart';




class OrderPage extends StatelessWidget {

  final orderPageController = Get.put(OrderPageController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
            color:fnf_title_bar_bg_color,
          ),
          child: Obx(() => Column(
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
                    "MY ORDER",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )),

                  Container(
                    margin: EdgeInsets.only(top: 0,right: 10),
                    child: InkWell(
                        onTap: (){
                          Get.deleteAll();
                          Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());
                        },
                        child: Icon(
                          Icons.home,
                          size: 25,
                          color: Colors.white,
                        )
                    ),
                  ),
                  SizedBox(width: 10,),


                  // Container(
                  //   margin: EdgeInsets.only(top: 0,right: 10),
                  //   child: InkWell(
                  //       onTap: (){
                  //         if(categoriesPageController.userToken.isNotEmpty &&
                  //             categoriesPageController.userToken.value!=null){
                  //           categoriesPageController.addWishList(
                  //               token: categoriesPageController.userToken.toString(),
                  //               productId: categoriesPageController.productId.toString());
                  //
                  //         }else{
                  //           showLoginWarning();
                  //         }
                  //       },
                  //       child: Icon(
                  //
                  //         Icons.favorite_border,
                  //         size: 25,
                  //         color: Colors.red,
                  //       )
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: InkWell(

                      onTap: () {
                        if(orderPageController.userToken.isNotEmpty &&
                            orderPageController.userToken.value!="null"&&
                            orderPageController.userToken.value!=null){
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

                  SizedBox(width: 10,),

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

                  SizedBox(width: 25,),


                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 125,
                // height: 50,
              ),







              if(orderPageController.cartListShimmerStatus==1)...{

                Expanded(child: Container(
                      color: Colors.white,

                      child: Column(
                        children: [

                          Expanded(child:ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount:10,

                            itemBuilder:(BuildContext context, int index){
                              return orderItemShimmer();
                            },

                          )),
                        ],
                      ),

                    ))

              }
              else...{
                Expanded(child:orderPageController.myOrderList.length>0?

                Container(
                  color: Colors.white,

                  child: Column(
                    children: [

                      Expanded(
                          child: Container(
                            color: Colors.white,

                            child:  ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount:1,
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Obx(() =>   ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: orderPageController.myOrderList.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context, int index) {
                                            return orderItem(orderPageController.myOrderList[index]);
                                          }),)
                                    ]

                                    ,
                                  );
                                }),


                          )


                      ),

                    ],
                  ),

                ):Container(
                  color: Colors.white,
                  child:LayoutBuilder(
                    builder: (context, constraints) => ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Center(
                            child:Column(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/not_found.png",
                                  width: 180,
                                  height: 80,
                                ),
                                const SizedBox(height: 20,),
                                const Text(
                                  "Cart list not found!",
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
                          ),
                        )
                      ],
                    ),
                  ) ,
                )),

              },


            ],
          ))

      )
    );



  }

  Widget orderItem(var response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 0),
      child: InkWell(
        onTap: (){

          Get.to(() => OrderDetailsPage(),
              arguments: [
            {"singleProductDetailsData": response}
          ]

          )?.then((value) => Get.delete<OrderPageController>());

        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [

                SizedBox(width: 15,),

                Expanded(child:Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Date: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          dateFormat(response["created_at"].toString()),
                          // "05-Jan-2023",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          "Order: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          response["order_id"].toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text(
                          "Total: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "\$"+response["total"].toString()+" for "+response["ordered_products_sum_qty"].toString()+" item",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),),

                Container(
                  child: Text(
                    response["status"].toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color:fnf_color,
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),
                )

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: Container(
                  height: .5,
                  color:hint_color,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }


  String dateFormat(String dateString){

    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateString);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MMM/yyyy');
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  //join now url page redirect


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

  ///shimmer
  Widget orderItemShimmer(){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 20),
      child:Flex(
        direction: Axis.horizontal,
        children: [


          Expanded(child:Column(
            children: [

              Row(children: [
                Expanded(child: buildRectangleShimmer(
                    height: 18,
                    width: double.infinity,
                    marginLeft: 0,
                    marginTop: 0,
                    marginRight: 10,
                    marginBottom: 0
                ),),
              ],),

              SizedBox(
                height: 4,
              ),
              Row(children: [
                Expanded(child: buildRectangleShimmer(
                    height: 18,
                    width: double.infinity,
                    marginLeft: 0,
                    marginTop: 0,
                    marginRight: 10,
                    marginBottom: 0
                ),),

              ],),

              SizedBox(
                height: 4,
              ),
              Row(children: [
                Expanded(child: buildRectangleShimmer(
                    height: 18,
                    width: double.infinity,
                    marginLeft: 0,
                    marginTop: 0,
                    marginRight: 10,
                    marginBottom: 0
                ),),

              ],),

            ],
          ),),


          buildRectangleShimmer(
              height: 20,
              width: 80,
              marginLeft: 0,
              marginTop: 0,
              marginRight: 0,
              marginBottom: 0
          )


        ],
      ),
    );
  }


}

