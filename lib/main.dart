
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/auth/log_in_page.dart';
import 'package:fnf_buy/view/dash_board/cart_page.dart';
import 'package:fnf_buy/view/dash_board/checkout%20step/checkout_page.dart';
import 'package:fnf_buy/view/dash_board/checkout%20step/web_view_page.dart';
import 'package:fnf_buy/view/dash_board/profile_section/order_details_page.dart';
import 'package:fnf_buy/view/dash_board/profile_section/order_page.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/dash_board_page_controller.dart';

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
       // body:CheckoutPageStep2Page(),
       body: LogInScreen(),

      // body:CheckoutPageStep2Page(),


      ),
    );


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {

    //_showToast("resumed");

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