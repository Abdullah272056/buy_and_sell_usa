import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/dash_board_page_controller.dart';
import '../controller/home_controller.dart';
import 'background.dart';
import 'home_page1.dart';


class HomePage22 extends StatelessWidget {

  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body:Center(
          child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 100,
                    child:  InkWell(
                      child: Obx(() => Text(homeController.abcd.value),),


                      onTap: (){
                        Get.back();
                      //  Get.to(HomePage());
                        // _showToast("");
                      },

                    ),
                  ),

                  Text(
                      "Home page1"
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
