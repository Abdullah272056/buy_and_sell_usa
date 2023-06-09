import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../view/dash_board/home_page.dart';

class DashBoardPageController extends GetxController {
  var selectedTabIndex = 0.obs;
  var selectedPageIndex = 1.obs;

  var selectedPage = <Widget>[HomePageScreen()].obs;

  var userName="".obs;
  var userToken="".obs;
  var prefUserType="".obs;

  void ref() {
    onInit();
  }

  @override
  void onInit() {


    loadUserIdFromSharePref();
    super.onInit();



   // _showToast(prefUserType.value);

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


  updateSelectedTabIndex(int index) {
    selectedTabIndex(index);
  }

  updateSelectedPage(List<Widget> page) {
    selectedPage(page);
  }

// Widget
  void onItemTapped(int index) {
    selectedTabIndex(index);
    // _selectedPageIndex = index;
    if (index == 0) {
      // selectedPage(HomePage( ));
      return;
    }

    if (index == 1) {
      //  selectedPage(HomePage( ));
      // selectedPage= ShopPage( );
      return;
    }

    if (index == 2) {
      // selectedPage= AccountPage( );
      return;
    }

    if (index == 3) {
      // selectedPage= CartPage( );
      return;
    }

    if (index == 4) {
      // selectedPage= SearchPage( );
      return;
    }
  }


  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));
      prefUserType(storage.read(pref_user_type));


    } catch (e) {

    }

  }

}
