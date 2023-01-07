import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_service/api_service.dart';
import '../../../controller/order_page_controller.dart';
import '../../../controller/product_details_controller.dart';
import '../../../data_base/note.dart';
import '../../../static/Colors.dart';

import '../../common_page/product_details.dart';
import '../cart_view_page.dart';

class OrderDetailsPage extends StatelessWidget {

  final cartPageController = Get.put(OrderPageController());
  final Uri _url = Uri.parse('https://fnfbuy.bizoytech.com/payment-api?surname=ripon&email=ripon@gmail.com&mobile=01732628761&amount=20');

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
                      userInputSelectTopic(keyName: 'Order No:', value: '63b64d151cb7d'),
                      userInputSelectTopic(keyName: 'Shipping Amount:', value: '\$0.00'),
                      userInputSelectTopic(keyName: 'Tax Amount:', value: '\$0.00'),
                      userInputSelectTopic(keyName: 'Coupon Amount:', value: '\$0.00'),
                      userInputSelectTopic(keyName: 'Total Amount:', value: '\$138.10'),
                      userInputSelectTopic(keyName: 'Payment Id:', value: '3JC88937BT645715R'),
                      userInputSelectTopic(keyName: 'Payment method:', value: 'paypal'),
                      userInputSelectTopic(keyName: 'Shipping:', value: 'Express shipping 8 - 10 days'),

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
                      userInputSelectTopic(keyName: 'Name No:', value: 'Abdullah al aman'),
                      userInputSelectTopic(keyName: 'Phone:', value: '01994215664'),
                      userInputSelectTopic(keyName: 'Email:', value: ' abdullah272056@gmail.com'),
                      userInputSelectTopic(keyName: 'Address:', value: 'Dhaka'),
                      userInputSelectTopic(keyName: 'City:', value: 'Dhaka'),
                      userInputSelectTopic(keyName: 'State:', value: 'Arizona'),
                      userInputSelectTopic(keyName: 'Zip:', value: '10001'),
                      userInputSelectTopic(keyName: 'Country:', value: 'United States'),

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
                                    itemCount: cartPageController.cartList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return
                                        //Container();

                                        cartItem(cartPageController.cartList[index]);
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

  //join now url page redirect
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
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

