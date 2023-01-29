
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data_base/sqflite/notes_database.dart';

class VendorOrderDetailsPageController extends GetxController {

  // List<CartNote> notesList=[].obs;
  var totalPrice=0.0.obs;

 // var singleProductDataResponse=Get.arguments[0]['singleProductDetailsData'].toString().obs;

  var cartList=[].obs;

 dynamic argumentData = Get.arguments;

  var orderNo="".obs;
  var shippingAmount="".obs;
  var taxAmount="".obs;
  var couponAmount="".obs;
  var totalAmount="".obs;
  var paymentId="".obs;
  var paymentMethod="".obs;
  var shippingName="".obs;
  var vendorName="".obs;

  ///billing info
  var name="".obs;
  var lastLame="".obs;
  var phone="".obs;
  var email="".obs;
  var address="".obs;
  var city="".obs;
  var state="".obs;
  var zip="".obs;
  var country="".obs;

  ///customer info
   var customerName="".obs;
   var customerPhone="".obs;
   var customerEmail="".obs;
   var customerAddress="".obs;
   var customerCity="".obs;
   var customerState="".obs;
   var customerZip="".obs;
   var customerCountry="".obs;

   var totalShippingTotal="".obs;
   var totalTaxTotal="".obs;
   var couponAmountTotal="".obs;
   var totalAmountTotal="".obs;

  ///product list
  var orderProductDetailsList=[].obs;

  @override
  void onInit() {

    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);

    argumentData[0]['singleOrderDetailsData'].toString();



    totalShippingTotal(argumentData[0]['singleOrderDetailsData']["total_shipping"].toString());
    totalTaxTotal(argumentData[0]['singleOrderDetailsData']["total_tax"].toString());
    couponAmountTotal(argumentData[0]['singleOrderDetailsData']["coupon_amount"].toString());
    totalAmountTotal(argumentData[0]['singleOrderDetailsData']["total"].toString());


    //order info
    orderNo(argumentData[0]['singleOrderDetailsData']["order_id"].toString());
    shippingAmount(argumentData[0]['singleOrderDetailsData']["total_shipping"].toString());
    taxAmount(argumentData[0]['singleOrderDetailsData']["total_tax"].toString());
    couponAmount(argumentData[0]['singleOrderDetailsData']["coupon_amount"].toString());
    totalAmount(argumentData[0]['singleOrderDetailsData']["total"].toString());
    paymentId(argumentData[0]['singleOrderDetailsData']["payment_id"].toString());
    paymentMethod(argumentData[0]['singleOrderDetailsData']["payment_method"].toString());
    shippingName(argumentData[0]['singleOrderDetailsData']["shipping_name"].toString());
   vendorName(argumentData[0]['singleOrderDetailsData']["vendor"]["name"].toString());



    // //billing info
    name(argumentData[0]['singleOrderDetailsData']["billings"]["first_name"].toString());
    lastLame(argumentData[0]['singleOrderDetailsData']["billings"]["last_name"].toString());
    phone(argumentData[0]['singleOrderDetailsData']["billings"]["phone"].toString());
    email(argumentData[0]['singleOrderDetailsData']["billings"]["email"].toString());
    address(argumentData[0]['singleOrderDetailsData']["billings"]["address"].toString());
    city(argumentData[0]['singleOrderDetailsData']["billings"]["city"].toString());
     state(argumentData[0]['singleOrderDetailsData']["billings"]["state_name"]["name"].toString());
    zip(argumentData[0]['singleOrderDetailsData']["billings"]["zip"].toString());
     country(argumentData[0]['singleOrderDetailsData']["billings"]["country_name"]["name"].toString());


    //  totalShippingTotal(argumentData[0]['singleProductDetailsData']["total_shipping"].toString());
    //  totalTaxTotal(argumentData[0]['singleProductDetailsData']["total_tax"].toString());
    //  couponAmountTotal(argumentData[0]['singleProductDetailsData']["coupon_amount"].toString());
    //  totalAmountTotal(argumentData[0]['singleProductDetailsData']["total"].toString());
    //
    // orderProductDetailsList(argumentData[0]['singleProductDetailsData']["ordered_products"]);



    //customer info
     customerName(argumentData[0]['singleOrderDetailsData']["user"]["name"].toString());
     customerPhone(argumentData[0]['singleOrderDetailsData']["user"]["phone"].toString());
     customerEmail(argumentData[0]['singleOrderDetailsData']["user"]["email"].toString());
     customerAddress(argumentData[0]['singleOrderDetailsData']["user"]["address"].toString());
     customerCity(argumentData[0]['singleOrderDetailsData']["user"]["city"].toString());
     customerState(argumentData[0]['singleOrderDetailsData']["user"]["state"]["name"].toString());
     customerZip(argumentData[0]['singleOrderDetailsData']["user"]["zip_code"].toString());
     customerCountry(argumentData[0]['singleOrderDetailsData']["user"]["country"]["name"].toString());



    orderProductDetailsList(argumentData[0]['singleOrderDetailsData']["ordered_products"]);







   // refreshNotes();

    super.onInit();

  }



  Future refreshNotes() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());

    totalPriceCalculate(cartList);
   // _showToast("Local length= "+cartList.length.toString());
  }

  Future deleteNotes(int id) async {
    NotesDataBase.instance;
    NotesDataBase.instance.delete(id)  ;
    refreshNotes();

  }

  void totalPriceCalculate(List cartList){
    double subTotal=0.0;
    for(int i=0;i<cartList.length;i++){
      double oneItemPrice=double.parse(cartList[i].productQuantity)*double.parse(cartList[i].productDiscountedPrice);
       subTotal=(subTotal+oneItemPrice);
    }
    totalPrice(subTotal);

  }

}