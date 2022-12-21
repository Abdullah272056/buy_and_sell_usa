


import 'package:card_swiper/card_swiper.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/static/Colors.dart';
import 'package:fnf_buy/view/custom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controller/home_controller.dart';
import 'controller/product_details_controller.dart';


class ProductDetailsePageScreen extends StatelessWidget {
  // HomePageScreen({Key? key}) : super(key: key);

  final homeController = Get.put(ProductDetailsController());
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey();

  //   @override
  //   State<HomePageScreen> createState() =>
  //       _HomePageScreenState();
  // }
  //
  // class _HomePageScreenState
  //     extends State<HomePageScreen> {
  //
  //   final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey();
  //   @override
  //   @mustCallSuper
  //   void initState() {
  //     super.initState();
  //
  //
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color:fnf_title_bar_bg_color,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 22,
              // height: 50,
            ),
            Container(
             // height: 50,
              // color: fnf_title_bar_bg_color,//
              child: Flex(direction: Axis.horizontal,
                children: [
                  SizedBox(width: 5,),
                  IconButton(
                    iconSize: 22,
                    icon:Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // ...
                    },
                  ),
                  Expanded(child: Text(
                      "Product Details",
                    style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w500,
                      fontSize: 18
                    ),
                  ))
                ],
              ),
            ),


            Expanded(
                child: Container(
                  color: Colors.white,
                  child:  SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildBottomSectionDesign(),
                      ],
                    ),
                  ),
                )


            ),


          ],
        ),

        /* add child content here */
      ),
    );
  }




  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: fnf_color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildBottomSectionDesign() {
    double sizeHeight = Get.height;
    double sizeWidth = Get.width;
    // Size size = MediaQuery.of(context).size;
    // Size size = MediaQuery.of(context).size;
    return Container(
        width: sizeWidth,
        decoration:  BoxDecoration(
          color:Colors.white,
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(30.0),
          //   topRight: Radius.circular(30.0),
          // ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 00, top: 00, right: 00, bottom: 00),
            child: Column(
              children: [

                sliderSectionDesign(),

                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    children: [

                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Expanded(child: Text(
                            "Men Grey Classic Regular Fit Formal Shirt Grey solid formal shirt, has a button-down collar, long sleeves, button placket, straight hem, and 1 patch pocket",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: text_color,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                            softWrap: false,
                            maxLines: 2,
                          ),),

                         Container(
                           margin: EdgeInsets.only(left: 15),
                           child:  Column(
                             children: [
                               Text(
                                 "\$5000.0",
                                 overflow: TextOverflow.ellipsis,

                                 style:  TextStyle(
                                     color: hint_color,
                                     fontSize: 13,
                                     decoration: TextDecoration.lineThrough,
                                     fontWeight: FontWeight.normal),
                                 softWrap: false,
                                 maxLines: 1,
                               ),
                               SizedBox(height: 3,),

                               Text(
                                 "\$4500.0",                                overflow: TextOverflow.ellipsis,
                                 style:  TextStyle(
                                     color: fnf_color,
                                     fontSize: 17,
                                     fontWeight: FontWeight.w700),
                                 softWrap: false,
                                 maxLines: 1,
                               )
                             ],
                           ),
                         )


                        ],
                      ),

                      SizedBox(height: 10,),

                      Row(
                        children: [
                          Expanded(child: Text(
                            "1 review | 7orders | 0 wish",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: fnf_small_text_color,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            softWrap: false,
                            maxLines: 2,
                          ),),

                         Container(
                           margin: EdgeInsets.only(left: 15),
                           child:  RatingBarIndicator(
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
                         )


                        ],
                      ),

                      //color
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 27,
                      child: Row(
                        children: [
                          Text(
                            "Available Color: ",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: text_color,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                            softWrap: false,
                            maxLines: 2,
                          ),
                          Expanded(child: ListView.builder(
                            //  shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            //itemCount: offerDataList == null ? 0 : offerDataList.length,
                            itemCount:5,
                            itemBuilder: (context, index) {
                              return Container(margin: EdgeInsets.only(right: 5),
                                height: 27,
                                width:27,
                                decoration: BoxDecoration(
                                  color:color_demo,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),

                                  ),

                                ),

                              );

                            },
                            scrollDirection: Axis.horizontal,
                          ))


                        ],
                      ) ,
                      ),

                      //size
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 25,
                        child: Row(
                          children: [
                            Text(
                              "Available Size: ",
                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(
                                  color: text_color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 2,
                            ),
                            Expanded(child: ListView.builder(
                              //  shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              //itemCount: offerDataList == null ? 0 : offerDataList.length,
                              itemCount:5,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 5),
                                  height: 27,
                                  width:32,
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    border: Border.all(
                                      color: hint_color,
                                      width: .5, //                   <--- border width here
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),

                                    ),

                                  ),
                                  child:  Center(
                                    child: Text(
                                      "L",
                                      overflow: TextOverflow.ellipsis,
                                      style:  TextStyle(
                                          color: text_color,
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                      softWrap: false,
                                      maxLines: 2,
                                    ),
                                  ),
                                );

                              },
                              scrollDirection: Axis.horizontal,
                            ))


                          ],
                        ) ,
                      ),

                      _buildDescriptionDesign(),

                      GridView.builder(
                          itemCount:5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing:7.0,
                              mainAxisSpacing: 5.0,
                              mainAxisExtent: 250
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return  productCardItemDesign(height: 00, width: MediaQuery.of(context).size.width, index: index);
                          })

                    ],

                  ),
                )










              ],
            )));
  }

  //user name input field create
  Widget productCardItemDesign({
    required double height,
    required double width,
    required int index,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Container(
          width:width/2 ,
          // height:width/1.3
          // margin: EdgeInsets.only(left: 10,right: 10),
          margin: EdgeInsets.only(left: 5,right: 5),
          // color: Colors.white,
          child:  Column(
            // alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color:Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Stack(
                      children: [
                        AspectRatio(
                            aspectRatio: 1,
                            child:Padding(
                              // padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                                padding: EdgeInsets.only(left: 0,right: 0,top: 0),
                                // padding: EdgeInsets.all(16),
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.fill,
                                  placeholder: 'assets/images/loading.png',
                                  image:"https://fnfbuy.bizoytech.com/public/images/product/1669097419-637c67cbbabda.webp",
                                  // image:BASE_URL_API_IMAGE+
                                  //    allProductListPageController.filterProductList[index].coverImage??"",
                                  imageErrorBuilder: (context, url, error) =>
                                      Image.asset(
                                        'assets/images/loading.png',
                                        fit: BoxFit.fill,
                                      ),
                                )

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
              ),


              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  Text(
                          "Men Grey Classic Regular Fit Formal Shir",
                          //"Men Grey Classic Regular Fit Formal Shirt",
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
                        child:  Text("\$ "+"120.50",
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

  //description
  Widget _buildDescriptionDesign() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(

          margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Description",
              style: TextStyle(
                  color:text_color,

                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
                "Per consequat adolescens ex, cu nibh commune temporibus vim, ad sumo viris eloquentiam sed. Mea appareat omittantur eloquentiam ad, nam ei quas oportere democritum.",
              style: const TextStyle(
                  color:hint_color,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),

      ],
    );
  }

  Widget sliderSectionDesign() {
    return Container(
        height: Get.height * 0.5,
        child: Stack(
          children: [
            Swiper(
              itemCount: 3,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: (){
                    _showToast(index.toString());
                  },
                  child: _sliderCardDesign(),
                ) ;


              },
              autoplay: true,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.green)),
              // control: const SwiperControl(),
            ),

            Row(
              children: [

                Expanded(child:  Align(alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(children: [InkWell(
                        onTap: (){},
                        child: Container(
                          padding: EdgeInsets.all(7),
                          //  height: 36,
                          // width:36,
                          child: Center(
                            child: Text(
                              "10.0% OFF",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color:Colors.blue,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                            ),
                            boxShadow: [BoxShadow(

                              color:Colors.grey.withOpacity(.5),
                              //  blurRadius: 20.0, // soften the shadow
                              blurRadius:20, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset:Offset(
                                2.0, // Move to right 10  horizontally
                                1.0, // Move to bottom 10 Vertically
                              ),
                            )],
                          ),
                          /*decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),

                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.green, spreadRadius: 3),
                                    ],
                                  ),*/

                        ),
                      )],),

                    ],
                  ),
                ),),

                Expanded(child:  Align(alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10,right: 15),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            height: 36,
                            width:36,
                            child: Icon(

                              Icons.favorite_border,
                              size: 20,
                              color: Colors.red,
                            ),
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18.0),
                              ),
                              boxShadow: [BoxShadow(

                                color:Colors.grey.withOpacity(.5),
                                //  blurRadius: 20.0, // soften the shadow
                                blurRadius:.5, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset:Offset(
                                  0.0, // Move to right 10  horizontally
                                  1.0, // Move to bottom 10 Vertically
                                  // Move to bottom 10 Vertically
                                ),
                              )],
                            ),

                          ),
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 10,right: 15),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            height: 36,
                            width:36,
                            child: Icon(
                              Icons.share,
                              size: 20,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              color:Colors.blue,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18.0),
                              ),

                            ),
                            /*decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),

                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(color: Colors.green, spreadRadius: 3),
                                    ],
                                  ),*/

                          ),
                        ),
                      )


                    ],
                  ),
                ),)


              ],
            )
          ],
        ),
      );
  }

  Widget _sliderCardDesign() {
    // Size size = MediaQuery.of(context).size;
    double sizeHeight = Get.height;
    return Container(
     // margin: EdgeInsets.only(left: 20,right: 20),
      width: double.infinity,
      //height: sizeHeight * 0.25,

      child:FadeInImage.assetNetwork(
        fit: BoxFit.fill,
        placeholder: 'assets/images/loading.png',
        // image:"http://192.168.68.106/bijoytech_ecomerce/public/images/product/1669097419-637c67cbbabda.webp",
        image:"https://images.othoba.com/images/thumbs/0491586_mens-stylish-long-sleeve-print-shirt_300.jpeg",
        imageErrorBuilder: (context, url, error) =>
            Image.asset(
              'assets/images/loading.png',
              fit: BoxFit.fill,
            ),
      ) ,
    );
  }

  Widget categoriesListItemDesign({required var response}){
    return InkResponse(
      onTap: (){

        // Navigator.push(context,MaterialPageRoute(builder: (context)=>
        //     SendMoneyAmountPageScreen(
        //         response["id"].toString(),response["username"].toString()
        //     )));


      },
      child:  Container(
        margin: const EdgeInsets.only(right:00,top: 0,left: 0,bottom: 00),
        // height: 68,
        child: Padding(padding: const EdgeInsets.only(right:00,top: 0,left: 00,bottom: 0),
          child:  Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.5),
                child: Container(
                    height:50,
                    width: 50,
                    color:hint_color,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/loading.png',
                      image:
                      "https://cdn.vox-cdn.com/thumbor/UMnuubuFGIsw339rSvq3HtaoczQ=/0x0:2048x1280/2000x1333/filters:focal(1024x640:1025x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/22406771/Exbfpl2WgAAQkl8_resized.jpeg",
                      imageErrorBuilder: (context, url, error) =>
                          Image.asset(
                            'assets/images/loading.png',
                            fit: BoxFit.fill,
                          ),
                    )),
              ),

              Container(
                  margin:  const EdgeInsets.only(left: 0, right: 0,bottom: 00,top: 5),
                  child:  Text(
                    response,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:  TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

}
