

import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/profile_section_controllert/account_details_page_controller.dart';
 import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/checkout_step_controller/checkout_page_controller.dart';
import '../../controller/profile_section_controllert/image_full_view_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../../static/Colors.dart';




class ImageFullViewPage extends StatelessWidget {

  final imageFullViewPageController = Get.put(ImageFullViewPageController());
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width =MediaQuery.of(context).size.width;
    height =MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
            color:fnf_title_bar_bg_color,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [



              Expanded(child:Stack(
                children: [
                  Obx(() =>

                      Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(imageFullViewPageController.imageLink.value),
                          fit: BoxFit.cover
                      ) ,
                    ),
                  ),

                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 22,
                        // height: 50,
                      ),

                      Flex(direction: Axis.horizontal,
                        children: [

                          SizedBox(width: 10,),

                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Colors.black.withOpacity(.3),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child:IconButton(
                            iconSize: 20,
                            icon:Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),


                          SizedBox(width: 5,),

                        ],
                      ),
                    ],
                  )

                ],
              )),


            ],
          )

      )
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

