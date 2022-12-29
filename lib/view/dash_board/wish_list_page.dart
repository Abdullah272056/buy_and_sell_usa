import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/cart_page_controller.dart';
import '../../controller/wish_list_page_controller.dart';
import '../../data_base/note.dart';
import '../../static/Colors.dart';
import '../common_page/product_details.dart';
import '../common_page/product_list.dart';
import 'cart_view_page.dart';



class WishListPage extends StatelessWidget {
  final wishListPageController = Get.put(WishListPageController());
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
                    "WISH LIST",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )),


                ],
              ),
              Expanded(child: Container(
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
                                    Obx(() => ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: wishListPageController.wishList.length>0 ? wishListPageController.wishList.length:0,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return


                                          cartItem(wishListPageController.wishList[index]);
                                        }))
                                  ]

                                  ,
                                );
                              }),
                        )


                    ),


                  ],
                ),

              ))
            ],
          )

      )
    );



  }

  Widget cartItem(var response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 20),
      child: InkWell(
        onTap: (){
          Get.to(() => ProductDetailsePageScreen(), arguments: [
            {"productId": response["product"]["id"].toString()},
            {"second": 'Second data'}
          ]);
        },
        child: Flex(
          direction: Axis.horizontal,
          children: [

            Container(
              width: 56,
              height: 56,

              margin:const EdgeInsets.only(left:0, top: 00, right: 22, bottom: 00),
              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      height: 56,
                      width: 56,
                      color:hint_color,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.fill,
                        placeholder: 'assets/images/loading.png',
                        image:response["product"]["cover_image"].toString(),
                        imageErrorBuilder: (context, url, error) =>
                            Image.asset(
                              'assets/images/loading.png',
                              fit: BoxFit.fill,
                            ),
                      )),
                ),
              ),

            ),

            Expanded(child:Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child:Text(
                    response["product"]["product_name"].toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color:text_color,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // Container(
                //   margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                //   child:  Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.only(left: 00,right: 20),
                //         padding: EdgeInsets.all(7),
                //         // height: 80,
                //         width:80,
                //         child: Center(
                //           child: Text(
                //             "10.0% OFF",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 13,
                //                 fontWeight: FontWeight.normal
                //             ),
                //           ),
                //         ),
                //         decoration: BoxDecoration(
                //           color:Colors.blue,
                //           borderRadius: const BorderRadius.only(
                //             bottomRight: Radius.circular(7.0),
                //             bottomLeft: Radius.circular(7.0),
                //             topLeft: Radius.circular(7.0),
                //             topRight: Radius.circular(7.0),
                //           ),
                //           boxShadow: [BoxShadow(
                //
                //             color:Colors.grey.withOpacity(.5),
                //             //  blurRadius: 20.0, // soften the shadow
                //             blurRadius:20, // soften the shadow
                //             spreadRadius: 0.0, //extend the shadow
                //             offset:Offset(
                //               2.0, // Move to right 10  horizontally
                //               1.0, // Move to bottom 10 Vertically
                //             ),
                //           )],
                //         ),
                //       ),
                //       Expanded(child:  Row(
                //         children:  [
                //           Obx(() => Text(
                //             "\$${homeController.productRegularPrice.value}",
                //             overflow: TextOverflow.ellipsis,
                //             style:  TextStyle(
                //                 color: Colors.red,
                //                 fontSize: 13,
                //                 decoration: TextDecoration.lineThrough,
                //                 fontWeight: FontWeight.normal),
                //             softWrap: false,
                //             maxLines: 1,
                //           ),),
                //           SizedBox(width: 10,),
                //
                //           Obx(() =>  Text(
                //             "\$${homeController.productDiscountedPrice.value}",
                //             overflow: TextOverflow.ellipsis,
                //             style:  TextStyle(
                //                 color: Colors.blue,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w600),
                //             softWrap: false,
                //             maxLines: 1,
                //           ))
                //         ],
                //       ))
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [

                    const SizedBox(
                      width: 8,
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("\$"+
                          response["product"]["price"].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: hint_color,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("\$"+discountedPrice(mainPrice: response["product"]["price"].toString(),
                        discountedPercent: response["product"]["discount_percent"].toString(),)
                          ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: fnf_color,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )


              ],
            ),),
            IconButton(
              iconSize: 25,
              color: fnf_color,
              icon: const Icon(Icons.delete),
              onPressed: () {
                //_showToast( response.id.toString());
                // response.id
              //  cartPageController.deleteNotes(int.parse(response.id.toString()));
              },
            ),
          ],
        ),
      ),
    );
  }

  String discountedPrice({required String mainPrice,required String discountedPercent}){
    double discountedPrice=double.parse(mainPrice) -(double.parse(mainPrice) * double.parse(discountedPercent))/100;
    return discountedPrice.toString();
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

