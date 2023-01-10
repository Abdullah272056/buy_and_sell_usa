
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../data_base/note.dart';
import 'package:http/http.dart' as http;
import '../data_base/notes_database.dart';
import '../static/Colors.dart';

class CartViewPageController extends GetxController {

  var totalPrice=0.0.obs;
  var cartList=[].obs;
  var sellerGroupList=[].obs;

  var userName="".obs;
  var userToken="".obs;
  var inputLevelTextColor = hint_color.obs;
  final promoCodeController = TextEditingController().obs;
  @override
  void onInit() {
    readAllNotes();
    loadUserIdFromSharePref();
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

  Future readAllNotes() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());

    totalPriceCalculate(cartList);
    totalSellerCountCalculate(cartList);
   // _showToast("Local length= "+cartList.length.toString());
  }

  Future updateNotes(CartNote cartNote) async {
    NotesDataBase.instance;
    NotesDataBase.instance.update(cartNote)  ;
    readAllNotes();

  }

  Future deleteNotes(int id) async {
    NotesDataBase.instance;
    NotesDataBase.instance.delete(id)  ;
    readAllNotes();

  }

  void totalPriceCalculate(List cartList1){


    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
       subTotal=(subTotal+oneItemPrice);
    }

    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);

      double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
      totalTax=(totalTax+singleProductTax);
    }

    totalPrice(subTotal+totalTax);


  }

  void totalSellerCountCalculate(List cartList){
    var seen = Set<String>();
    List  uniqueList = cartList.where((student) => seen.add(student.seller)).toList();
    sellerGroupList(uniqueList);
    //_showToast("remove="+uniqueList.length.toString());
  }

  couponCodeCheck({
    required String token,
    required String couponCode,
    required var couponInfoJson
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var headers = {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          };
          var request = http.Request('POST', Uri.parse(
              // "$BASE_URL_API$SUB_URL_API_COUPON_CODE_CHECK"
              'http://192.168.0.115/bijoytech_ecomerce/api/reset-otp-check'
          ));
          request.body = json.encode({
            "coupon_code": couponCode,
            "coupon_info":

            [
              {
                "seller_id": 2,
                "buyed_amount": 100
              },
              {
                "seller_id": 2,
                "buyed_amount": 100
              }
            ]
          });
          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();

          _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            print(await response.stream.bytesToString());
          }
          else {
            print(response.reasonPhrase);
          }


        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
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

  ///user info with share pref
  void saveUserInfo({required String userName,required String userToken,}) async {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, userName);
      storage.write(pref_user_token, userToken);
    } catch (e) {
      //code
    }
  }



  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));

  //  _showToast(storage.read(pref_user_token).toString());

    } catch (e) {

    }

  }

}