
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/special_offers_screen.dart';
import 'package:fnf_buy/view/background.dart';
import 'package:fnf_buy/view/custom_drawer.dart';
import 'package:fnf_buy/view/dash_board_page.dart';
import 'package:fnf_buy/view/auth/email_verification.dart';
import 'package:fnf_buy/view/home_page11.dart';

import 'package:fnf_buy/view/main_page_product_card.dart';
import 'package:fnf_buy/view/auth/password_set_page.dart';
import 'package:fnf_buy/view/home_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'home_screen.dart';



void main() {
  GetStorage.init();
  runApp( MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
   // statusBarColor:awsStartColor,
   // systemNavigationBarColor:awsEndColor,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
      // color: Colors.lime,
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body:CustomDrawer(),
        // body: HomePageScreen(),
        // body:DashBoardPageScreen(),
      ),
    );


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
    //  _showToast("resumed");
    }
  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.white,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}