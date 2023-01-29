import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controller/drawer_controller/about_us_controller.dart';
import '../../static/Colors.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';

class AboutUsPage extends StatelessWidget {

final aboutUsController = Get.put(AboutUsController());

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
                    "ABOUT US",
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
                                  Obx(() =>   Text(
                                    aboutUsController.aboutUsDataTitle.value,
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
                              Obx(() =>Text(
                                aboutUsController.aboutUsDataText.value,
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

