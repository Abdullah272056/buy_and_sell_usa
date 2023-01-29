
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/note.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import '../../view/common/toast.dart';

class OrderPageController extends GetxController {

  // List<CartNote> notesList=[].obs;
  var totalPrice=0.0.obs;

  var myOrderList=[].obs;

  var userName="".obs;
  var userToken="".obs;

  var cartListShimmerStatus=1.obs;


  @override
  void onInit() {
    loadUserIdFromSharePref();

    getMyOrdersList(userToken.value);
    super.onInit();
  }




  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));
    } catch (e) {

    }

  }

  void getMyOrdersList(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          //_showToast(token);
        try {
          cartListShimmerStatus(1);
          // showLoadingDialog("Loading...");
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_MY_ORDERS_LIST}'),
            headers: {
               'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
          );
          cartListShimmerStatus(0);
          // Get.back();
         //   _showToast("orders = "+response.statusCode.toString());
          if (response.statusCode == 200) {

            var orderResponseData = jsonDecode(response.body);
            myOrderList(orderResponseData["data"]);

          //  _showToast(myOrderList.length.toString());

          }
          else {
            // Fluttertoast.cancel();
            showToastShort("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
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