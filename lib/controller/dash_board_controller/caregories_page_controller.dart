
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../api_service/api_service.dart';
import '../../data_base/sqflite/note.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../view/common/toast.dart';

class CategoriesPageController extends GetxController {



  var categoriesDataList=[].obs;
  var categoriesShimmerStatus=1.obs;
  @override
  void onInit() {

    getCategoriesDataList();
    super.onInit();
  }





  void getCategoriesDataList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          categoriesShimmerStatus(1);
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ONLY_CATEGORIES_LIST}'),
          );
          //   _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            categoriesShimmerStatus(0);
            var homeDataResponse = jsonDecode(response.body);
            categoriesDataList(homeDataResponse["data"]);


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



}