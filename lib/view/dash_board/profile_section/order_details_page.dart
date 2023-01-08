import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_service/api_service.dart';
import '../../../controller/order_details_page_controller.dart';
import '../../../controller/order_page_controller.dart';
import '../../../controller/product_details_controller.dart';
import '../../../data_base/note.dart';
import '../../../static/Colors.dart';

import '../../common_page/product_details.dart';
import '../cart_view_page.dart';

class OrderDetailsPage extends StatelessWidget {

  final orderDetailsPageController = Get.put(OrderDetailsPageController());

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
                  SizedBox(width: 10,),
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
              SizedBox(width: 15,),
              Expanded(child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,

                  child: Column(
                    children: [


                      Container(
                        child: Row(
                          children: [

                            Expanded(child: Center(child:  Text(
                              "ORDER INFO",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),))

                          ],
                        ),
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        color: Colors.orange,
                      ),
                      Obx(()=> userInputSelectTopic(keyName: 'Order No:', value: orderDetailsPageController.orderNo.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Shipping Amount:', value: orderDetailsPageController.shippingAmount.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Tax Amount:', value: orderDetailsPageController.taxAmount.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Coupon Amount:', value: orderDetailsPageController.couponAmount.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Total Amount:', value: orderDetailsPageController.totalAmount.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Payment Id:', value: orderDetailsPageController.paymentId.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Payment method:', value: orderDetailsPageController.paymentMethod.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Shipping:', value: orderDetailsPageController.shippingName.value),),


                      Container(
                        child: Row(
                          children: [

                            Expanded(child: Center(child:  Text(
                              "BILLINGS INFO",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),))

                          ],
                        ),
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        color: Colors.orange,
                      ),

                      Obx(()=>  userInputSelectTopic(keyName: 'Name No:', value: orderDetailsPageController.name.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Phone:', value: orderDetailsPageController.phone.value),),
                      Obx(()=>  userInputSelectTopic(keyName: 'Email:', value: orderDetailsPageController.email.value),),
                      Obx(()=> userInputSelectTopic(keyName: 'Address:', value: orderDetailsPageController.address.value),),
                      Obx(()=>  userInputSelectTopic(keyName: 'City:', value: orderDetailsPageController.city.value),),

                      Obx(()=>   userInputSelectTopic(keyName: 'State:', value: orderDetailsPageController.state.value),),
                      Obx(()=>  userInputSelectTopic(keyName: 'Zip:', value: orderDetailsPageController.zip.value),),
                      Obx(()=>   userInputSelectTopic(keyName: 'Country:', value:orderDetailsPageController.country.value),),









                      Container(

                        child: Row(
                          children: [

                            Expanded(child: Center(child:  Text(
                              "PRODUCT INFO",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),))

                          ],
                        ),
                        margin: EdgeInsets.only(top: 20,bottom: 10),
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        color: Colors.orange,
                      ),


                      ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:1,
                          shrinkWrap: true,
                          //physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Obx(() =>   ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: orderDetailsPageController.cartList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return
                                        //Container();

                                        cartItem(orderDetailsPageController.cartList[index]);
                                    }),)
                              ]

                              ,
                            );
                          }),

                    ],
                  ),

                ),
              ))
            ],
          )

      )
    );
  }

  Widget userInputSelectTopic({required String keyName, required String value}) {
    return Column(
      children: [
        Container(
          // height: 50,

            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5,),

            child:  Row(
              children: [
                Text(
                  keyName,
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
                  value,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  style: TextStyle(
                      color:fnf_small_text_color,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
        ),

      ],
    )
    ;
  }

  Widget cartItem(CartNote response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 10),
      child: InkWell(
        onTap: (){

          // Get.to(() => ProductDetailsePageScreen(), arguments: [
          //   {"productId": response.productId.toString()},
          //   {"second": 'Second data'}
          // ])?.then((value) => Get.delete<ProductDetailsController>());

        },
        child: Flex(
          direction: Axis.horizontal,
          children: [

            Container(
              width: 60,
              height: 60,

              margin:const EdgeInsets.only(left:0, top: 00, right: 22, bottom: 00),
              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      height: 60,
                      width: 60,
                      color:hint_color,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.fill,
                        placeholder: 'assets/images/loading.png',
                        image:BASE_URL_API_IMAGE_PRODUCT+response.productPhoto,
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
                    response.productName,
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
                      child: Text(
                        "Qty x Price:",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: text_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        response.productQuantity+" X ",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: text_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("\$"+
                          response.productDiscountedPrice,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: hint_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [

                    const SizedBox(
                      width: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Shipping: ",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: text_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("\$"+
                          response.productDiscountedPrice,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: hint_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [

                    const SizedBox(
                      width: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Tax: ",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: text_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("\$"+
                          response.productDiscountedPrice,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: hint_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),


              ],
            ),),

            Container(
              margin: EdgeInsets.only(left: 10,right: 10,),
              child: Text(
                "\$560.5",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: text_color,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            )

          ],
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

