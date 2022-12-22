
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../static/Colors.dart';





class HomeScreenProductCard extends StatefulWidget {
  const HomeScreenProductCard(
      {Key? key})
      : super(key: key);


  @override
  _HomeScreenProductCardState createState() => _HomeScreenProductCardState();
}

class _HomeScreenProductCardState extends State<HomeScreenProductCard> with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimationController;

  @override
  void initState() {
    _imageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();

    _imageAnimationController.addListener(() {
      setState(() {});
    });
    _imageAnimationController.forward();
  }

  @override
  void dispose() {
    _imageAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        productCardDesign(height: 00, width: MediaQuery.of(context).size.width),

        // Container(height: 350,
        // child:  ProductPageView(),
        // )



      ],
    );
  }
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
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
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

class ProductPageView extends StatefulWidget {
  const ProductPageView({Key? key}) : super(key: key);

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}
class _ProductPageViewState extends State<ProductPageView> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Flexible(
      child:Column(
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
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
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
      ),


    );
  }
}