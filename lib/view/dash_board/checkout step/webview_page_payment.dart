import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controller/cart__view_page_controller.dart';
import '../../../controller/web_view_page_controller.dart';
import '../../../controller/web_view_page_controller1.dart';
import '../../../data_base/notes_database.dart';


class WebviewPaymentScreen extends StatefulWidget {

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
  WebviewPaymentScreen({Key? key,

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
  }) : super(key: key);

  @override
  State<WebviewPaymentScreen> createState() => _WebviewPaymentScreenState(

     this.productId,
     this.zipCode,
     this.surName,
     this.mobileNumber,
     this.totalAmountWithTax,
     this.emailAddress,
     this.paymentLink,
     this.couponCodes,
     this.couponAmount,
     this.couponSellerId,);
}

class _WebviewPaymentScreenState extends State<WebviewPaymentScreen>{


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

  _WebviewPaymentScreenState(

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
  );

  final cartViewPageController = Get.put(WebViewPageController1());
  @override
  @protected
  @mustCallSuper
  void initState() {
    _showToast("1");

    _showToast("2");
  }
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.intello_bd_color_dark,
      body: Container(
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
              if(uri.queryParameters['paymentId'].toString()!="null" ){
                _showToast("payment Success full!");

              cartViewPageController.callOrderStoreApi(
              coupon_code: couponCodes,
              coupon_amount: couponAmount,
              coupon_seller_id: couponSellerId,
              payment_id: uri.queryParameters['paymentId'].toString(),
              payer_id: uri.queryParameters['PayerID'].toString(),
              payment_method: 'paypal'
              );

              }else{
                _showToast("else!");

              }
            },
            initialUrl: paymentLink),

        /* add child content here */
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