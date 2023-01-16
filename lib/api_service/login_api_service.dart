import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/data_base/share_pref/sharePreferenceDataSaveName.dart';
import 'package:fnf_buy/static/Colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../controller/dash_board_controller/dash_board_page_controller.dart';
import '../controller/dash_board_controller/home_controller.dart';
import '../view/auth/log_in_page.dart';
import '../view/auth/sign_up_page.dart';
import '../view/dash_board/dash_board_page.dart';
import 'api_service.dart';

class LogInApiService {

  //login api call




 userLogIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Checking...");

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_LOG_IN'),

           body: {
            'email': email,
            'password': password,
          }
          );

        // _showToast(response.statusCode.toString());

          Get.back();
          if (response.statusCode == 200) {
            _showToast("success");

            var data = jsonDecode(response.body);
            saveUserInfo(
                userName: data["data"]["name"].toString(),
                userToken: data["data"]["token"].toString());

            Get.deleteAll();
            Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());

          }
          else if (response.statusCode == 401) {
            _showToast("User name or password not match!");
          }
          else {
            var data = jsonDecode(response.body);
           // _showToast(data['message']);
          }
       //   Get.back();

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
    // _showToast(userToken.toString());
    } catch (e) {
      //code
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

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: fnf_color,
        fontSize: 16.0);
  }


}
