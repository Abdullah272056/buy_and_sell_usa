import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../api_service/api_service.dart';
import '../model/CategoriesData.dart';
import '../static/Colors.dart';

class CustomDrawerController extends GetxController {
  var drawerSelectedTab = 1.obs;
  var categoriesList=[].obs;

  @override
  void onInit() {
    super.onInit();

    getCategories();

  }

  updateUserNameLevelTextColor(int value) {
    drawerSelectedTab(value);
  }


  ///categories api call

  void getCategories() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
              Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_CATEGORIES}'),
          );
          _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var data = response.body;
            CategoriesData categoriesDataAllListModel= categoriesDataFromJson(data);

            categoriesList(categoriesDataAllListModel.data);
            _showToast(categoriesList.length.toString());
          }
          else {
            // Fluttertoast.cancel();
            log('data:'+response.body.toString());
            _showToast("failed try again!");
          }
        } catch (e) {
          _showToast("AA");
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
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: fnf_color,
        fontSize: 16.0);
  }


}