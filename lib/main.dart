
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/auth/vendor_or_seller/vendor_log_in_page.dart';
import 'package:fnf_buy/view/auth/vendor_or_seller/vendor_sign_up_page.dart';
import 'package:fnf_buy/view/cart/cart_page.dart';
import 'package:fnf_buy/view/dash_board/dash_board_page.dart';
import 'package:fnf_buy/view/dash_board/tracking_webview_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {

  await GetStorage.init();
  runApp( MyApp());
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   // statusBarColor:awsStartColor,
  //   // systemNavigationBarColor:awsEndColor,
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
      // color: Colors.lime,
      // debugShowCheckedModeBanner: false,
 
       home: DashBoardPageScreen()
 
     // home: VendorLogInScreen()
     // VendorSignUpScreen(),
     // CartPage(),
    );

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed: $state");
    if (state == AppLifecycleState.resumed) {
    //_showToast("resumed");
    }
  }



}