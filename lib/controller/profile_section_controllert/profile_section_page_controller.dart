
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

class ProfileSectionPageController extends GetxController {
  TextEditingController? searchController = TextEditingController();

  var homeDataList=[].obs;
  var categoriesDataList=[].obs;
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
}