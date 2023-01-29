import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../static/Colors.dart';

Widget buildProductItemShimmer({
  required double height,
  required double width,
}) {
  return  Container(
    width:width/2 ,
    // height:width/1.3
  //  padding: EdgeInsets.only(left: 10,right: 10),
    //  margin: EdgeInsets.only(left: 10,right: 10),
    // color: Colors.white,
    child:  Column(
      // alignment: Alignment.bottomCenter,
      children: [
        Expanded(child: Shimmer.fromColors(
          baseColor: shimmer_baseColor ,
          highlightColor: shimmer_highlightColor ,
          child:Container(
            margin: const EdgeInsets.only(right: 0.0,left: 0,bottom: 0),
            decoration: BoxDecoration(
              color: shimmer_baseColor ,
            ),
            height: double.infinity,
            width: double.infinity,


          ),
        ),),

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 7,),
            Shimmer.fromColors(
              baseColor: shimmer_baseColor ,
              highlightColor: shimmer_highlightColor ,
              child:Container(
                margin: const EdgeInsets.only(right: 0.0,left: 0,bottom: 0),
                decoration: BoxDecoration(
                  color: shimmer_baseColor ,
                ),
                height: 20,
                width: double.infinity,


              ),
            ),
            SizedBox(height: 5,),
            Shimmer.fromColors(
              baseColor: shimmer_baseColor ,
              highlightColor: shimmer_highlightColor ,
              child:Container(
                margin: const EdgeInsets.only(right: 0.0,left: 0,bottom: 0),
                decoration: BoxDecoration(
                  color: shimmer_baseColor ,
                ),
                height: 15,
                width: double.infinity,


              ),
            ),
            SizedBox(height: 5,),
            Shimmer.fromColors(
              baseColor: shimmer_baseColor ,
              highlightColor: shimmer_highlightColor ,
              child:Container(

                margin: const EdgeInsets.only(right: 35.0,left: 0,bottom: 0),
                decoration: BoxDecoration(
                  color: shimmer_baseColor ,
                ),
                height: 15,
                width: double.infinity,


              ),
            ),



          ],
        ),

      ],
    ),
  );
}

Widget buildRectangleShimmer({
          required double height,
          required double width,
          required double marginLeft,
          required double marginTop,
          required double marginRight,
          required double marginBottom,
    }){
  return Shimmer.fromColors(
    baseColor: shimmer_baseColor ,
    highlightColor: shimmer_highlightColor ,
    child:Container(
      margin:  EdgeInsets.only(
          right: marginRight,
          left: marginLeft,
          bottom: marginBottom,
          top:marginTop
      ),
      decoration: const BoxDecoration(
        color: shimmer_baseColor ,
      ),
      height: height,
      width: width,

    ),
  );
}