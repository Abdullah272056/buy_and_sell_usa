
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/notes_database.dart';
import 'package:http/http.dart' as http;
import '../../static/Colors.dart';

class WebViewPageController1 extends GetxController {

   var webLink="".obs;
  // var webLink="https://fnfbuy.bizoytech.com/api/payment-api?surname=ripon&email=ripon@gmail.com&mobile=01732628761&amount=2".obs;

  // dynamic argumentData = Get.arguments;
   var cartList=[].obs;
   var userName="".obs;
   var userToken="".obs;

   var couponCodes= "".obs;
   var couponAmount="".obs;
   var couponSellerId="".obs;

  @override
  void onInit() {

    // _showToast("link= "+argumentData[6]['paymentLink'].toString());
    // zipCode(argumentData[1]['zipCode'].toString());
    // surName(argumentData[2]['surName'].toString());
    // mobileNumber(argumentData[3]['mobileNumber'].toString());
    // totalAmountWithTax(argumentData[4]['totalAmountWithTax'].toString());
   // webLink(argumentData[6]['emailAddress'].toString());

     readAllNotes();
     loadUserIdFromSharePref();

    super.onInit();
  }


   Future deleteNotes() async {
     NotesDataBase.instance;
     NotesDataBase.instance.deleteAllData()  ;

   }
   Future readAllNotes() async {
     NotesDataBase.instance;
     cartList(await NotesDataBase.instance.readAllNotes());

  //   _showToast("cartList"+cartList.length.toString());

   }

  void callOrderStoreApi({
     required String coupon_code,
     required String coupon_amount,
     required String coupon_seller_id,


     required List couponDataList,


     required String payment_id,
     required String payer_id,
     required String payment_method,
      }){
    //convert product list to json
    List<Product1> productList = [];
    for(int i=0;i<cartList.length;i++){
      //  _showToast("weight= " +cartViewPageController.cartList[i].weight.toString());
      productList.add(Product1(
          seller_id: cartList[i].seller.toString(),
          shipping_charge: cartList[i].shipping.toString(),
          product_id:cartList[i].productId.toString(),
          qty: cartList[i].productQuantity.toString(),
          color_id:cartList[i].colorId.toString(),
          size_id: cartList[i].sizeId.toString(),
        shipping_name: cartList[i].shippingName.toString(),
      )
      );
    }
    var productListJson = productList.map((e){
      return {
        "seller_id": e.seller_id,
        "shipping_charge": e.shipping_charge,
        "product_id": e.product_id,
        "qty": e.qty,
        "color_id": e.color_id,
        "size_id": e.size_id,
        "shipping_name": e.shipping_name
      };
    }).toList();


    //convert product list to json
    var couponDataListJson = couponDataList.map((couponData){
      return {
        "seller_id": couponData.sellerId,
        "coupon_amount": couponData.couponAmount,
        "coupon_code": couponData.couponCode,

      };
    }).toList();




   // _showToast(productList.length.toString());

    orderInfoPost(
      productJson: productListJson,
        token: userToken.value,
        coupon_code: coupon_code,
        coupon_amount: coupon_amount,
        coupon_seller_id: coupon_seller_id,
        payment_id: payment_id,
        payer_id: payer_id,
        payment_method: payment_method,
        couponDataListJson: couponDataListJson,

    );
  }

   orderInfoPost({
     required String token,
     required String coupon_code,
     required String coupon_amount,
     required String coupon_seller_id,
     required String payment_id,
     required String payer_id,
     required String payment_method,
    // required String shipping_name,
     required var productJson,
     required var couponDataListJson
   }) async {
     try {
       final result = await InternetAddress.lookup('example.com');
       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         try {
           showLoadingDialog("Saving...");
           var headers = {
             'Authorization': 'Bearer $token',
             'Content-Type': 'application/json'
           };
           var request = http.Request('POST', Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_MY_ORDERS_INFO_POST}'));
           request.body = json.encode({
             "payment_info": {
               // "coupon_code": coupon_code,
               // "coupon_amount":coupon_amount,
               // "coupon_seller_id": coupon_seller_id,
               "payment_id": payment_id,
               "payer_id": payer_id,
               "payment_method": payment_method
              // "shipping_name": shipping_name
             },
             "product": productJson,
             "sellerInfo": couponDataListJson,
           });
           request.headers.addAll(headers);

           http.StreamedResponse response = await request.send();

           Get.back();
           //_showToast("response= "+response.statusCode.toString());
           if (response.statusCode == 200) {
             _showToast(  "Order Complete Successfully!");
             deleteNotes();
             print(await response.stream.bytesToString());
           }
           else {
             print(response.reasonPhrase);
           }


         } catch (e) {
           _showToast(e.toString());
         } finally {
           //   Get.back();

           /// Navigator.of(context).pop();
         }
       }
     } on SocketException catch (_) {

       Fluttertoast.cancel();
       _showToast("No Internet Connection!");
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

   ///get data from share pref
   void loadUserIdFromSharePref() async {
     try {
       var storage =GetStorage();
       userName(storage.read(pref_user_name));
       userToken(storage.read(pref_user_token));

       // _showToast(storage.read(pref_user_token).toString());

     } catch (e) {

     }

   }


   void showLoadingDialog(String message) {

     Get.defaultDialog(
         title: '',
         titleStyle: TextStyle(fontSize: 0),
         // backgroundColor: Colors.white.withOpacity(.8),
         content: Wrap(
           children: [
             Container(
               alignment: Alignment.center,
               // margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
               child:Column(
                 children: [
                   const SizedBox(
                     width: 10,
                   ),
                   Container(
                     height:50,
                     width: 50,
                     margin: EdgeInsets.only(top: 10),
                     child: CircularProgressIndicator(
                       backgroundColor: awsStartColor,
                       color: awsEndColor,
                       strokeWidth: 6,
                     ),
                   ),

                   Container(
                     margin: EdgeInsets.only(top: 10),
                     child:Text(
                       message,
                       style: const TextStyle(fontSize: 25,),
                     ),
                   ),

                 ],
               ),
             )
           ],
           // child: VerificationScreen(),
         ),
         barrierDismissible: false,
         radius: 10.0);
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