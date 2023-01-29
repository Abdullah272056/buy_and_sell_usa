
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
import '../../view/common/toast.dart';

class SubCategoriesPageController extends GetxController {



  var categoriesDataList=[].obs;
  var categoriesShimmerStatus=1.obs;
  dynamic argumentData = Get.arguments;

  var categoryId="".obs;
  var categoryName="".obs;
  var categoryImage="".obs;
  var userToken="".obs;


  @override
  void onInit() {
    super.onInit();

    categoryId(argumentData[0]['categoriesId']);
    categoryName(argumentData[1]['categoriesName']);
    categoryImage(argumentData[2]['categoriesImage']);
    loadUserIdFromSharePref();
    getCategoriesDataList(argumentData[0]['categoriesId'].toString());

  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();

      userToken(storage.read(pref_user_token));

    } catch (e) {

    }

  }




  void getCategoriesDataList(String categoriesId) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          categoriesShimmerStatus(1);
          var response = await post(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_CATEGORIES_DETAILS}'),
            body: {
              "category_id":categoriesId
            }
          );
          //  _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

             categoriesShimmerStatus(0);
             var homeDataResponse = jsonDecode(response.body);
             categoriesDataList(homeDataResponse["data"]["sub_categories"]);


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