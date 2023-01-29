
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import 'package:http/http.dart' as http;

class ImageFullViewPageController extends GetxController {


  var imageLink="".obs;


  dynamic argumentData = Get.arguments;

  @override
  void onInit() {

    imageLink(argumentData[0]['imageLink'].toString());

    //_showToast(imageLink.toString());

    super.onInit();

  }



}



