
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data_base/sqflite/notes_database.dart';

class VendorOrderDetailsPageController extends GetxController {

  // List<CartNote> notesList=[].obs;
  var totalPrice=0.0.obs;

 // var singleProductDataResponse=Get.arguments[0]['singleProductDetailsData'].toString().obs;

  var cartList=[].obs;

 // dynamic argumentData = Get.arguments;

  var orderNo="".obs;
  var shippingAmount="".obs;
  var taxAmount="".obs;
  var couponAmount="".obs;
  var totalAmount="".obs;
  var paymentId="".obs;
  var paymentMethod="".obs;
  var shippingName="".obs;

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

    // argumentData[0]['singleProductDetailsData'].toString();
    //
    // orderNo(argumentData[0]['singleProductDetailsData']["order_id"].toString());
    // shippingAmount(argumentData[0]['singleProductDetailsData']["total_shipping"].toString());
    // taxAmount(argumentData[0]['singleProductDetailsData']["total_tax"].toString());
    // couponAmount(argumentData[0]['singleProductDetailsData']["coupon_amount"].toString());
    // totalAmount(argumentData[0]['singleProductDetailsData']["total"].toString());
    // paymentId(argumentData[0]['singleProductDetailsData']["payment_id"].toString());
    // paymentMethod(argumentData[0]['singleProductDetailsData']["payment_method"].toString());
    // shippingName(argumentData[0]['singleProductDetailsData']["shipping_name"].toString());
    //
    // //billing info
    // name(argumentData[0]['singleProductDetailsData']["billings"]["first_name"].toString());
    // lastLame(argumentData[0]['singleProductDetailsData']["billings"]["last_name"].toString());
    // phone(argumentData[0]['singleProductDetailsData']["billings"]["phone"].toString());
    // email(argumentData[0]['singleProductDetailsData']["billings"]["email"].toString());
    // address(argumentData[0]['singleProductDetailsData']["billings"]["address"].toString());
    // city(argumentData[0]['singleProductDetailsData']["billings"]["city"].toString());
    // state(argumentData[0]['singleProductDetailsData']["billings"]["state_name"]["name"].toString());
    // // state(argumentData[0]['singleProductDetailsData']["billings"]["state"].toString());
    // zip(argumentData[0]['singleProductDetailsData']["billings"]["zip"].toString());
    // country(argumentData[0]['singleProductDetailsData']["billings"]["country_name"]["name"].toString());
    //
    //
    //  totalShippingTotal(argumentData[0]['singleProductDetailsData']["total_shipping"].toString());
    //  totalTaxTotal(argumentData[0]['singleProductDetailsData']["total_tax"].toString());
    //  couponAmountTotal(argumentData[0]['singleProductDetailsData']["coupon_amount"].toString());
    //  totalAmountTotal(argumentData[0]['singleProductDetailsData']["total"].toString());
    //
    // orderProductDetailsList(argumentData[0]['singleProductDetailsData']["ordered_products"]);




   // _showToast("list= "+orderProductDetailsList.length.toString());

   // refreshNotes();

    super.onInit();

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