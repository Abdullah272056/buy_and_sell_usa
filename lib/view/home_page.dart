import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/shop_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/dash_board_page_controller.dart';
import 'background.dart';
import 'dash_board_page.dart';
import 'home_page1.dart';


class HomePage extends StatelessWidget {

  // final examPageController = Get.put(HomePage());
  // final examPageController = Get.put(ExamPageController());
  // String _userName="",_fullName="",_userBatch="",_userType="",_userId="";
  // final GlobalKey<ScaffoldState> _key = GlobalKey();
  // final dashBoardPageController = Get.put(DashBoardPageController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        // backgroundColor: Colors.backGroundColor,
        // key: _key,

        body:Center(
          child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 100,
                    child:  InkWell(
                      child: Text("click"),
                      onTap: (){




                        // DashBoardPageController().selectedTabIndex(1);
                        // DashBoardPageController().cl
                        bool test = Get.isRegistered<DashBoardPageController>();
                        if(test){
                          Get.delete<DashBoardPageController>();

                        }

                          Get.to(() => DashBoardPageScreen(), arguments: [
                            {"first": '1'},
                            {"second": 'ShopPage'}
                          ])?.then((value) => Get.delete<DashBoardPageController>());






                        // _showToast("");
                      },

                    ),
                  ),

                  Text(
                      "Home page"
                  )
                ],
              )


          ),
        ),

      ),
    );
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
