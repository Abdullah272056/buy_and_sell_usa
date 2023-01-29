
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../model/CategoriesData.dart';
import '../../static/Colors.dart';
import '../../view/common/loading_dialog.dart';
import '../../view/common/toast.dart';

class AboutUsController extends GetxController {

  var userName="".obs;
  var userToken="".obs;
  var aboutUsDataText="".obs;
  var aboutUsDataTitle="".obs;
  @override
  void onInit() {
    super.onInit();
    loadUserIdFromSharePref();
    retriveUserInfo();
    getAboutUsyData();
  }



  ///get data api call
  void getAboutUsyData() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          showLoadingDialog("Loading...");
          var response = await get(
              Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ABOUT_US}'),
          );
          // _showToast("status = ${response.statusCode}");
           Get.back();
          if (response.statusCode == 200) {
            var responseData = jsonDecode(response.body);

            aboutUsDataText(responseData["data"]["description"]);
            aboutUsDataTitle(responseData["data"]["title"]);
           // _showToast(categoriesList.length.toString());
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





  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));
     // _showToast("qwer "+userToken.toString());
    } catch (e) {

    }

  }

  ///get user data from share pref
  void retriveUserInfo() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name).toString());
      userToken(storage.read(pref_user_token).toString());
    //  _showToast("Tokenqw = "+storage.read(pref_user_token).toString());
    }catch(e){

    }

  }

}