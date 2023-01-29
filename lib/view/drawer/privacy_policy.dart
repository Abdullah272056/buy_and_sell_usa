import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/drawer_controller/privacy_policy_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';
import '../checkout step/checkout_page.dart';
import '../product/product_details.dart';



class PrivacyPolicyPage extends StatelessWidget {


  final privacyPolicyController = Get.put(PrivacyPolicyController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
            color:fnf_title_bar_bg_color,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
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
                    "PRIVACY POLICY",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )),


                ],
              ),
              SizedBox(
                height: 7
                // height: 50,
              ),
              Expanded(
                  child:Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: SingleChildScrollView(
                            child:Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Obx(() => Text(
                                      privacyPolicyController.privacyDataTitle.value,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:fnf_color,
                                          fontSize: 22,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w700),
                                    ))
                                  ],
                                ),
                                SizedBox(height: 10,),
                               Obx(() =>  Text(
                                 privacyPolicyController.privacyDataText.value,
                                 style: TextStyle(
                                     color:fnf_small_text_color,
                                     fontSize: 14,
                                     decoration: TextDecoration.none,
                                     fontWeight: FontWeight.normal),
                               ))
                              ],
                            )
                        ))

                      ],
                    )
                  )


              )
            ],
          )

      )
    );



  }


}

