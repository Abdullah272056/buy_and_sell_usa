
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/notes_database.dart';

class SearchPageController extends GetxController {
  final searchController = TextEditingController().obs;

   var productNameDataList=[].obs;
  var sellerNameDataList=[].obs;
  var userName="".obs;
  var userToken="".obs;
  @override
  void onInit() {
    super.onInit();
    loadUserIdFromSharePref();
  }
  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));

      //  _showToast("token g= "+storage.read(pref_user_token).toString());

    } catch (e) {

    }

  }

  void getSearchSuggestDataList(String searchKey) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          var response = await post(
              Uri.parse('${BASE_URL_API}${SUB_URL_API_SEARCH_SEGGEST}'),
              body: {
                "search":searchKey
              }
          );
         // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);

            productNameDataList(dataResponse["data"]["product"]);
            sellerNameDataList(dataResponse["data"]["seller"]);

          //  _showToast(productNameDataList.length.toString());


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