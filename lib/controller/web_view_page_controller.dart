
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../static/Colors.dart';

class WebViewPageController extends GetxController {

   var webLink="".obs;
  // var webLink="https://fnfbuy.bizoytech.com/api/payment-api?surname=ripon&email=ripon@gmail.com&mobile=01732628761&amount=2".obs;

  dynamic argumentData = Get.arguments;

  @override
  void onInit() {

     _showToast("link= "+argumentData[6]['paymentLink'].toString());
    // zipCode(argumentData[1]['zipCode'].toString());
    // surName(argumentData[2]['surName'].toString());
    // mobileNumber(argumentData[3]['mobileNumber'].toString());
    // totalAmountWithTax(argumentData[4]['totalAmountWithTax'].toString());
   // webLink(argumentData[6]['emailAddress'].toString());
    super.onInit();
  }
  WebViewController webController(String webLin){
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {


            final uri = Uri.parse(url);

            // print(Uri.base.toString()); // http://localhost:8082/game.html?id=15&randomNumber=3.14
            // print(Uri.base.query);  // id=15&randomNumber=3.14
            // print(Uri.base.queryParameters['randomNumber']); // 3.14

            // Fluttertoast.showToast(
            //     msg: url,
            //     toastLength: Toast.LENGTH_LONG,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0
            // );

            // Fluttertoast.showToast(
            //     msg: uri.queryParameters['paymentId'].toString(),
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0
            // );
            // Fluttertoast.showToast(
            //     msg: uri.queryParameters['PayerID'].toString(),
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0
            // );



            if(uri.queryParameters['paymentId'].toString()!="null" ){
              _showToast("payment Success full!");
            }


            else{
              _showToast("else");

            }

          },
          onPageFinished: (String url) {
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(Get.arguments[6]['paymentLink'])) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(Get.arguments[6]['paymentLink']));

  }


   //toast create
   _showToast(String message) {
     Fluttertoast.showToast(
         msg: message,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor:Colors.amber,
         textColor: Colors.white,
         fontSize: 16.0);
   }


}