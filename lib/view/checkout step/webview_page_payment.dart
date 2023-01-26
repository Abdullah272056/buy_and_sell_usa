import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controller/cart_controller/cart__view_page_controller.dart';
import '../../controller/checkout_step_controller/web_view_page_controller.dart';
import '../../controller/checkout_step_controller/web_view_page_controller1.dart';
import '../../controller/order_controller/order_page_controller.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import '../order/order_page.dart';


class WebViewPaymentScreen extends StatefulWidget {

  String productId;
  String zipCode;
  String surName;
  String mobileNumber;
  String totalAmountWithTax;
  String emailAddress;
  String paymentLink;
  String couponCodes;
  String couponAmount;
  String couponSellerId;
  List couponDataList;
  WebViewPaymentScreen({Key? key,

    required this.productId,
    required this.zipCode,
    required this.surName,
    required this.mobileNumber,
    required this.totalAmountWithTax,
    required this.emailAddress,
    required this.paymentLink,
    required this.couponCodes,
    required this.couponAmount,
    required this.couponSellerId,
    required this.couponDataList,
  }) : super(key: key);

  @override
  State<WebViewPaymentScreen> createState() => _WebViewPaymentScreenState(

     this.productId,
     this.zipCode,
     this.surName,
     this.mobileNumber,
     this.totalAmountWithTax,
     this.emailAddress,
     this.paymentLink,
     this.couponCodes,
     this.couponAmount,
     this.couponSellerId,
     this.couponDataList,
  );
}

class _WebViewPaymentScreenState extends State<WebViewPaymentScreen>{


  String productId;
  String zipCode;
  String surName;
  String mobileNumber;
  String totalAmountWithTax;
  String emailAddress;
  String paymentLink;
  String couponCodes;
  String couponAmount;
  String couponSellerId;
  List couponDataList;

  _WebViewPaymentScreenState(

     this.productId,
     this.zipCode,
     this.surName,
     this.mobileNumber,
     this.totalAmountWithTax,
     this.emailAddress,
     this.paymentLink,
     this.couponCodes,
     this.couponAmount,
     this.couponSellerId,
     this.couponDataList,

  );

  final cartViewPageController = Get.put(WebViewPageController1());
  @override
  @protected
  @mustCallSuper
  void initState() {

    _showToast("pataq= "+couponDataList.length.toString());

   // _showToast("1"); //
   // _showToast("2");
  }
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: fnf_title_bar_bg_color,
      body:Container(
        child: Column(
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
                  "PAYMENT",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                )),


              ],
            ),


            SizedBox(height: 8,),


            Expanded(child:   Container(
              decoration: BoxDecoration(
                color:Colors.white,
              ),
              child:WebView(
                  key: _key,
                  javascriptMode: JavascriptMode.unrestricted,
                  navigationDelegate: (NavigationRequest request) {


                    //Any other url works
                    return NavigationDecision.navigate;
                  },
                  onPageFinished: (url){

                    // final uri = Uri.parse(url);
                    // if(uri.queryParameters['paymentId'].toString()!="null" ){
                    //   _showToast("payment Success full!");
                    //
                    // }else{
                    //   _showToast("else!");
                    //
                    // }



                    // if (url.toLowerCase().contains("google.com") && url.toLowerCase().contains("status")) {
                    //   if (url.toLowerCase().contains("notok")) {
                    //
                    //     Fluttertoast.showToast(msg: "not successfull");
                    //
                    //   } else if (url.toLowerCase().contains("ok")) {
                    //
                    //     Fluttertoast.showToast(msg: "successful!");
                    //
                    //   }
                    // }


                  },
                  onPageStarted: (url){
                    final uri = Uri.parse(url);
                    if(uri.queryParameters['go_to_order'].toString()=="true"){
                      Get.back();
                      Get.back();
                      Get.back();
                      // Get.deleteAll();
                      Get.to(OrderPage())?.then((value) => Get.delete<OrderPageController>());

                    }
                    else if(uri.queryParameters['paymentId'].toString()!="null" ){
                   //   _showToast("payment Success full!");

                      cartViewPageController.callOrderStoreApi(
                          coupon_code: couponCodes,
                          coupon_amount: couponAmount,
                          coupon_seller_id: couponSellerId,
                          payment_id: uri.queryParameters['paymentId'].toString(),
                          payer_id: uri.queryParameters['PayerID'].toString(),
                          payment_method: 'paypal',
                          couponDataList: couponDataList
                      );

                    }

                    else{
                      //  _showToast("else!");

                    }
                  },
                  initialUrl: paymentLink),

              /* add child content here */
            ),)
          ],
        ),
      )
      
      
    
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
class Product1{  //modal class
  String seller_id, shipping_charge,product_id,qty,color_id,size_id,shipping_name;

  Product1({
    required this.seller_id,
    required this.shipping_charge,
    required this.product_id,
    required this.qty,
    required this.color_id,
    required this.size_id,
    required this.shipping_name,
  });
}