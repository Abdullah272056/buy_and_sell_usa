import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../controller/dash_board_controller/dash_board_page_controller.dart';

import '../../static/Colors.dart';

import '../dash_board/dash_board_page.dart';



class TrackingWebViewScreen extends StatefulWidget {



  @override
  State<TrackingWebViewScreen> createState() => _WebViewPaymentScreenState(


  );
}

class _WebViewPaymentScreenState extends State<TrackingWebViewScreen>{



  // final cartViewPageController = Get.put(WebViewPageController1());

  // String paymentLink="https://fnfbuy.bizoytech.com/tracking-api";
 // String paymentLink="https://fnfbuy.bizoytech.com/tracking-api";

  String trackingLink1="https://www.trackingmore.com/track/en/9461209205568292657642";
  String trackingLink="https://fnfbuy.bizoytech.com/tracking-api";


  @override
  @protected
  @mustCallSuper
  void initState() {

  //  _showToast("pataq= "+couponDataList.length.toString());

   // _showToast("1"); //
   // _showToast("2");
  }
  final _key = UniqueKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: fnf_title_bar_bg_color,
      body:Container(
        child: Column(
          children: [

            SizedBox(
              height: MediaQuery.of(context).size.height / 25,
              // height: 50,
            ),

            Flex(direction: Axis.horizontal,
              children: [
                SizedBox(width: 5,),
                IconButton(
                  iconSize: 20,
                  icon:Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(width: 5,),
                Expanded(child: Text(
                  "TRACKING",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),
                )),

                Container(
                  margin: EdgeInsets.only(top: 0,right: 15),
                  child: InkWell(
                      onTap: (){
                        Get.deleteAll();
                        Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());
                      },
                      child: Icon(
                        Icons.home_outlined,
                        size: 25,
                        color: Colors.white,
                      )
                  ),
                ),


                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: InkWell(

                    onTap: () {
                      // if(cartViewPageController.userToken.isNotEmpty &&
                      //     cartViewPageController.userToken.value!="null"&&
                      //     cartViewPageController.userToken.value!=null){
                      //   // _showToast(homeController.userToken.toString());
                      //   //  _showToast("add favourite");
                      //   Get.to(WishListPage())?.then((value) => Get.delete<WishListPageController>());
                      // }else{
                      //   showLoginWarning();
                      // }

                    },
                    child:  Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),


              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 125,
              // height: 50,
            ),



            Expanded(child:   Container(
              decoration: BoxDecoration(
                color:Colors.white,
              ),
              child:InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse("https://fnfbuy.bizoytech.com/tracking-api")),
                initialOptions: InAppWebViewGroupOptions(
                    android: AndroidInAppWebViewOptions(
                        mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW
                    )
                ),
              ),


              // WebView(
              //     key: _key,
              //     javascriptMode: JavascriptMode.unrestricted,
              //     navigationDelegate: (NavigationRequest request) {
              //
              //
              //       //Any other url works
              //       return NavigationDecision.navigate;
              //     },
              //     onPageFinished: (url){
              //
              //     },
              //     onPageStarted: (url){
              //
              //     },
              //     initialUrl: trackingLink),

              /* add child content here */
            ),)
          ],
        ),
      )
      
      
    
    );


  }


}
