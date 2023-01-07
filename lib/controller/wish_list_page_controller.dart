
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../data_base/note.dart';
import '../data_base/notes_database.dart';

class WishListPageController extends GetxController {
  var wishList=[].obs;
  var userName="".obs;
  var userToken="".obs;

  // dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);


    super.onInit();
    retriveUserInfo().then((_) {

      getWishList(userToken.value);

    });
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

  ///get user data from share pref
   retriveUserInfo() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name).toString());
      userToken(storage.read(pref_user_token).toString());

    }catch(e){

    }

  }


  void getWishList(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //  _showToast(token);
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_WIShLIST}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
          );
         // _showToast("get"+response.statusCode.toString());
          if (response.statusCode == 200) {
           var wishListResponse = jsonDecode(response.body);
           wishList(wishListResponse["data"]["data"]);

          // _showToast("size  "+wishList.length.toString());
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

  void deleteWishList({required String token,required String id}) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       // _showToast(token);
        try {
          var response = await delete(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_DELETE_WISHLIST}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
            body: {
              "id":id
            }
          );
         // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {
           getWishList(token);
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


}