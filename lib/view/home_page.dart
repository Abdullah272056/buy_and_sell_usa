import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/category_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/dash_board_page_controller.dart';
import '../static/Colors.dart';
import 'background.dart';
import 'dash_board_page.dart';
import 'home_page1.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        // backgroundColor: Colors.backGroundColor,
        // key: _key,

        body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Expanded(child:  GridView.builder(
               itemCount:10,
               // shrinkWrap: true,
               // physics: const ClampingScrollPhysics(),
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 10.0,
                   mainAxisSpacing: 10.0,
                   mainAxisExtent: 250
               ),
               itemBuilder: (BuildContext context, int index) {
                 return  productCardDesign(height: 00, width: MediaQuery.of(context).size.width);
               }),)

          ],
        )

      ),
    );
  }

  //user name input field create
  Widget productCardDesign({
    required double height,
    required double width,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Container(
          width:width/2 ,
          // height:width/1.3
          padding: EdgeInsets.only(left: 10,right: 10),
          // color: Colors.white,
          child:  Column(

            // alignment: Alignment.bottomCenter,
            children: [



              Container(
                decoration: BoxDecoration(
                  // color:Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Stack(
                  children: [
                    AspectRatio(
                        aspectRatio: 1,
                        child:Padding(
                          padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                          // padding: EdgeInsets.all(16),
                          child: Image.asset(
                              "assets/images/shirt.png"
                          ),
                        )
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.favorite_outline,
                          color: hint_color,
                        ),

                      ),
                    )
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  Text("Men Grey Classic Regular Fit Formal Shirt",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          softWrap: false,
                          maxLines: 1,

                        ),
                      ),
                      // 12.widthBox,
                      // RatingWidget(rating: widget.product.rating),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          children: [
                            RatingBarIndicator(
                              // rating:response["avg_rating"],
                              rating:double.parse("4.5"),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color:Colors.orange,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              " 8 Review",
                              style: const TextStyle(
                                fontSize: 12,
                                color:hint_color,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  Text("\$ 99.00",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                          softWrap: false,
                          maxLines: 2,

                        ),
                      ),
                      // 12.widthBox,
                      // RatingWidget(rating: widget.product.rating),
                    ],
                  ),



                ],
              ),






            ],
          ),
        )
      ],
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
