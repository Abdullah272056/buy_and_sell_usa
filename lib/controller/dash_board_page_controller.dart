import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/cart_page.dart';
import 'package:fnf_buy/view/More_page.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../view/account_page.dart';
import '../view/home_page.dart';
import '../view/home_page11.dart';
import '../view/category_page.dart';

class DashBoardPageController extends GetxController {
  // int tabIndex;
  // Widget selectedPageName;
  //
  //
  // DashBoardPageController(this.tabIndex, this.selectedPageName);

var selectedTabIndex=0.obs;
var selectedPageIndex=1.obs;

// var selectedPage=Container().obs;

// final Widget destination;
  var selectedPage = <Widget>[
    HomePageScreen()
].obs;

 // dynamic argumentData = Get.arguments;

@override
void onInit() {
  super.onInit();
  // if(argumentData!=null){
  //
  //   selectedTabIndex(3);
  //
  //   if(argumentData[0]['first']=="0"){
  //     selectedTabIndex(0);
  //     updateSelectedPage([CartPage()]);
  //   }
  //   if(argumentData[0]['first']=="1"){
  //     selectedTabIndex(1);
  //     updateSelectedPage([CartPage()]);
  //   }
  //
  //   if(argumentData[0]['first']=="2"){
  //     selectedTabIndex(2);
  //     updateSelectedPage([CartPage()]);
  //   }
  //   if(argumentData[0]['first']=="3"){
  //     selectedTabIndex(3);
  //     updateSelectedPage([CartPage()]);
  //   }
  //   if(argumentData[0]['first']=="4"){
  //     selectedTabIndex(4);
  //     updateSelectedPage([CartPage()]);
  //   }
  //
  //
  //
  //   // print(argumentData[0]['first']);
  //   // print(argumentData[1]['second']);
  //   _showToast("ok");
  //
  // }else{
  //
  //   _showToast("else");
  // }




  // var arg = Get.arguments;
  // if("${arg[0]}"!=null || "${arg[0]}"!=""){
  //   _showToast("${arg[0]}");
  //
  // }else
  //   {
  //
  //     _showToast("message");
  //   }

  //  updateSelectedPage([selectedPageName]);
  // selectedTabIndex(tabIndex);

  // loadUserIdFromSharePref();
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



updateSelectedTabIndex(int index){
  selectedTabIndex(index);

}

updateSelectedPage(List<Widget> page){
  selectedPage(page);
}
// Widget
void onItemTapped(int index) {

  selectedTabIndex(index) ;
  // _selectedPageIndex = index;
  if(index==0){
   // selectedPage(HomePage( ));
    return;
  }

  if(index==1){
  //  selectedPage(HomePage( ));
    // selectedPage= ShopPage( );
    return;
  }

  if(index==2){
    // selectedPage= AccountPage( );
    return;
  }

  if(index==3){
    // selectedPage= CartPage( );
    return;
  }

  if(index==4){
    // selectedPage= SearchPage( );
    return;
  }


}

}