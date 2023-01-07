
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../static/Colors.dart';

class WebViewPageController extends GetxController {

  // var webLink="".obs;
  var webLink="https://fnfbuy.bizoytech.com/payment-api?surname=ripon&email=ripon@gmail.com&mobile=01732628761&amount=2".obs;


  WebViewController webController(String webLink){
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

            Fluttertoast.showToast(
                msg: url,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

            Fluttertoast.showToast(
                msg: uri.queryParameters['paymentId'].toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Fluttertoast.showToast(
                msg: uri.queryParameters['PayerID'].toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

          },
          onPageFinished: (String url) {
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith("https://www.youtube.com/")) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(webLink));

  }



}