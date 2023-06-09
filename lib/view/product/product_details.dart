
import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/static/Colors.dart';

import 'package:fnf_buy/view/cart/cart_page.dart';
import 'package:get/get.dart';
import '../../api_service/api_service.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';

import '../checkout step/checkout_page.dart';
import '../common/login_warning.dart';
import '../common/toast.dart';
import '../dash_board/dash_board_page.dart';
import '../drawer/custom_drawer.dart';
import '../shimer/product_shimmir.dart';

class ProductDetailsePageScreen extends StatelessWidget {
  // HomePageScreen({Key? key}) : super(key: key);

  final productDetailsController = Get.put(ProductDetailsController());
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
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {

          productDetailsController.onInit();

          await Future.delayed(const Duration(seconds: 1));
          //updateDataAfterRefresh();
        },
        child:  Column(
          children: [

            Expanded(child:  Container(
              decoration: BoxDecoration(
                color:fnf_title_bar_bg_color,
              ),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                    // height: 50,
                  ),
                  Container(
                    // height: 50,
                    // color: fnf_title_bar_bg_color,//
                    child: Flex(direction: Axis.horizontal,
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
                          "Product Details",
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17
                          ),
                        )),


                        Container(
                          margin: EdgeInsets.only(top: 0,right: 10),
                          child: InkWell(
                              onTap: (){
                                Get.deleteAll();
                                Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());
                              },
                              child: Icon(
                                Icons.home,
                                size: 25,
                                color: Colors.white,
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          margin: EdgeInsets.only(top: 0,right: 10),
                          child: InkWell(
                              onTap: (){

                              },
                              child: Icon(

                                Icons.share_outlined,
                                size: 25,
                                color: Colors.white,
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          margin: EdgeInsets.only(top: 0,right: 10),
                          child: InkWell(
                              onTap: (){
                                if(productDetailsController.userToken.isNotEmpty &&
                                    productDetailsController.userToken.value!=null){
                                  productDetailsController.addWishList(
                                      token: productDetailsController.userToken.toString(),
                                      productId: productDetailsController.productId.toString());

                                }else{
                                  showLoginWarning();
                                }
                              },
                              child: Icon(

                                Icons.favorite_border,
                                size: 25,
                                color: Colors.white,
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Badge(
                          badgeContent: Obx(()=>Text(
                            productDetailsController.cartCount.value.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500
                            ),
                          )),
                          badgeColor: fnf_color,
                          child: InkWell(
                            onTap: (){

                              Get.to(CartPage())?.then((value) => Get.delete<CartPageController>());
                            },
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 25,),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),


                  Expanded(child: Container(
                    color: Colors.white,

                    child: Obx(() => Column(
                      children: [
                        if(productDetailsController.productDetailsShimmerStatus==1)...{
                          Expanded(
                              child: Container(
                                color: Colors.white,
                                child:  SingleChildScrollView(
                                  child:Column(
                                    children: [

                                      _buildBottomSectionDesignShimmer()

                                    ],
                                  ),
                                ),
                              )


                          ),

                        }
                        else...{
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
                          Container(
                          //  height: 50,
                            padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5),

                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius:   BorderRadius.only(
                                topRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                              ),
                              boxShadow: [BoxShadow(

                                color:Colors.grey.withOpacity(.5),
                                //  blurRadius: 20.0, // soften the shadow
                                blurRadius:.5, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset:Offset(
                                  1.0, // Move to right 10  horizontally
                                  0.0, // Move to bottom 10 Vertically
                                  // Move to bottom 10 Vertically
                                ),
                              )],
                            ),
                            child: Row(
                              children: [
                                // Container(
                                //   margin: EdgeInsets.only(left: 0,right: 30),
                                //   child:  Badge(
                                //     badgeContent:Obx(()=> Text(
                                //       productDetailsController.cartCount.value.toString(),
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 11,
                                //           fontWeight: FontWeight.w500
                                //       ),
                                //     )),
                                //     badgeColor: Colors.blue,
                                //     child:  InkWell(
                                //       onTap: (){
                                //
                                //         // _showToast("ddd")
                                //         Get.to(CartPage())?.then((value) => Get.delete<CartPageController>());
                                //       },
                                //       child: Icon(
                                //         Icons.shopping_cart_outlined,
                                //         size: 30,
                                //         color: Colors.blue,
                                //       ),
                                //     ),
                                //
                                //
                                //   ),
                                // ),

                                Expanded(child: _buildAddToCartButton()),
                                SizedBox(width: 15,),
                                Expanded(child: _buildBuyNowButton()),



                              ],
                            ),

                          ),
                        }


                      ],
                    ),)

                  ))


                ],
              ),

              /* add child content here */
            ),),

          ],
        ),

      )

    );
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
                         Expanded(child: Obx(()=>Text(
                            productDetailsController.productName.toString(),
                            // "Men Grey Classic Regular Fit Formal Shirt Grey solid formal shirt, has a button-down collar, long sleeves, button placket, straight hem, and 1 patch pocket",
                            overflow: TextOverflow.ellipsis,
                           softWrap: false,
                           maxLines: 2,
                            style:  TextStyle(
                                color: text_color,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),

                          )),),

                         // Container(
                         //   margin: EdgeInsets.only(left: 15),
                         //   child:  Column(
                         //     children: [
                         //      Obx(() =>  Text(
                         //        "\$ "+productDetailsController.productPrice.value ,
                         //        overflow: TextOverflow.ellipsis,
                         //
                         //        style:  TextStyle(
                         //            color: hint_color,
                         //            fontSize: 13,
                         //            decoration: TextDecoration.lineThrough,
                         //            fontWeight: FontWeight.normal),
                         //        softWrap: false,
                         //        maxLines: 1,
                         //      ),),
                         //       SizedBox(height: 3,),
                         //
                         //      Obx(() =>  Text(
                         //        "\$ "+productDetailsController.productDiscountPrice.value ,
                         //        overflow: TextOverflow.ellipsis,
                         //        style:  TextStyle(
                         //            color: fnf_color,
                         //            fontSize: 17,
                         //            fontWeight: FontWeight.w700),
                         //        softWrap: false,
                         //        maxLines: 1,
                         //      ))
                         //     ],
                         //   ),
                         // )


                        ],
                      ),
                      
                      //price
                      Container(
                        margin: EdgeInsets.only(left: 0,top: 7),
                        child:  Row(
                          children: [

                            Obx(() =>  Text(
                              "\$ "+
                                  productDetailsController.productDiscountPrice.value ,
                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(
                                  color: fnf_color,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                              softWrap: false,
                              maxLines: 1,
                            )),
                            SizedBox(width: 10,),

                            Obx(() =>  Text(
                              "\$ "+productDetailsController.productPrice.value ,
                              overflow: TextOverflow.ellipsis,

                              style:  TextStyle(
                                  color: text_color,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 1,
                            ),),
                            SizedBox(width: 10,),
                            
                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child:  Obx(()=>RatingBarIndicator(
                                    // rating:response["avg_rating"],
                                    rating:double.parse(productDetailsController.productReviewRating.value),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color:Colors.orange,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                    direction: Axis.horizontal,
                                  )),
                                ),
                                SizedBox(width: 10,),
                                Obx(()=>Text(

                                  productDetailsController.productReviewCount.value+ " review" ,

                                  // "1 review | 7orders | 0 wish",
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      color: fnf_small_text_color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                  softWrap: false,
                                  maxLines: 2,
                                ))
                                // Expanded(child: Obx(()=>Text(
                                //
                                //   productDetailsController.productReviewCount+ " review" ,
                                //
                                //    // "1 review | 7orders | 0 wish",
                                //   overflow: TextOverflow.ellipsis,
                                //   style:  TextStyle(
                                //       color: fnf_small_text_color,
                                //       fontSize: 15,
                                //       fontWeight: FontWeight.normal),
                                //   softWrap: false,
                                //   maxLines: 2,
                                // )),),




                              ],
                            ),)



                          ],
                        ),
                      ),

                      SizedBox(height: 0,),

                      //sku and vendor

                      Container(
                        margin: EdgeInsets.only(left: 0,top: 8),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 0),
                              child:  Text(
                                "SKU: " ,
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                    color: text_color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                softWrap: false,
                                maxLines: 1,
                              ),
                            ),
                            // SizedBox(width: 10,),
                            Obx(()=>Text(
                              productDetailsController.sku.value!="null"?

                              productDetailsController.sku.value:"",

                              // "1 review | 7orders | 0 wish",
                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(
                                  color: text_color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 1,
                            )),


                            SizedBox(width: 10,),

                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child:  const Text(
                                    "Seller/Store/Brand: " ,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                        color: text_color,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ),

                                Obx(()=>Text(



                                  productDetailsController.storeName.value!="null"?
                                  productDetailsController.storeName.value:productDetailsController.sellerName.value,
                                  overflow: TextOverflow.ellipsis,
                                  style:  const TextStyle(
                                      color: fnf_color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                  softWrap: false,
                                  maxLines: 1,
                                )),





                              ],
                            ),)




                          ],
                        ),



                      ),

                      SizedBox(height: 10,),


                      //color

                      Obx(() => Container(
                        child: productDetailsController.colorsImageList.length>0?Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 27,
                          child: Row(
                            children: [
                              const Text(
                                "Available Color: ",
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                    color: text_color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                softWrap: false,
                                maxLines: 2,
                              ),

                              Expanded(child:Obx(()=> ListView.builder(
                                //  shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),

                                itemCount:productDetailsController.colorsImageList==null||
                                    productDetailsController.colorsImageList.length<=0?0:
                                productDetailsController.colorsImageList.length,
                                itemBuilder: (context, index) {
                                  return productDetailsController.colorsImageList[index]["color_name"].toString()!="null"?
                                    Container(
                                    margin: EdgeInsets.only(right: 5),
                                    padding: EdgeInsets.only(right: 8,left: 8),
                                    height: 27,
                                    //  width:32,
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
                                        "${productDetailsController.colorsImageList[index]["color_name"]["name"]}"
                                        //"${productDetailsController.productDetailsData[1]["product"]["colors"][index]["color"]["name"]}"??""
                                        ,
                                        overflow: TextOverflow.ellipsis,
                                        style:  TextStyle(
                                            color: text_color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                        softWrap: false,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ):Container();

                                },
                                scrollDirection: Axis.horizontal,
                              )))

                            ],
                          ) ,
                        ):Container(),
                      ),),


                      //size
                      Obx(() => Container(
                        child: productDetailsController.sizeList.length>0? Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 25,
                          child: Row(
                            children: [
                              Text(
                                "Available Size: ",
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                    color: text_color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                softWrap: false,
                                maxLines: 2,
                              ),
                              Expanded(child: Obx(()=>ListView.builder(
                                //  shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                //itemCount: offerDataList == null ? 0 : offerDataList.length,
                                itemCount:productDetailsController.sizeList==null||
                                    productDetailsController.sizeList.length<=0?0:
                                productDetailsController.sizeList.length,
                                // itemCount:productDetailsController.productDetailsData[1]["product"]["sizes"].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 5),
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    height: 27,
                                    // width:32,
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
                                      child: Obx(()=>Text(
                                        "${productDetailsController.sizeList[index]["size"]["name"]}"??""
                                        ,
                                        overflow: TextOverflow.ellipsis,
                                        style:  TextStyle(
                                            color: text_color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                        softWrap: false,
                                        maxLines: 2,
                                      )),
                                    ),
                                  );

                                },
                                scrollDirection: Axis.horizontal,
                              )))


                            ],
                          ) ,
                        ):Container(),
                      ),),


                      _buildDescriptionDesign(),

                      Container(

                        margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Related Product",
                            style: TextStyle(
                                color:text_color,

                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Obx(()=>GridView.builder(
                          itemCount:productDetailsController.relatedProductList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),

                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:Get.size.width>550? 3:2,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent:Get.size.width>550? 350:260
                          ),

                          // gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: 2,
                          //     crossAxisSpacing:7.0,
                          //     mainAxisSpacing: 5.0,
                          //     mainAxisExtent: 250
                          // ),
                          itemBuilder: (BuildContext context, int index) {
                            return  productCardItemDesign(height: 00, width: MediaQuery.of(context).size.width, index: index);
                          }))

                    ],

                  ),
                )

              ],
            )));
  }

  Widget _buildBottomSectionDesignShimmer() {
    double sizeHeight = Get.height;
    double sizeWidth = Get.width;
    // Size size = MediaQuery.of(context).size;
    // Size size = MediaQuery.of(context).size;
    return Container(
        width: sizeWidth,
        decoration:  BoxDecoration(
          color:Colors.white,
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 00, top: 00, right: 00, bottom: 00),
            child: Column(
              children: [

                buildRectangleShimmer(
                    height: Get.height * 0.5,
                    width:double.maxFinite,
                    marginLeft: 0,
                    marginTop: 5,
                    marginRight: 0,
                    marginBottom: 0),

                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    children: [

                      SizedBox(height: 10,),

                      //shimmer
                      Row(
                        children: [
                          Expanded(child: Align(alignment: Alignment.centerLeft,
                            child: buildRectangleShimmer(
                                height: 40,
                                width:double.maxFinite,
                                marginLeft: 0,
                                marginTop: 8,
                                marginRight: 0,
                                marginBottom: 0),
                          ),),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Align(alignment: Alignment.centerRight,
                                child: buildRectangleShimmer(
                                    height: 15,
                                    width:Get.size.width/3.5,
                                    marginLeft: 0,
                                    marginTop: 8,
                                    marginRight: 0,
                                    marginBottom: 0),
                              ),
                              Align(alignment: Alignment.centerRight,
                                child: buildRectangleShimmer(
                                    height: 20,
                                    width:Get.size.width/3.5,
                                    marginLeft: 0,
                                    marginTop: 8,
                                    marginRight: 0,
                                    marginBottom: 0),
                              ),
                            ],
                          )




                        ],
                      ),

                      //color

                      Obx(() => Container(
                        child: productDetailsController.sizeList.length>0?Container(
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
                              Expanded(child:Obx(()=> ListView.builder(
                                //  shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),

                                itemCount:productDetailsController.colorsImageList==null||
                                    productDetailsController.colorsImageList.length<=0?0:
                                productDetailsController.colorsImageList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 5),
                                    padding: EdgeInsets.only(right: 8,left: 8),
                                    height: 27,
                                    //  width:32,
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
                                        "${productDetailsController.colorsImageList[index]["color_name"]["name"]}"
                                        //"${productDetailsController.productDetailsData[1]["product"]["colors"][index]["color"]["name"]}"??""
                                        ,
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
                              )))

                            ],
                          ) ,
                        ):Container(),
                      ),),

                      ///smimmer
                      Row(
                        children: [
                          Expanded(child: Align(alignment: Alignment.centerLeft,
                            child: buildRectangleShimmer(
                                height: 20,
                                width:Get.size.width/3,
                                marginLeft: 0,
                                marginTop: 5,
                                marginRight: 0,
                                marginBottom: 0),
                          ),),
                          Expanded(child:  Align(alignment: Alignment.centerRight,
                            child: buildRectangleShimmer(
                                height: 20,
                                width:Get.size.width/3,
                                marginLeft: 0,
                                marginTop: 5,
                                marginRight: 0,
                                marginBottom: 0),
                          ),)



                        ],
                      ),

                      ///shimmer
                      Row(
                        children: [
                          buildRectangleShimmer(
                              height: 22,
                              width:Get.size.width/2.3,
                              marginLeft: 0,
                              marginTop: 15,
                              marginRight: 0,
                              marginBottom: 0),

                        ],
                      ),

                      //shimmer
                      Row(
                        children: [
                          Expanded(child:  buildRectangleShimmer(
                              height: 50,
                              width:double.infinity,
                              marginLeft: 0,
                              marginTop: 6,
                              marginRight: 0,
                              marginBottom: 0),)


                        ],
                      ),

                      ///shimmer
                      Row(
                        children: [
                          buildRectangleShimmer(
                              height: 22,
                              width:Get.size.width/2.3,
                              marginLeft: 0,
                              marginTop: 15,
                              marginRight: 0,
                              marginBottom: 0),

                        ],
                      ),

                      //shimmer
                      Row(
                        children: [
                          Expanded(child:  buildRectangleShimmer(
                              height: 50,
                              width:double.infinity,
                              marginLeft: 0,
                              marginTop: 6,
                              marginRight: 0,
                              marginBottom: 0),)


                        ],
                      ),


                      //shimmer
                      Row(
                        children: [
                          buildRectangleShimmer(
                              height: 20,
                              width:Get.size.width/2,
                              marginLeft: 0,
                              marginTop: 20,
                              marginRight: 0,
                              marginBottom: 0),

                        ],
                      ),
                      //shimmer
                      GridView.builder(
                          itemCount:4,
                          padding: EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.size.width>550? 3:2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                              mainAxisExtent: 250
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return  buildProductItemShimmer(height: 00, width: MediaQuery.of(context).size.width,);
                          })



                    ],

                  ),
                )

              ],
            )));
  }

  //product item
  Widget productCardItemDesign({
    required double height,
    required double width,
    required int index,
  }) {
    return InkWell(
      onTap: (){
        /// _showToast(allProductListPageController.filterProductList[index].id.toString());


        Get.back();
        Get.to(() => ProductDetailsePageScreen(), arguments: [
          {"productId": productDetailsController.relatedProductList[index]["id"].toString()},
            {"second": 'Second data'}
        ])?.then((value) => Get.delete<ProductDetailsController>());


        // Get.off(() => ProductDetailsePageScreen(), arguments: [
        //   {"productId": productDetailsController.relatedProductList[index]["id"].toString()},
        //   {"second": 'Second data'}
        // ]);
        // Get.to(ProductDetailsePageScreen());


      },
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            width:width/2 ,
            // height:width/1.3
            padding: EdgeInsets.only(left: 10,right: 10),
            // color: Colors.white,
            child:ClipRRect(
              borderRadius: BorderRadius.circular(10.5),
              child: Column(
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
                              // padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                                padding: EdgeInsets.only(left: 0,right: 0,top: 0),
                                // padding: EdgeInsets.all(16),
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.fill,
                                  placeholder: 'assets/images/loading.png',
                                  // image:"http://192.168.68.106/bijoytech_ecomerce/public/images/product/1669097419-637c67cbbabda.webp",
                                  image:BASE_URL_API_IMAGE_PRODUCT+
                                      productDetailsController.relatedProductList[index]['cover_image'].toString()??"",
                                  imageErrorBuilder: (context, url, error) =>
                                      Image.asset(
                                        'assets/images/loading.png',
                                        fit: BoxFit.fill,
                                      ),
                                )

                              // Image.asset(
                              //     "assets/images/shirt.png"
                              // ),
                            )
                        ),
                        // Positioned(
                        //   right: 5,
                        //   top: 5,
                        //   child: InkWell(
                        //     onTap: (){
                        //
                        //       if(productDetailsController.userToken.isNotEmpty &&
                        //           productDetailsController.userToken.value!=null &&
                        //           productDetailsController.userToken.value!="null"){
                        //         productDetailsController.addWishList(
                        //             token: productDetailsController.userToken.toString(),
                        //             productId: productDetailsController.relatedProductList[index]["id"].toString());
                        //
                        //       }else{
                        //         showLoginWarning();
                        //       }
                        //     },
                        //     child: Icon(Icons.favorite_outline,
                        //       color: fnf_color,
                        //     ),
                        //
                        //   ),
                        // )
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
                            child: Obx(()=> Text(
                              // "product name",
                              productDetailsController.relatedProductList[index]["product_name"],

                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 1,
                            )),
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
                                  // rating:double.parse("4.5"),
                                  rating:double.parse(productDetailsController.relatedProductList[index]["av_review"].toString()),
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
                                  productDetailsController.relatedProductList[index]["count_review"].toString()+
                                      " Review",
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
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Obx(()=>Text(
                            "\$ "+discountedPriceCalculate(regularPrice:productDetailsController.relatedProductList[index]['price'].toString(),
                                discountedPercent:productDetailsController.relatedProductList[index]['discount_percent'].toString()
                              //discountedPercent: response["discount_percent"].toString()
                            ),

                            //allProductListPageController.filterProductList[index].price,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            softWrap: false,
                            maxLines: 1,
                          )),
                          SizedBox(width: 10,),
                          Expanded(
                            child:  Obx(()=> Text(
                              "\$ "+productDetailsController.relatedProductList[index]['price'].toString(),
                              style:  TextStyle(
                                  color: hint_color,
                                  fontSize: 15,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 1,
                            ),),
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




          )
        ],
      ) ,
    );
  }

  //description
  Widget _buildDescriptionDesign(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          margin: const EdgeInsets.only(left: 0.0, right: 0.0, top: 15),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Product Details",
              // "Description",
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
            child: Obx(()=> ExpandableText(
              "${productDetailsController.productDetails.value}",
                      expandText: '  show more',
                      collapseText: '  show less',
                      maxLines: 3,
                      linkColor: Colors.blue,
                      animation: true,
                      linkStyle : const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13
                      ),
                      style: const TextStyle(
                        color:hint_color1,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                      ),


                 //     Text(
            //   "${productDetailsController.productDetails.value}",
            //   // "Per consequat adolescens ex, cu nibh commune temporibus vim, ad sumo viris eloquentiam sed. Mea appareat omittantur eloquentiam ad, nam ei quas oportere democritum.",
            //   style: const TextStyle(
            //       color:hint_color,
            //       fontSize: 16,
            //       fontWeight: FontWeight.normal),
            // ),


            )
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
                   // showToastShort(index.toString());
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
                     Obx(() =>  Row(children: [
                       if(productDetailsController.discountPercent.value.toString()!="0" &&
                           productDetailsController.discountPercent.value.toString()!="null"
                       )...{
                         Container(
                           padding: EdgeInsets.all(7),
                           //  height: 36,
                           // width:36,
                           child: Center(
                             child: Obx(()=>Text(
                               productDetailsController.discountPercent.value.toString()+"% OFF",
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 13,
                                   fontWeight: FontWeight.bold
                               ),
                             )),
                           ),
                           decoration: BoxDecoration(
                             color:fnf_color,
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

                         )

                       }



                     ],),)

                    ],
                  ),
                ),),

                Expanded(child:  Align(alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(top: 10,right: 15),
                      //   child: InkWell(
                      //     onTap: (){
                      //       if(productDetailsController.userToken.isNotEmpty &&
                      //           productDetailsController.userToken.value!=null){
                      //         productDetailsController.addWishList(
                      //             token: productDetailsController.userToken.toString(),
                      //             productId: productDetailsController.productId.toString());
                      //
                      //       }else{
                      //         showLoginWarning();
                      //       }
                      //     },
                      //     child: Container(
                      //       height: 36,
                      //       width:36,
                      //       child: Icon(
                      //
                      //         Icons.favorite_border,
                      //         size: 20,
                      //         color: Colors.red,
                      //       ),
                      //       decoration: BoxDecoration(
                      //         color:Colors.white,
                      //         borderRadius: const BorderRadius.all(
                      //           Radius.circular(18.0),
                      //         ),
                      //         boxShadow: [BoxShadow(
                      //
                      //           color:Colors.grey.withOpacity(.5),
                      //           //  blurRadius: 20.0, // soften the shadow
                      //           blurRadius:.5, // soften the shadow
                      //           spreadRadius: 0.0, //extend the shadow
                      //           offset:Offset(
                      //             0.0, // Move to right 10  horizontally
                      //             1.0, // Move to bottom 10 Vertically
                      //             // Move to bottom 10 Vertically
                      //           ),
                      //         )],
                      //       ),
                      //
                      //     ),
                      //   ),
                      // ),
                      //
                      //
                      // Container(
                      //   margin: EdgeInsets.only(top: 10,right: 15),
                      //   child: InkWell(
                      //     onTap: (){},
                      //     child: Container(
                      //       height: 36,
                      //       width:36,
                      //       child: Icon(
                      //         Icons.share,
                      //         size: 20,
                      //         color: Colors.white,
                      //       ),
                      //       decoration: BoxDecoration(
                      //         color:Colors.blue,
                      //         borderRadius: const BorderRadius.all(
                      //           Radius.circular(18.0),
                      //         ),
                      //
                      //       ),
                      //       /*decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(25),
                      //
                      //               color: Colors.white,
                      //               boxShadow: [
                      //                 BoxShadow(color: Colors.green, spreadRadius: 3),
                      //               ],
                      //             ),*/
                      //
                      //     ),
                      //   ),
                      // )


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

      child:Obx(()=>FadeInImage.assetNetwork(
        fit: BoxFit.fill,
        placeholder: 'assets/images/loading.png',
        image:"$BASE_URL_API_IMAGE_PRODUCT${productDetailsController.productImage.value}",
        imageErrorBuilder: (context, url, error) =>
            Image.asset(
              'assets/images/loading.png',
              fit: BoxFit.fill,
            ),
      ) ),
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

  Widget _buildAddToCartButton() {
    return ElevatedButton(
      onPressed: () {
        openBottomSheetForAddToCart("abcd");
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.blue,Colors.blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 45,
          alignment: Alignment.center,
          child:  const Text(
            "Add to cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBuyNowButton() {
    return ElevatedButton(
      onPressed: () {
        openBottomSheetForBuyNow("abcd");

      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [fnf_color,fnf_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 45,
          alignment: Alignment.center,
          child:  const Text(
            "Buy now",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        // Get.back();
        // _showToast(productDetailsController.sellerName.value.toString());
        // _showToast(productDetailsController.slug.value.toString());


        if(productDetailsController.grocery=="1"){

          showGroceryModal();

        }else{
         Get.back();


          CartNote cartNote= CartNote(

              productId: productDetailsController.productId.value.toString(),
              productName: productDetailsController.productName.value.toString(),
              productRegularPrice: productDetailsController.productRegularPrice.value.toString(),
              productDiscountedPrice: productDetailsController.productDiscountPrice.value.toString(),
              productPhoto:productDetailsController.productPhoto.value.toString(),
              productQuantity: productDetailsController.productQuantity.value.toString(),
              weight: productDetailsController.weight.value.toString(),
              seller: productDetailsController.seller.value.toString(),
              sellerName: productDetailsController.sellerName.value.toString(),
              slug: productDetailsController.slug.value.toString(),
              colorImage: productDetailsController.colorImage.value.toString(),
              size: productDetailsController.size.value.toString(),
              color: productDetailsController.color.value.toString(),
              sizeId: productDetailsController.sizeId.value.toString(),
              colorId: productDetailsController.colorId.value.toString(),
              grocery: productDetailsController.grocery.value.toString(),
              tax: productDetailsController.tax.value.toString(),
              shipping: productDetailsController.shipping.value.toString(),
              shippingName: "null",
              width:productDetailsController.width.value.toString(),
              height: productDetailsController.height.value.toString(),
              depth: productDetailsController.depth.value.toString(),
              weightOption: productDetailsController.weightOption.value.toString(),
              commission: productDetailsController.commission.value.toString(),
              commissionType: productDetailsController.commissionType.value.toString()


            // id: 1,
          );
          productDetailsController.insertData(cartNote);

          showToastShort("Add To Cart Successfully!");

          // productDetailsController.loadAllCartNotes().then((value) => {
          //   Get.to(() => CartPage())?.then((value) => Get.delete<CartPageController>())
          // });

        }

        ///
        // CartNote cartNote= CartNote(
        //     productId: '12',
        //     productName: 'Test',
        //     productRegularPrice: '120',
        //     productDiscountedPrice: '100',
        //     productPhoto: 'https://cdn.vox-cdn.com/thumbor/UMnuubuFGIsw339rSvq3HtaoczQ=/0x0:2048x1280/2000x1333/filters:focal(1024x640:1025x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/22406771/Exbfpl2WgAAQkl8_resized.jpeg',
        //     productQuantity: '2',
        //     weight: '',
        //     seller: '',
        //     sellerName: '',
        //     slug: '',
        //     colorImage: '',
        //     size: '',
        //     color: '',
        //     sizeId: '',
        //     colorId: '',
        //     grocery: '',
        //     tax: '',
        //     shipping: '',
        //     width: '',
        //     height: '',
        //     depth: '',
        //     weightOption: '',
        //     commission: '',
        //     commissionType: ''
        //
        //
        //   // id: 1,
        // );


      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.blue,Colors.blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "Add to cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBuyNowConfirmButton() {
    return ElevatedButton(
      onPressed: () {

        if(productDetailsController.grocery=="1"){

          showGroceryModalForBuyNow();

        }else{
          Get.back();

          if(productDetailsController.userToken.isNotEmpty &&
              productDetailsController.userToken.value!=null){




            CartNote cartNote= CartNote(

                productId: productDetailsController.productId.value.toString(),
                productName: productDetailsController.productName.value.toString(),
                productRegularPrice: productDetailsController.productRegularPrice.value.toString(),
                productDiscountedPrice: productDetailsController.productDiscountPrice.value.toString(),
                productPhoto:productDetailsController.productPhoto.value.toString(),
                productQuantity: productDetailsController.productQuantity.value.toString(),
                weight: productDetailsController.weight.value.toString(),
                seller: productDetailsController.seller.value.toString(),
                sellerName: productDetailsController.sellerName.value.toString(),
                slug: productDetailsController.slug.value.toString(),
                colorImage: productDetailsController.colorImage.value.toString(),
                size: productDetailsController.size.value.toString(),
                color: productDetailsController.color.value.toString(),
                sizeId: productDetailsController.sizeId.value.toString(),
                colorId: productDetailsController.colorId.value.toString(),
                grocery: productDetailsController.grocery.value.toString(),
                tax: productDetailsController.tax.value.toString(),
                shipping: productDetailsController.shipping.value.toString(),
                shippingName: "null",
                width:productDetailsController.width.value.toString(),
                height: productDetailsController.height.value.toString(),
                depth: productDetailsController.depth.value.toString(),
                weightOption: productDetailsController.weightOption.value.toString(),
                commission: productDetailsController.commission.value.toString(),
                commissionType: productDetailsController.commissionType.value.toString()


              // id: 1,
            );
            productDetailsController.insertData1(cartNote);

            productDetailsController.loadAllCartNotes().then((value) => {
              Get.to(() => CheckoutPage(), arguments: [

                {"couponCodes": ""},
                {"couponAmount": ""},
                {"couponSellerId": ""},
                {"couponInfoList": productDetailsController.couponDataList},

              ])?.then((value) => Get.delete<ProductDetailsController>())

            });

           // _showToast(productDetailsController.couponDataList.length.toString());




            // Get.to(CheckoutPage());
            //_showToast("go to checkout process");



          }else{
            showLoginWarning();
          }
        }




      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [fnf_color,fnf_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "Buy now",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () {

        Get.back();


      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [hint_color,hint_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "Cancel",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void openBottomSheetForAddToCart(String text) {
    Get.bottomSheet(
        ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child:  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(

                            decoration: BoxDecoration(
                              // color:Colors.white,
                              //   border: Border.all(
                              //       width: 1,
                              //       color: Colors.blue//                   <--- border width here
                              //   ),
                                borderRadius: BorderRadius.circular(24)),
                            child: FadeInImage.assetNetwork(

                              fit: BoxFit.fill,
                              placeholder: 'assets/images/loading.png',
                              image:"$BASE_URL_API_IMAGE_PRODUCT${productDetailsController.productImage.value}",
                              // image:BASE_URL_API_IMAGE+
                              //    allProductListPageController.filterProductList[index].coverImage??"",
                              imageErrorBuilder: (context, url, error) =>
                                  Image.asset(
                                    'assets/images/loading.png',
                                    fit: BoxFit.fill,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15,),

                              Expanded(child: Obx(() => Text(
                                // "product_name",
                                productDetailsController.productName.value.toString(),
                                // productDetailsController.productDetailsData[1]["product"]["product_name"].toString()??"",
                                // "Men Grey Classic Regular Fit Formal Shirt Grey solid formal shirt, has a button-down collar, long sleeves, button placket, straight hem, and 1 patch pocket",
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                    color: text_color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                softWrap: false,
                                maxLines: 2,
                              )))
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 15,top: 10),
                            child:  Row(
                              children: [
                                Obx(() =>  RatingBarIndicator(
                                  // rating:response["avg_rating"],

                                  rating:double.parse(productDetailsController.productReviewRating.value),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color:Colors.orange,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                ),),
                                Obx(() =>  Text(

                                  productDetailsController.productReviewCount.value+ " review",


                                  //  "(100 review)",
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      color: text_color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                  softWrap: false,
                                  maxLines: 3,
                                ))

                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                  child:  Row(
                    children: [
                      if (productDetailsController.discountPercent.value.toString()!="0" &&
                          productDetailsController.discountPercent.value.toString()!="null"
                      )...{
                        Container(
                          margin: EdgeInsets.only(left: 00,right: 20),
                          padding: EdgeInsets.all(7),
                          // height: 80,
                          width:80,
                          decoration: BoxDecoration(
                            color:fnf_color,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(7.0),
                              bottomLeft: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0),
                            ),
                            boxShadow: [BoxShadow(

                              color:Colors.grey.withOpacity(.5),
                              //  blurRadius: 20.0, // soften the shadow
                              blurRadius:20, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset:const Offset(
                                2.0, // Move to right 10  horizontally
                                1.0, // Move to bottom 10 Vertically
                              ),
                            )],
                          ),
                          child: Center(
                            child: Obx(() => Text(

                              productDetailsController.discountPercent.value.toString()+"% OFF",

                              // "10.0% OFF",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            )),
                          ),
                        ),

                      }  ,

                      Expanded(child:  Row(
                        children:  [
                          Obx(() =>  Text(
                            "\$${productDetailsController.productDiscountPrice.value}",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: fnf_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                            softWrap: false,
                            maxLines: 1,
                          )),

                          SizedBox(width: 10,),
                          Obx(() => Text(
                            "\$${productDetailsController.productRegularPrice.value}",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal),
                            softWrap: false,
                            maxLines: 1,
                          ),),

                        ],
                      ))
                    ],
                  ),
                ),

                //color
                Obx(() => Container(
                  child: productDetailsController.colorsImageList.length>0?Container(
                    margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                    height: 30,
                    child: Row(
                      children: [


                        Text(
                          "Available Color: ",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          softWrap: false,
                          maxLines:1,
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: ListView.builder(
                          //  shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          //itemCount: offerDataList == null ? 0 : offerDataList.length,
                          itemCount:productDetailsController.colorsImageList==null||
                              productDetailsController.colorsImageList.length<=0?0:
                          productDetailsController.colorsImageList.length,
                          itemBuilder: (context, index) {
                            return productDetailsController.colorsImageList[index]["color_name"].toString()!="null"?
                            InkWell(
                              onTap: (){
                                productDetailsController.selectedColorIndex(index);

                                productDetailsController.colorId(productDetailsController.colorsImageList[index]["color_name"]["id"].toString());
                                productDetailsController.color(productDetailsController.colorsImageList[index]["color_name"]["name"].toString());

                              },
                              child: Obx(()=>Container(
                                height: 30,
                                // width: 30,
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.only(right: 10,left: 10),

                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  // color:Colors.white,
                                  border: Border.all(
                                    color: productDetailsController.selectedColorIndex.value==index?Colors.blue:
                                    Colors.white,
                                    width: .5, //                   <--- border width here
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),

                                  ),

                                ),
                                child: Center(
                                  child: Text(
                                    "${productDetailsController.colorsImageList[index]["color_name"]["name"]}"
                                    //"${productDetailsController.productDetailsData[1]["product"]["colors"][index]["color"]["name"]}"??""
                                    ,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                        color: text_color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                    softWrap: false,
                                    maxLines: 2,
                                  ),
                                ),
                              )),
                            ):
                            Container();

                          },
                          scrollDirection: Axis.horizontal,
                        ))


                      ],
                    ) ,
                  ):Container(),
                ),),


                //size
                Obx(() => Container(
                  child: productDetailsController.sizeList.length>0?Container(
                    margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                    height: 25,
                    child: Row(
                      children: [
                        const Text(
                          "Available Size: ",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          softWrap: false,
                          maxLines: 1,
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: Obx(()=>ListView.builder(
                          //  shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          //itemCount: offerDataList == null ? 0 : offerDataList.length,
                          itemCount:productDetailsController.sizeList==null||
                              productDetailsController.sizeList.length<=0?0:
                          productDetailsController.sizeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: (){
                                  productDetailsController.selectedSizeIndex(index);
                                  productDetailsController.sizeId(productDetailsController.sizeList[index]["size"]["id"].toString());
                                  productDetailsController.size(productDetailsController.sizeList[index]["size"]["name"].toString());

                                },

                                child: Obx(()=>Container(
                                  margin: EdgeInsets.only(right: 5),
                                  height: 27,
                                  width:35,
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    // color:Colors.white,
                                    border: Border.all(
                                      color: productDetailsController.selectedSizeIndex.value==index?Colors.blue:
                                      Colors.white,
                                      width: .5, //                   <--- border width here
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),

                                    ),

                                  ),
                                  child:  Center(
                                      child: Obx(()=>Text(
                                        "${productDetailsController.sizeList[index]["size"]["name"]}"??"",
                                        // "L",
                                        overflow: TextOverflow.ellipsis,
                                        style:  TextStyle(
                                            color: text_color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                        softWrap: false,
                                        maxLines: 2,
                                      ),)
                                  ),
                                ),));

                          },
                          scrollDirection: Axis.horizontal,
                        )))

                      ],
                    ) ,
                  ):Container(),
                ),),



                //type

                // Obx(() => Container(
                //   child: productDetailsController.sizeList.length>0?Container(
                //     margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                //     height: 25,
                //     child: Row(
                //       children: [
                //         Text(
                //           "Available Type: ",
                //           overflow: TextOverflow.ellipsis,
                //           style:  TextStyle(
                //               color: text_color,
                //               fontSize: 15,
                //               fontWeight: FontWeight.normal),
                //           softWrap: false,
                //           maxLines: 1,
                //         ),
                //         SizedBox(width: 10,),
                //         Expanded(child: ListView.builder(
                //           //  shrinkWrap: true,
                //           // physics: const NeverScrollableScrollPhysics(),
                //           //itemCount: offerDataList == null ? 0 : offerDataList.length,
                //           itemCount:0,
                //           itemBuilder: (context, index) {
                //             return InkWell(
                //                 onTap: (){
                //                   productDetailsController.selectedTypeIndex(index);
                //                 },
                //
                //                 child: Obx(()=>Container(
                //                   margin: EdgeInsets.only(right: 5),
                //                   height: 27,
                //                   width:35,
                //                   decoration: BoxDecoration(
                //                     color:Colors.white,
                //                     // color:Colors.white,
                //                     border: Border.all(
                //                       color: productDetailsController.selectedTypeIndex.value==index?Colors.blue:
                //                       Colors.white,
                //                       width: .5, //                   <--- border width here
                //                     ),
                //                     borderRadius: const BorderRadius.all(
                //                       Radius.circular(5.0),
                //
                //                     ),
                //
                //                   ),
                //                   child:  Center(
                //                     child: Text(
                //                       "a",
                //                       overflow: TextOverflow.ellipsis,
                //                       style:  TextStyle(
                //                           color: text_color,
                //                           fontSize: 13,
                //                           fontWeight: FontWeight.normal),
                //                       softWrap: false,
                //                       maxLines: 2,
                //                     ),
                //                   ),
                //                 ),));
                //
                //           },
                //           scrollDirection: Axis.horizontal,
                //         ))
                //
                //
                //       ],
                //     ) ,
                //   ):Container(),
                // ),),



                //Quantity
                Container(
                  margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                  height: 25,
                  child: Row(
                    children: [
                      Text(
                        "Quantity: ",
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                            color: text_color,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        softWrap: false,
                        maxLines: 1,
                      ),
                      SizedBox(width: 10,),


                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: (){
                            if(productDetailsController.productQuantity>1){
                              productDetailsController.productQuantity--;

                            }

                          },
                          child:  Container(

                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color:Colors.white,
                                // color:Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: .5, //                   <--- border width here
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),

                                ),

                              ),
                              child: Center(
                                child: Text("−",
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      color: text_color,
                                      fontSize: 16
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                      Obx(() => Text(productDetailsController.productQuantity.value.toString(),
                        style: TextStyle(fontWeight: FontWeight.w600,
                            color: text_color,
                            fontSize: 15
                        ),
                      ),),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: (){
                            productDetailsController.productQuantity++;

                          },
                          child:  Container(

                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color:Colors.white,
                                // color:Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: .5, //                   <--- border width here
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),

                                ),

                              ),
                              child: Center(
                                child: Text("+",
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      color: text_color,
                                      fontSize: 16
                                  ),
                                ),
                              )
                          ),
                        ),
                      )



                    ],
                  ) ,
                ),


                SizedBox(height: 20,),
                ///total price
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Price: ",
                      style: TextStyle(fontWeight: FontWeight.w600,
                          color: text_color,
                          fontSize: 15
                      ),
                    ),
                    Obx(() => Text(
                      "\$${double.parse((double.parse(productDetailsController.productDiscountPrice.value)*productDetailsController.productQuantity.value).toStringAsFixed(2))}",

                      style: TextStyle(fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 15
                      ),
                    ),),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),

                    Expanded(child: _buildCancelButton(),),
                    SizedBox(width: 10,),
                    Expanded(child:  _buildAddToCartConfirmButton(),),

                    SizedBox(width: 10,),

                  ],
                ),
                SizedBox(height: 5,),

              ],
            ),
          ],
        ),


        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),

          ),
        ),
        isScrollControlled: true


      //  resizeToAvoidBottomInset: false
      // isScrollControlled: true,
    );
  }

  void openBottomSheetForBuyNow(String text) {
    Get.bottomSheet(
        ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child:  Row(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(

                            decoration: BoxDecoration(
                              // color:Colors.white,
                              //   border: Border.all(
                              //       width: 1,
                              //       color: Colors.blue//                   <--- border width here
                              //   ),
                                borderRadius: BorderRadius.circular(24)),
                            child: FadeInImage.assetNetwork(

                              fit: BoxFit.fill,
                              placeholder: 'assets/images/loading.png',
                              image:"$BASE_URL_API_IMAGE_PRODUCT${productDetailsController.productImage.value}",
                              // image:BASE_URL_API_IMAGE+
                              //    allProductListPageController.filterProductList[index].coverImage??"",
                              imageErrorBuilder: (context, url, error) =>
                                  Image.asset(
                                    'assets/images/loading.png',
                                    fit: BoxFit.fill,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 15,),

                              Expanded(child: Obx(() => Text(
                                // "product_name",
                                productDetailsController.productName.value.toString(),
                                // productDetailsController.productDetailsData[1]["product"]["product_name"].toString()??"",
                                // "Men Grey Classic Regular Fit Formal Shirt Grey solid formal shirt, has a button-down collar, long sleeves, button placket, straight hem, and 1 patch pocket",
                                overflow: TextOverflow.ellipsis,
                                style:  TextStyle(
                                    color: text_color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                softWrap: false,
                                maxLines: 2,
                              )))
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 15,top: 10),
                            child:  Row(
                              children: [
                                Obx(() =>  RatingBarIndicator(
                                  // rating:response["avg_rating"],

                                  rating:double.parse(productDetailsController.productReviewRating.value),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color:Colors.orange,
                                  ),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  direction: Axis.horizontal,
                                ),),
                                Obx(() =>  Text(

                                  productDetailsController.productReviewCount.value+ " review",


                                  //  "(100 review)",
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      color: text_color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                  softWrap: false,
                                  maxLines: 3,
                                ))

                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                  child:  Row(
                    children: [
                      if (productDetailsController.discountPercent.value.toString()!="0" &&
                          productDetailsController.discountPercent.value.toString()!="null"
                      )...{
                        Container(
                          margin: EdgeInsets.only(left: 00,right: 20),
                          padding: EdgeInsets.all(7),
                          // height: 80,
                          width:80,
                          decoration: BoxDecoration(
                            color:fnf_color,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(7.0),
                              bottomLeft: Radius.circular(7.0),
                              topLeft: Radius.circular(7.0),
                              topRight: Radius.circular(7.0),
                            ),
                            boxShadow: [BoxShadow(

                              color:Colors.grey.withOpacity(.5),
                              //  blurRadius: 20.0, // soften the shadow
                              blurRadius:20, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset:const Offset(
                                2.0, // Move to right 10  horizontally
                                1.0, // Move to bottom 10 Vertically
                              ),
                            )],
                          ),
                          child: Center(
                            child: Obx(() => Text(

                              productDetailsController.discountPercent.value.toString()+"% OFF",

                              // "10.0% OFF",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            )),
                          ),
                        ),

                      }  ,

                      Expanded(child:  Row(
                        children:  [
                          Obx(() =>  Text(
                            "\$${productDetailsController.productDiscountPrice.value}",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: fnf_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                            softWrap: false,
                            maxLines: 1,
                          )),

                          SizedBox(width: 10,),
                          Obx(() => Text(
                            "\$${productDetailsController.productRegularPrice.value}",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal),
                            softWrap: false,
                            maxLines: 1,
                          ),),

                        ],
                      ))
                    ],
                  ),
                ),

                //color
                Obx(() => Container(
                  child: productDetailsController.colorsImageList.length>0?Container(
                    margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                    height: 30,
                    child: Row(
                      children: [


                        Text(
                          "Available Color: ",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          softWrap: false,
                          maxLines:1,
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: ListView.builder(
                          //  shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          //itemCount: offerDataList == null ? 0 : offerDataList.length,
                          itemCount:productDetailsController.colorsImageList==null||
                              productDetailsController.colorsImageList.length<=0?0:
                          productDetailsController.colorsImageList.length,
                          itemBuilder: (context, index) {
                            return productDetailsController.colorsImageList[index]["color_name"].toString()!="null"?
                            InkWell(
                              onTap: (){
                                productDetailsController.selectedColorIndex(index);

                                productDetailsController.colorId(productDetailsController.colorsImageList[index]["color_name"]["id"].toString());
                                productDetailsController.color(productDetailsController.colorsImageList[index]["color_name"]["name"].toString());

                              },
                              child: Obx(()=>Container(
                                height: 30,
                                // width: 30,
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.only(right: 10,left: 10),

                                decoration: BoxDecoration(
                                  color:Colors.white,
                                  // color:Colors.white,
                                  border: Border.all(
                                    color: productDetailsController.selectedColorIndex.value==index?Colors.blue:
                                    Colors.white,
                                    width: .5, //                   <--- border width here
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),

                                  ),

                                ),
                                child: Center(
                                  child: Text(
                                    "${productDetailsController.colorsImageList[index]["color_name"]["name"]}"
                                    //"${productDetailsController.productDetailsData[1]["product"]["colors"][index]["color"]["name"]}"??""
                                    ,
                                    overflow: TextOverflow.ellipsis,
                                    style:  TextStyle(
                                        color: text_color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                    softWrap: false,
                                    maxLines: 2,
                                  ),
                                ),
                              )),
                            ):
                            Container();

                          },
                          scrollDirection: Axis.horizontal,
                        ))


                      ],
                    ) ,
                  ):Container(),
                ),),


                //size
                Obx(() => Container(
                  child: productDetailsController.sizeList.length>0?Container(
                    margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                    height: 25,
                    child: Row(
                      children: [
                        const Text(
                          "Available Size: ",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          softWrap: false,
                          maxLines: 1,
                        ),
                        SizedBox(width: 10,),
                        Expanded(child: Obx(()=>ListView.builder(
                          //  shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          //itemCount: offerDataList == null ? 0 : offerDataList.length,
                          itemCount:productDetailsController.sizeList==null||
                              productDetailsController.sizeList.length<=0?0:
                          productDetailsController.sizeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: (){
                                  productDetailsController.selectedSizeIndex(index);
                                  productDetailsController.sizeId(productDetailsController.sizeList[index]["size"]["id"].toString());
                                  productDetailsController.size(productDetailsController.sizeList[index]["size"]["name"].toString());

                                },

                                child: Obx(()=>Container(
                                  margin: EdgeInsets.only(right: 5),
                                  height: 27,
                                  width:35,
                                  decoration: BoxDecoration(
                                    color:Colors.white,
                                    // color:Colors.white,
                                    border: Border.all(
                                      color: productDetailsController.selectedSizeIndex.value==index?Colors.blue:
                                      Colors.white,
                                      width: .5, //                   <--- border width here
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0),

                                    ),

                                  ),
                                  child:  Center(
                                      child: Obx(()=>Text(
                                        "${productDetailsController.sizeList[index]["size"]["name"]}"??"",
                                        // "L",
                                        overflow: TextOverflow.ellipsis,
                                        style:  TextStyle(
                                            color: text_color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                        softWrap: false,
                                        maxLines: 2,
                                      ),)
                                  ),
                                ),));

                          },
                          scrollDirection: Axis.horizontal,
                        )))

                      ],
                    ) ,
                  ):Container(),
                ),),



                //type

                // Obx(() => Container(
                //   child: productDetailsController.sizeList.length>0?Container(
                //     margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                //     height: 25,
                //     child: Row(
                //       children: [
                //         Text(
                //           "Available Type: ",
                //           overflow: TextOverflow.ellipsis,
                //           style:  TextStyle(
                //               color: text_color,
                //               fontSize: 15,
                //               fontWeight: FontWeight.normal),
                //           softWrap: false,
                //           maxLines: 1,
                //         ),
                //         SizedBox(width: 10,),
                //         Expanded(child: ListView.builder(
                //           //  shrinkWrap: true,
                //           // physics: const NeverScrollableScrollPhysics(),
                //           //itemCount: offerDataList == null ? 0 : offerDataList.length,
                //           itemCount:0,
                //           itemBuilder: (context, index) {
                //             return InkWell(
                //                 onTap: (){
                //                   productDetailsController.selectedTypeIndex(index);
                //                 },
                //
                //                 child: Obx(()=>Container(
                //                   margin: EdgeInsets.only(right: 5),
                //                   height: 27,
                //                   width:35,
                //                   decoration: BoxDecoration(
                //                     color:Colors.white,
                //                     // color:Colors.white,
                //                     border: Border.all(
                //                       color: productDetailsController.selectedTypeIndex.value==index?Colors.blue:
                //                       Colors.white,
                //                       width: .5, //                   <--- border width here
                //                     ),
                //                     borderRadius: const BorderRadius.all(
                //                       Radius.circular(5.0),
                //
                //                     ),
                //
                //                   ),
                //                   child:  Center(
                //                     child: Text(
                //                       "a",
                //                       overflow: TextOverflow.ellipsis,
                //                       style:  TextStyle(
                //                           color: text_color,
                //                           fontSize: 13,
                //                           fontWeight: FontWeight.normal),
                //                       softWrap: false,
                //                       maxLines: 2,
                //                     ),
                //                   ),
                //                 ),));
                //
                //           },
                //           scrollDirection: Axis.horizontal,
                //         ))
                //
                //
                //       ],
                //     ) ,
                //   ):Container(),
                // ),),



                //Quantity
                Container(
                  margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                  height: 25,
                  child: Row(
                    children: [
                      Text(
                        "Quantity: ",
                        overflow: TextOverflow.ellipsis,
                        style:  TextStyle(
                            color: text_color,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        softWrap: false,
                        maxLines: 1,
                      ),
                      SizedBox(width: 10,),


                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: (){
                            if(productDetailsController.productQuantity>1){
                              productDetailsController.productQuantity--;

                            }

                          },
                          child:  Container(

                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color:Colors.white,
                                // color:Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: .5, //                   <--- border width here
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),

                                ),

                              ),
                              child: Center(
                                child: Text("−",
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      color: text_color,
                                      fontSize: 16
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),
                      Obx(() => Text(productDetailsController.productQuantity.value.toString(),
                        style: TextStyle(fontWeight: FontWeight.w600,
                            color: text_color,
                            fontSize: 15
                        ),
                      ),),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: (){
                            productDetailsController.productQuantity++;

                          },
                          child:  Container(

                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color:Colors.white,
                                // color:Colors.white,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: .5, //                   <--- border width here
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0),

                                ),

                              ),
                              child: Center(
                                child: Text("+",
                                  style: TextStyle(fontWeight: FontWeight.w500,
                                      color: text_color,
                                      fontSize: 16
                                  ),
                                ),
                              )
                          ),
                        ),
                      )



                    ],
                  ) ,
                ),


                SizedBox(height: 20,),
                ///total price
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Price: ",
                      style: TextStyle(fontWeight: FontWeight.w600,
                          color: text_color,
                          fontSize: 15
                      ),
                    ),
                    Obx(() => Text(
                      "\$${double.parse((double.parse(productDetailsController.productDiscountPrice.value)*productDetailsController.productQuantity.value).toStringAsFixed(2))}",

                      style: TextStyle(fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 15
                      ),
                    ),),

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(width: 10,),
                    Expanded(child:  _buildCancelButton(),),
                    SizedBox(width: 10,),
                    Expanded(child: _buildBuyNowConfirmButton(),),
                    SizedBox(width: 10,),

                  ],
                ),
                SizedBox(height: 5,),

              ],
            ),
          ],
        ),

        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),

          ),
        ),
        isScrollControlled: true


      //  resizeToAvoidBottomInset: false
      // isScrollControlled: true,
    );
  }



  void showGroceryModal( ) {

    Get.defaultDialog(
        contentPadding: EdgeInsets.zero,
        //  title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Column(
          children: [

            Stack(
              children: [
                Container(

                    child:   Center(
                      child: Column(
                        children: [


                          Container(
                            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child:   Text(
                                "Need check zip code",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: TextField(
                              cursorColor: awsCursorColor,
                              cursorWidth: 1.5,

                              controller: productDetailsController.searchController.value,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText: "Zip Code",
                                filled: true,
                                fillColor: Colors.white,

                                contentPadding:  EdgeInsets.only(left: 15, right: 15,top: 10,bottom:10 ),

                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
                                ),
                                labelStyle: TextStyle(
                                  color:productDetailsController.userEmailLevelTextColor.value,
                                ),
                                hintText: "Enter zip code",
                                hintStyle: const TextStyle(
                                  color: hint_color,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'PTSans',
                                ),
                              ),
                              keyboardType: TextInputType.text,

                            ),
                          ),


                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: _buildCheckZipCodeButton(),
                          ),


                        ],
                      ),
                    )

                ),
                Align(alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),



                    child: InkWell(
                      onTap: (){
                        Get.back();


                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.deepOrangeAccent,
                        size: 22.0,
                      ),
                    ),
                  ),

                ),
              ],
            )

          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }

  void showGroceryModalForBuyNow( ) {

    Get.defaultDialog(
        contentPadding: EdgeInsets.zero,
        //  title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Column(
          children: [

            Stack(
              children: [
                Container(

                    child:   Center(
                      child: Column(
                        children: [


                          Container(
                            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child:   Text(
                                "Need check zip code",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: TextField(
                              cursorColor: awsCursorColor,
                              cursorWidth: 1.5,

                              controller: productDetailsController.searchController.value,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(color: Colors.black, fontSize: 15),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText: "Zip Code",
                                filled: true,
                                fillColor: Colors.white,

                                contentPadding:  EdgeInsets.only(left: 15, right: 15,top: 10,bottom:10 ),

                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
                                ),
                                labelStyle: TextStyle(
                                  color:productDetailsController.userEmailLevelTextColor.value,
                                ),
                                hintText: "Enter zip code",
                                hintStyle: const TextStyle(
                                  color: hint_color,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'PTSans',
                                ),
                              ),
                              keyboardType: TextInputType.text,

                            ),
                          ),


                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: _buildCheckZipCodeButtonForBuyNow(),
                          ),


                        ],
                      ),
                    )

                ),
                Align(alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),



                    child: InkWell(
                      onTap: (){
                        Get.back();


                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.deepOrangeAccent,
                        size: 22.0,
                      ),
                    ),
                  ),

                ),
              ],
            )

          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }

  Widget _buildCheckZipCodeButton() {
    return ElevatedButton(
      onPressed: () async {
       String zipCode= productDetailsController.searchController.value.text;
       if(zipCode.isNotEmpty){

         if(await productDetailsController.zipCodeCheck( zipCode: zipCode, sellerId: productDetailsController.seller.value,)){
           Get.back();
           Get.back();
           CartNote cartNote= CartNote(

               productId: productDetailsController.productId.value.toString(),
               productName: productDetailsController.productName.value.toString(),
               productRegularPrice: productDetailsController.productRegularPrice.value.toString(),
               productDiscountedPrice: productDetailsController.productDiscountPrice.value.toString(),
               productPhoto:productDetailsController.productPhoto.value.toString(),
               productQuantity: productDetailsController.productQuantity.value.toString(),
               weight: productDetailsController.weight.value.toString(),
               seller: productDetailsController.seller.value.toString(),
               sellerName: productDetailsController.sellerName.value.toString(),
               slug: productDetailsController.slug.value.toString(),
               colorImage: productDetailsController.colorImage.value.toString(),
               size: productDetailsController.size.value.toString(),
               color: productDetailsController.color.value.toString(),
               sizeId: productDetailsController.sizeId.value.toString(),
               colorId: productDetailsController.colorId.value.toString(),
               grocery: productDetailsController.grocery.value.toString(),
               tax: productDetailsController.tax.value.toString(),
               shipping: productDetailsController.shipping.value.toString(),
               shippingName: "null",
               width:productDetailsController.width.value.toString(),
               height: productDetailsController.height.value.toString(),
               depth: productDetailsController.depth.value.toString(),
               weightOption: productDetailsController.weightOption.value.toString(),
               commission: productDetailsController.commission.value.toString(),
               commissionType: productDetailsController.commissionType.value.toString()


             // id: 1,
           );
           productDetailsController.insertData(cartNote);
           productDetailsController.loadAllCartNotes().then((value) => {
             Get.to(() => CartPage())?.then((value) => Get.delete<CartPageController>())
           });

         }else{
           Get.back();
         }


        // _showToast(zipCode.toString());



       }else{
         showToastShort("please Enter Zip code!");

       }
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [fnf_color,fnf_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "Check",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckZipCodeButtonForBuyNow() {
    return ElevatedButton(
      onPressed: () async {
        String zipCode= productDetailsController.searchController.value.text;
        if(zipCode.isNotEmpty){

          if(await productDetailsController.zipCodeCheck( zipCode: zipCode,sellerId: productDetailsController.seller.value,)){
            Get.back();
            Get.back();

            if(productDetailsController.userToken.isNotEmpty &&
                productDetailsController.userToken.value!=null){
              CartNote cartNote= CartNote(

                  productId: productDetailsController.productId.value.toString(),
                  productName: productDetailsController.productName.value.toString(),
                  productRegularPrice: productDetailsController.productRegularPrice.value.toString(),
                  productDiscountedPrice: productDetailsController.productDiscountPrice.value.toString(),
                  productPhoto:productDetailsController.productPhoto.value.toString(),
                  productQuantity: productDetailsController.productQuantity.value.toString(),
                  weight: productDetailsController.weight.value.toString(),
                  seller: productDetailsController.seller.value.toString(),
                  sellerName: productDetailsController.sellerName.value.toString(),
                  slug: productDetailsController.slug.value.toString(),
                  colorImage: productDetailsController.colorImage.value.toString(),
                  size: productDetailsController.size.value.toString(),
                  color: productDetailsController.color.value.toString(),
                  sizeId: productDetailsController.sizeId.value.toString(),
                  colorId: productDetailsController.colorId.value.toString(),
                  grocery: productDetailsController.grocery.value.toString(),
                  tax: productDetailsController.tax.value.toString(),
                  shipping: productDetailsController.shipping.value.toString(),
                  shippingName: "null",
                  width:productDetailsController.width.value.toString(),
                  height: productDetailsController.height.value.toString(),
                  depth: productDetailsController.depth.value.toString(),
                  weightOption: productDetailsController.weightOption.value.toString(),
                  commission: productDetailsController.commission.value.toString(),
                  commissionType: productDetailsController.commissionType.value.toString()


                // id: 1,
              );
              productDetailsController.insertData1(cartNote);


              productDetailsController.loadAllCartNotes().then((value) => {
                Get.to(() => CheckoutPage(), arguments: [

                  {"couponCodes": ""},
                  {"couponAmount": ""},
                  {"couponSellerId": ""},
                  {"couponInfoList": productDetailsController.couponDataList},

                ])?.then((value) => Get.delete<ProductDetailsController>())

              });

              // Get.to(() => CheckoutPage(), arguments: [
              //   {"couponCodes": ""},
              //   {"couponAmount": ""},
              //   {"couponSellerId": ""},
              // ])?.then((value) => Get.delete<ProductDetailsController>());
              //_showToast("go to checkout process");
            }
            else{
              showLoginWarning();
            }
          }else{
            Get.back();
          }
          // _showToast(zipCode.toString());

        }else{
          showToastShort("please Enter Zip code!");

        }
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [fnf_color,fnf_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "Verify",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String discountedPriceCalculate({required String regularPrice,required String discountedPercent}){
    return double.parse(((double.parse(regularPrice)-
        ((double.parse(regularPrice)*
            double.parse(discountedPercent))/100))).toStringAsFixed(2)).toString();
  }


}
