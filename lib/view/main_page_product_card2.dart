
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fnf_buy/static/Colors.dart';


class HomeScreenProductCard2 extends StatefulWidget {
  const HomeScreenProductCard2(
      {Key? key,
        //required this.product,
        required this.isCurrentInView})
      : super(key: key);

  //final Product product;
  final bool isCurrentInView;

  @override
  _HomeScreenProductCardState createState() => _HomeScreenProductCardState();
}

class _HomeScreenProductCardState extends State<HomeScreenProductCard2> with SingleTickerProviderStateMixin {
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
    double width = MediaQuery.of(context).size.width;
    return Container(
      width:width/2 ,
      height:width/1.3 ,
      color: Colors.white,
      child:  Column(

        // alignment: Alignment.bottomCenter,
        children: [



          Padding(
            padding: EdgeInsets.all(20),
            child:  GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(
                //   ProductPage.id,
                //   arguments: widget.product,
                // );
              },
              child: Container(
                decoration: BoxDecoration(
                    color:Colors.white,
                    boxShadow: [
                      widget.isCurrentInView
                          ? BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 8),
                          spreadRadius: 1,
                          blurRadius: 8)
                          : const BoxShadow(
                        color: Colors.transparent,
                        offset: Offset(0, 8),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(24)),
                // margin: const EdgeInsets.only(
                //     left: 25, right: 25, top: 24, bottom: 32),
                child: Stack(
                  children: [
                    AspectRatio(
                        aspectRatio: 0.9,
                        child:Padding(
                          padding: EdgeInsets.all(16),
                          child: Image.asset(
                              "assets/images/shirt.png"
                          ),
                        )
                    ),
                    Positioned(
                      right: 12,
                      top: 12,
                      child: SizedBox(
                          height: _imageAnimationController.value * 27,
                          width: _imageAnimationController.value * 27,
                          child: IconButton(
                            icon:
                            Icon(Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {

                              });
                            },
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text("Formal Shirt",
                      style: TextStyle(fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey
                      ),

                    ),

                  ),
                  Text("\$99.0",
                    style: TextStyle(fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: fnf_color
                    ),

                  ),
                  // 12.widthBox,
                  // RatingWidget(rating: widget.product.rating),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:  Text("Men Grey Classic Regular Fit Formal Shirt",
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                      softWrap: false,
                      maxLines: 2,

                    ),
                  ),
                  // 12.widthBox,
                  // RatingWidget(rating: widget.product.rating),
                ],
              ),

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
                            color:fnf_color,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "(4.5)",
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

            ],
          ),



          // Container(
          //   height: width/3+(width/10),
          //   decoration: BoxDecoration(
          //     // color: Colors.deepOrangeAccent.withOpacity(0.5),
          //     // color: Colors.limeAccent,
          //       boxShadow: [
          //         widget.isCurrentInView
          //             ? BoxShadow(
          //             color: Colors.grey.shade200,
          //             offset: const Offset(0, 8),
          //             spreadRadius: 1,
          //             blurRadius: 8)
          //             : const BoxShadow(
          //           color: Colors.transparent,
          //           offset: Offset(0, 8),
          //         ),
          //       ],
          //       borderRadius: BorderRadius.circular(24)),
          //   // margin: const EdgeInsets.only(
          //   //     left: 25, right: 25, top: 24, bottom: 32),
          //   child: Stack(
          //     children: [
          //       ClipRRect(
          //         borderRadius: BorderRadius.circular(24), // Image border
          //         child: FadeInImage.assetNetwork(
          //           height: double.maxFinite,
          //           width: double.maxFinite,
          //           fit: BoxFit.cover,
          //           placeholder: 'assets/images/loading.png',
          //           image: "https://mcdn.wallpapersafari.com/medium/84/90/nK5Q1N.jpg",
          //           imageErrorBuilder: (context, url, error) =>
          //               Image.asset(
          //                 'assets/images/loading.png',
          //                 fit: BoxFit.cover,
          //               ),
          //         ),
          //
          //
          //         // Image.network(
          //         //   "https://static-01.daraz.com.bd/p/4413a589b32a52231b7854c8c0633040.jpg",
          //         //   fit: BoxFit.fill,
          //         //   // widget.product.productImages[0],
          //         // )
          //       ),
          //       Positioned(
          //         right: 12,
          //         top: 12,
          //         child: SizedBox(
          //           height: _imageAnimationController.value * 27,
          //           width: _imageAnimationController.value * 27,
          //           child: IconButton(
          //             icon:
          //             Icon(Icons.favorite,
          //               color: Colors.red,
          //             ),
          //             onPressed: () {
          //               setState(() {
          //
          //               });
          //             },
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),


        ],
      ),
    );
  }














  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     alignment: Alignment.bottomCenter,
  //     children: [
  //       Container(
  //           padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
  //           margin:
  //           const EdgeInsets.only(top: 110, left: 8, right: 8, bottom: 16),
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //               boxShadow: [
  //                 BoxShadow(
  //                     color: Colors.grey.withOpacity(0.12),
  //                     offset: const Offset(0, 12),
  //                     spreadRadius: 1,
  //                     blurRadius: 24),
  //               ]),
  //           child: Container(
  //             width: double.infinity,
  //           )),
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           // const Spacer(),
  //           Flexible(
  //               flex: 6,
  //               child:
  //               GestureDetector(
  //                 onTap: () {
  //
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     // color: Colors.deepOrangeAccent.withOpacity(0.5),
  //                     // color: Colors.limeAccent,
  //                       boxShadow: [
  //                         widget.isCurrentInView
  //                             ? BoxShadow(
  //                             color: Colors.grey.shade200,
  //                             offset: const Offset(0, 8),
  //                             spreadRadius: 1,
  //                             blurRadius: 8)
  //                             : const BoxShadow(
  //                           color: Colors.transparent,
  //                           offset: Offset(0, 8),
  //                         ),
  //                       ],
  //                       borderRadius: BorderRadius.circular(24)),
  //                   // margin: const EdgeInsets.only(
  //                   //     left: 25, right: 25, top: 24, bottom: 32),
  //                   child: Stack(
  //                     children: [
  //                       ClipRRect(
  //                         borderRadius: BorderRadius.circular(24), // Image border
  //                         child: FadeInImage.assetNetwork(
  //                           // height: double.maxFinite,
  //                           // width: double.maxFinite,
  //                           fit: BoxFit.cover,
  //                           placeholder: 'assets/images/loading.png',
  //                           image: "https://mcdn.wallpapersafari.com/medium/84/90/nK5Q1N.jpg",
  //                           imageErrorBuilder: (context, url, error) =>
  //                               Image.asset(
  //                                 'assets/images/loading.png',
  //                                 fit: BoxFit.cover,
  //                               ),
  //                         ),
  //
  //
  //                         // Image.network(
  //                         //   "https://static-01.daraz.com.bd/p/4413a589b32a52231b7854c8c0633040.jpg",
  //                         //   fit: BoxFit.fill,
  //                         //   // widget.product.productImages[0],
  //                         // )
  //                       ),
  //                       Positioned(
  //                         right: 12,
  //                         top: 12,
  //                         child: SizedBox(
  //                           height: _imageAnimationController.value * 27,
  //                           width: _imageAnimationController.value * 27,
  //                           child: IconButton(
  //                             icon:
  //                             Icon(Icons.favorite,
  //                               color: Colors.red,
  //                             ),
  //                             onPressed: () {
  //                               setState(() {
  //
  //                               });
  //                             },
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               )
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(left:24, right:24,top:24,bottom: 28),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Expanded(
  //                       child: Text("Formal Shirt",
  //                         style: TextStyle(fontSize: 15,
  //                             fontWeight: FontWeight.w500,
  //                             color: Colors.grey
  //                         ),
  //
  //                       ),
  //
  //                     ),
  //                     Text("\$99.0",
  //                       style: TextStyle(fontSize: 17,
  //                           fontWeight: FontWeight.w800,
  //                           color: fnf_color
  //                       ),
  //
  //                     ),
  //                     // 12.widthBox,
  //                     // RatingWidget(rating: widget.product.rating),
  //                   ],
  //                 ),
  //                 SizedBox(height: 5,),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Expanded(
  //                       child:  Text("Men Grey Classic Regular Fit Formal Shirt",
  //                         overflow: TextOverflow.ellipsis,
  //                         style:  TextStyle(
  //                             color: Colors.black.withOpacity(0.7),
  //                             fontSize: 17,
  //                             fontWeight: FontWeight.w700),
  //                         softWrap: false,
  //                         maxLines: 2,
  //
  //                       ),
  //                     ),
  //                     // 12.widthBox,
  //                     // RatingWidget(rating: widget.product.rating),
  //                   ],
  //                 ),
  //                 // Row(
  //                 //   crossAxisAlignment: CrossAxisAlignment.center,
  //                 //   children: [
  //                 //     Column(
  //                 //       crossAxisAlignment: CrossAxisAlignment.start,
  //                 //       children: [
  //                 //         Row(
  //                 //           children: [
  //                 //             Container(color: Colors.lime,)
  //                 //           ],
  //                 //         ),
  //                 //
  //                 //         // Text("Men Grey Classic Regular Fit Formal Shirt",
  //                 //         //   overflow: TextOverflow.ellipsis,
  //                 //         //   style:  TextStyle(
  //                 //         //       color: Colors.black.withOpacity(0.7),
  //                 //         //       fontSize: 17,
  //                 //         //       fontWeight: FontWeight.w700),
  //                 //         //   softWrap: false,
  //                 //         //   maxLines: 1,
  //                 //         // // style: TextStyle(fontSize: 17,
  //                 //         // // fontWeight: FontWeight.w700,
  //                 //         // //   color: Colors.black.withOpacity(0.7)
  //                 //         // // ),
  //                 //         //
  //                 //         // ),
  //                 //         Text("\$99.0",
  //                 //         style: TextStyle(fontSize: 15,
  //                 //         fontWeight: FontWeight.w700,
  //                 //           color: Colors.grey
  //                 //         ),
  //                 //
  //                 //         ),
  //                 //
  //                 //       ],
  //                 //     ),
  //                 //     const Spacer(),
  //                 //     SizedBox(
  //                 //       height: _imageAnimationController.value * 30,
  //                 //       width: _imageAnimationController.value * 30,
  //                 //       child: Container()
  //                 //
  //                 //       // RoundedAddButton(
  //                 //       //   onPressed: () {},
  //                 //       // ),
  //                 //     )
  //                 //   ],
  //                 // ),
  //                 SizedBox(height: 3,),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Wrap(
  //                         children: [
  //                           RatingBarIndicator(
  //                             // rating:response["avg_rating"],
  //                             rating:double.parse("4.5"),
  //                             itemBuilder: (context, index) => const Icon(
  //                               Icons.star,
  //                               color:fnf_color,
  //                             ),
  //                             itemCount: 5,
  //                             itemSize: 15.0,
  //                             direction: Axis.horizontal,
  //                           ),
  //                           const SizedBox(
  //                             width: 4,
  //                           ),
  //                           Text(
  //                             "(4.5)",
  //                             style: const TextStyle(
  //                               fontSize: 12,
  //                               color:hint_color,
  //                               fontWeight: FontWeight.normal,
  //                             ),
  //                             maxLines: 2,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //
  //               ],
  //             ),
  //           )
  //
  //         ],
  //       )
  //     ],
  //   );
  // }
}
