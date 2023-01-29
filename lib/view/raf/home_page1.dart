
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/dash_board_controller/home_controller.dart';



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


}
