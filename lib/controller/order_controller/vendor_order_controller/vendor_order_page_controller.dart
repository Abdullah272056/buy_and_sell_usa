
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../../../api_service/api_service.dart';
import '../../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../../data_base/sqflite/note.dart';
import '../../../data_base/sqflite/notes_database.dart';
import '../../../static/Colors.dart';

class VendorOrderPageController extends GetxController {

  // List<CartNote> notesList=[].obs;
  var totalPrice=0.0.obs;
  var cartLis=[].obs;
  var myOrderList=[].obs;

  var userName="".obs;
  var userToken="".obs;

  var isDrawerOpen = false.obs;

  var selectStateId="Pending".obs;

  var sellTodayAmount="\$0.00".obs;
  var orderTodayCount="00".obs;
  var totalSellAmount="\$0.00".obs;
  var totalOrderCount="00".obs;


  var pageNo="1".obs;
  var perPage="14".obs;
  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;
  var isMoreLoadRunning = false.obs;
  ScrollController controller=ScrollController();


  List<String> statusList=["Pending","Complete","Cancel"];

  @override
  void onInit() {
    loadUserIdFromSharePref();

    getVendorTotalCalculationData(userToken.value);
    getMyOrdersList(
      token: userToken.value,
      pageNo: pageNo.value,
      perPage: perPage.value,
    );

    /// homePageController.firstLoad();
    controller.addListener(() async{
      if(controller.position.maxScrollExtent==controller.position.pixels){

        int pageNoInt=int.parse(pageNo.value.toString());
        pageNoInt++;

        pageNo(pageNoInt.toString());
        if( hasNextPage == true ){
          getMyOrdersListNextPage( token: userToken.value, pageNo: pageNoInt.toString(), perPage: perPage.value);
        }
      }

    });
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

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));
    } catch (e) {

    }

  }


  void getVendorTotalCalculationData(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //_showToast(token);
        try {
        //  showLoadingDialog("Loading...");
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_VENDOR_DASH_BOARD_CALCULATION}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
          );
         // Get.back();
          // _showToast("calculation = "+response.statusCode.toString());
          if (response.statusCode == 200) {

            var responseData = jsonDecode(response.body);


            // _showToast("calculation = "+responseData["data"]["total_order"].toString());


            sellTodayAmount("\$"+responseData["data"]["total_sell_amount"].toStringAsFixed(2));
            totalSellAmount("\$"+responseData["data"]["today_sell_order"].toStringAsFixed(2));
            orderTodayCount("\$"+responseData["data"]["today_order"].toString());
            totalOrderCount("\$"+responseData["data"]["total_order"].toString());

            //  _showToast(myOrderList.length.toString());

          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again!");
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

  void getMyOrdersList(
      {
        required String token,
        required String pageNo,
        required String  perPage
      }
      ) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          //_showToast(token);
        try {
          isFirstLoadRunning(true);
          var response = await post(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_VENDOR_ORDER_LIST}'),
            headers: {
               'Authorization': 'Bearer '+token,
              'Content-Type': 'application/json'
              //'Content-Type': 'application/json',
            },
              body: json.encode({
                "page_no": pageNo,
                "per_page": perPage,
              })
          );
          // Get.back();
          isFirstLoadRunning(false);
          //  _showToast("orders = "+response.statusCode.toString());
          if (response.statusCode == 200) {

             var orderResponseData = jsonDecode(response.body);
             myOrderList(orderResponseData["data"]);

          //  _showToast(myOrderList.length.toString());

          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again!");
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


  void getMyOrdersListNextPage(
      {
        required String token,
        required String pageNo,
        required String  perPage
      }
      ) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //_showToast(token);
        try {
          isMoreLoadRunning(true);
          var response = await post(
              Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_VENDOR_ORDER_LIST}'),
              headers: {
                'Authorization': 'Bearer '+token,
                'Content-Type': 'application/json'
                //'Content-Type': 'application/json',
              },
              body: json.encode({
                "page_no": pageNo,
                "per_page": perPage,
              })
          );
          // Get.back();
          isMoreLoadRunning(false);
        //  _showToast("orders = "+response.statusCode.toString());
          if (response.statusCode == 200) {

            var orderResponseData = jsonDecode(response.body);
            if(orderResponseData["data"].length>0){
              myOrderList.addAll(orderResponseData["data"]);
            }else{

              hasNextPage(false);

            }

          //  _showToast(myOrderList.length.toString());

          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again!");
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


  void totalPriceCalculate(List cartList){
    double subTotal=0.0;
    for(int i=0;i<cartList.length;i++){
      double oneItemPrice=double.parse(cartList[i].productQuantity)*double.parse(cartList[i].productDiscountedPrice);
       subTotal=(subTotal+oneItemPrice);
    }
    totalPrice(subTotal);

  }


}