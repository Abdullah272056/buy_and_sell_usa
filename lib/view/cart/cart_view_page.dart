import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../controller/cart_controller/cart__view_page_controller.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../static/Colors.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';
import '../checkout step/checkout_page.dart';
import '../common/login_warning.dart';
import '../common/toast.dart';
import '../dash_board/dash_board_page.dart';
import '../dash_board/wish_list_page.dart';
import 'cart_page.dart';


class CartViewePage extends StatelessWidget {

  final cartViewPageController = Get.put(CartViewPageController());
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width =MediaQuery.of(context).size.width;
    height =MediaQuery.of(context).size.height;
    return Scaffold(
      body:RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.blue,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          cartViewPageController.onInit();
          await Future.delayed(const Duration(seconds: 1));
          //updateDataAfterRefresh();
        },
        child:  Column(
          children: [






            Expanded(child: Container(
                decoration: BoxDecoration(
                  color:fnf_title_bar_bg_color,
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 22,
                    //   // height: 50,
                    // ),
                    // Flex(direction: Axis.horizontal,
                    //   children: [
                    //     SizedBox(width: 5,),
                    //     IconButton(
                    //       iconSize: 20,
                    //       icon:Icon(
                    //         Icons.arrow_back_ios_new,
                    //         color: Colors.white,
                    //       ),
                    //       onPressed: () {
                    //         Get.back();
                    //       },
                    //     ),
                    //     SizedBox(width: 5,),
                    //     Expanded(child: Text(
                    //       "SHOPPING CART",
                    //       style: TextStyle(color: Colors.white,
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 17
                    //       ),
                    //     )),
                    //   ],
                    // ),


                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
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
                          "SHOPPING CART",
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


                        // Container(
                        //   margin: EdgeInsets.only(top: 0,right: 10),
                        //   child: InkWell(
                        //       onTap: (){
                        //         if(categoriesPageController.userToken.isNotEmpty &&
                        //             categoriesPageController.userToken.value!=null){
                        //           categoriesPageController.addWishList(
                        //               token: categoriesPageController.userToken.toString(),
                        //               productId: categoriesPageController.productId.toString());
                        //
                        //         }else{
                        //           showLoginWarning();
                        //         }
                        //       },
                        //       child: Icon(
                        //
                        //         Icons.favorite_border,
                        //         size: 25,
                        //         color: Colors.red,
                        //       )
                        //   ),
                        // ),
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: InkWell(

                            onTap: () {
                              if(cartViewPageController.userToken.isNotEmpty &&
                                  cartViewPageController.userToken.value!="null"&&
                                  cartViewPageController.userToken.value!=null){
                                // _showToast(homeController.userToken.toString());
                                //  _showToast("add favourite");
                                Get.to(WishListPage())?.then((value) => Get.delete<WishListPageController>());
                              }else{
                                showLoginWarning();
                              }

                            },
                            child:  Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                        ),

                        SizedBox(width: 10,),

                        InkWell(
                          onTap: (){

                            Get.off(CartPage())?.then((value) => Get.delete<CartPageController>());
                          },
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(width: 25,),


                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 125,
                      // height: 50,
                    ),







                   Obx(()=> Expanded(child:cartViewPageController.cartList.length>0?
                   Container(
                     color: Colors.white,

                     child: Column(
                       children: [

                         Expanded(
                             child: Container(
                               color: Colors.white,
                               child:  ListView.builder(
                                   padding: EdgeInsets.zero,
                                   itemCount:1,
                                   shrinkWrap: true,
                                   //physics: const NeverScrollableScrollPhysics(),
                                   itemBuilder: (BuildContext context, int index) {
                                     return Column(
                                       children: [

                                         Obx(() =>   ListView.builder(
                                             padding: EdgeInsets.zero,
                                             itemCount: cartViewPageController.sellerGroupList.length,
                                             shrinkWrap: true,
                                             physics: const NeverScrollableScrollPhysics(),
                                             itemBuilder: (BuildContext context, int index) {
                                               return Obx(()=>Column(
                                                 children: [
                                                   Row(
                                                     children: [
                                                       Expanded(child: Container(
                                                           margin: EdgeInsets.only(bottom: 5),
                                                           padding: EdgeInsets.only(left: 20,top: 15,bottom: 15),

                                                           color: Colors.blue,
                                                           child: Align(
                                                             alignment: Alignment.centerLeft,
                                                             child: Text(
                                                               cartViewPageController.sellerGroupList[index].sellerName.toString(),
                                                               style: TextStyle(
                                                                   color: Colors.white
                                                               ),
                                                             ),
                                                           )
                                                       ))
                                                     ],
                                                   ),

                                                   Obx(() =>   ListView.builder(
                                                       padding: EdgeInsets.zero,
                                                       itemCount: cartViewPageController.cartList.length,
                                                       shrinkWrap: true,
                                                       physics: const NeverScrollableScrollPhysics(),
                                                       itemBuilder: (BuildContext context, int index1) {
                                                         double regularPrice=0.0;



                                                         if(cartViewPageController.sellerGroupList[index].seller.toString()==
                                                             cartViewPageController.cartList[index1].seller.toString()){
                                                           return cartItem(cartViewPageController.cartList[index1]);
                                                         }else{
                                                           return Container();
                                                         }

                                                       }),),

                                                   Padding(padding: EdgeInsets.only(left: 10,right: 10,),
                                                     child: Row(
                                                       children: [
                                                         Expanded(child: Container(
                                                           height: 1,
                                                           color:hint_color,
                                                         ))
                                                       ],
                                                     ),
                                                   ),
                                                   Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                                                     child: Row(
                                                       // mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Expanded(
                                                           child:  Text("Sub Total: ",
                                                             style: TextStyle(fontWeight: FontWeight.w600,
                                                                 color: text_color,
                                                                 fontSize: 15
                                                             ),
                                                           ),),
                                                         Expanded(child:   Align(
                                                           alignment: Alignment.centerRight,
                                                           child:Obx(()=> Text(
                                                             "\$ "+ totalPriceCalculate(cartViewPageController.cartList,
                                                                 cartViewPageController.sellerGroupList[index].seller.toString()),
                                                             // "\$ "+"${cartViewPageController.totalPrice}",
                                                             // "\$ "+"${cartViewPageController.totalPrice}",
                                                             style: TextStyle(fontWeight: FontWeight.w600,
                                                                 color: Colors.blue,
                                                                 fontSize: 16
                                                             ),
                                                           )),
                                                         )),



                                                       ],
                                                     ) ,
                                                   ),
                                                   Padding(padding: EdgeInsets.only(left: 10,right: 10,),
                                                     child:Row(
                                                       // mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Expanded(
                                                           child:  Text("Tax: ",
                                                             style: TextStyle(fontWeight: FontWeight.w600,
                                                                 color: text_color,
                                                                 fontSize: 15
                                                             ),
                                                           ),),
                                                         Expanded(child:   Align(
                                                           alignment: Alignment.centerRight,
                                                           child:Obx(()=> Text(
                                                             "\$ "+totalTaxCalculate(cartViewPageController.cartList,
                                                                 cartViewPageController.sellerGroupList[index].seller.toString()),
                                                             style: TextStyle(fontWeight: FontWeight.w600,
                                                                 color: Colors.blue,
                                                                 fontSize: 16
                                                             ),
                                                           )),
                                                         )),



                                                       ],
                                                     ),
                                                   ),

                                                   if(cartViewPageController.promoCodeServerResponse==1)...{
                                                     //promo code
                                                     if(cartViewPageController.couponDataList[index].couponStatus=="true")...{


                                                       Padding(padding: EdgeInsets.only(left: 10,right: 10,),
                                                         child:Row(
                                                           // mainAxisAlignment: MainAxisAlignment.center,
                                                           children: [
                                                             const Expanded(
                                                               child:Text("Promo Amount: ",
                                                                 style: TextStyle(fontWeight: FontWeight.w600,
                                                                     color: text_color,
                                                                     fontSize: 15
                                                                 ),
                                                               ),),
                                                             Expanded(child:   Align(
                                                               alignment: Alignment.centerRight,
                                                               child:Obx(()=> Text(
                                                               cartViewPageController.couponDataList[index].couponAmount==""?"\$ 0.0":
                                                                 "\$ "+ cartViewPageController.couponDataList[index].couponAmount.toString(),
                                                                 // totalTaxCalculate(cartViewPageController.cartList,
                                                                 // cartViewPageController.sellerGroupList[index].seller.toString()),
                                                                 style: const TextStyle(fontWeight: FontWeight.w600,
                                                                     color: Colors.blue,
                                                                     fontSize: 16
                                                                 ),
                                                               )),
                                                             )),



                                                           ],
                                                         ),
                                                       ),


                                                     },

                                                   },


                                                   Padding(padding: EdgeInsets.only(left: 10,right: 10,),
                                                     child:  Row(
                                                       // mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         const Expanded(
                                                           child:  Text("Total: ",
                                                             style: TextStyle(fontWeight: FontWeight.w600,
                                                                 color: text_color,
                                                                 fontSize: 15
                                                             ),
                                                           ),),
                                                         Expanded(child:   Align(
                                                           alignment: Alignment.centerRight,
                                                           child:Obx(()=> Text(

                                                             "\$ "+totalPriceWithTaxCalculate(cartViewPageController.cartList,
                                                                 cartViewPageController.sellerGroupList[index].seller.toString()),
                                                             style: TextStyle(fontWeight: FontWeight.w600,
                                                                 color: Colors.blue,
                                                                 fontSize: 16
                                                             ),
                                                           )),
                                                         )),
                                                       ],
                                                     ),
                                                   ),

                                                   SizedBox(height: 15,),

                                                   if(cartViewPageController.promoCodeServerResponse==1)...{
                                                     if(cartViewPageController.couponDataList[index].couponStatus=="true")...{

                                                       Padding(padding: EdgeInsets.only(left: 10,right: 10,),
                                                           child:  Row(
                                                             children: [
                                                              Obx(() =>  Expanded(flex: 2,child: _buildTextFieldPromoCode(
                                                                labelText: "Promo Code", controller: cartViewPageController.textFieldControllers[index],
                                                              ),

                                                              ),),

                                                               SizedBox(width: 15,),
                                                               Expanded(
                                                                 flex: 1,
                                                                 child: ElevatedButton(
                                                                   onPressed: () {

                                                                     if(cartViewPageController.textFieldControllers[index].value.text!=""){

                                                                       // CouponData couponData= CouponData(
                                                                       //     sellerId: cartViewPageController.couponDataList[index].sellerId,
                                                                       //     couponStatus: cartViewPageController.couponDataList[index].couponStatus,
                                                                       //     couponAmount: '',
                                                                       //     couponCode: cartViewPageController.textFieldControllers[index].value.text
                                                                       // );
                                                                       //
                                                                       // cartViewPageController.couponDataList[index]=couponData;

                                                                       // _showToast(totalPriceCalculate(cartViewPageController.cartList,
                                                                       //     cartViewPageController.sellerGroupList[index].seller.toString()));
                                                                       // _showToast(cartViewPageController.couponDataList[index].sellerId);
                                                                       // _showToast(cartViewPageController.couponDataList[index].couponCode);


                                                                       // _showToast(cartViewPageController.couponDataList[index].sellerId);
                                                                       // _showToast(cartViewPageController.textFieldControllers[index].value.text.toString());
                                                                       // _showToast(cartViewPageController.couponDataList[index].couponAmount);


                                                                       cartViewPageController.couponCodeCheckIndividual(
                                                                               token: cartViewPageController.userToken.value,
                                                                               couponCode: cartViewPageController.textFieldControllers[index].value.text.toString(),
                                                                               sellerId: cartViewPageController.couponDataList[index].sellerId,
                                                                               totalAmount: totalPriceCalculate(cartViewPageController.cartList,
                                                                                   cartViewPageController.couponDataList[index].sellerId.toString()), index: index);

                                                                     }else{
                                                                       showToastShort("Enter Coupon Code!");
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
                                                                       padding: EdgeInsets.only(left: 10,right: 10,),
                                                                       height: 45,
                                                                       alignment: Alignment.center,
                                                                       child:  const Text(
                                                                         "Apply",
                                                                         textAlign: TextAlign.center,
                                                                         style: TextStyle(
                                                                           fontFamily: 'PT-Sans',
                                                                           fontSize: 15,
                                                                           fontWeight: FontWeight.w500,
                                                                           color: Colors.white,
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   ),
                                                                 ),
                                                               )

                                                             ],
                                                           )
                                                       ),

                                                     },

                                                   },



                                                   Container(height: 20,)

                                                 ],
                                               ));
                                             }),),
                                       ],
                                     );
                                   }),
                             )
                         ),
                         /// add to cart button section
                         Container(
                           //  height: 50,
                             padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),

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
                             child:Column(
                               children: [
                                 const SizedBox(
                                   height: 10,
                                 ),
                                 // _buildTextFieldPromoCode(
                                 //   obscureText: false,
                                 //   // prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                                 //   labelText: "Promo Code",
                                 // ),
                                 // const SizedBox(
                                 //   height: 20,
                                 // ),
                                 //
                                 // _buildApplyPromoCodeButton(),
                                 // SizedBox(height: 20,),


                                 Row(
                                   // mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Expanded(
                                       child:  Text("Sub Total: ",
                                         style: TextStyle(fontWeight: FontWeight.w600,
                                             color: text_color,
                                             fontSize: 16
                                         ),
                                       ),),
                                     Expanded(child:   Align(
                                       alignment: Alignment.centerRight,
                                       child:Obx(()=> Text(
                                         // j
                                         "\$ "+"${cartViewPageController.totalSuTotalPrice}",
                                         style: TextStyle(fontWeight: FontWeight.w600,
                                             color: Colors.blue,
                                             fontSize: 18
                                         ),
                                       )),
                                     )),



                                   ],
                                 ),
                                 Row(
                                   // mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Expanded(
                                       child:  Text("Total Tax: ",
                                         style: TextStyle(fontWeight: FontWeight.w600,
                                             color: text_color,
                                             fontSize: 16
                                         ),
                                       ),),
                                     Expanded(child:   Align(
                                       alignment: Alignment.centerRight,
                                       child:Obx(()=> Text(
                                         // j
                                         "\$ "+"${cartViewPageController.totalTaxPrice}",
                                         style: TextStyle(fontWeight: FontWeight.w600,
                                             color: Colors.blue,
                                             fontSize: 18
                                         ),
                                       )),
                                     )),



                                   ],
                                 ),

                                 //promo
                                 Obx(() =>Row(
                                   // mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     if(cartViewPageController.couponDataList.length>0)...{

                                       Expanded(
                                         child:  Text("Promo Amount : ",
                                           style: TextStyle(fontWeight: FontWeight.w600,
                                               color: text_color,
                                               fontSize: 16
                                           ),
                                         ),),


                                       Expanded(child:Align(
                                         alignment: Alignment.centerRight,
                                         child:Obx(()=> Text(
                                           // j
                                           "-\$ "
                                               //+"${cartViewPageController.couponAmount}"
                                           +totalPromoAmount(cartViewPageController.couponDataList)
                                           ,
                                           style: TextStyle(fontWeight: FontWeight.w600,
                                               color: Colors.blue,
                                               fontSize: 18
                                           ),
                                         )),
                                       )),


                                     }

                                   ],
                                 ),),

                                 Row(
                                   // mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Expanded(
                                       child:  Text("Total Price: ",
                                         style: TextStyle(fontWeight: FontWeight.w600,
                                             color: text_color,
                                             fontSize: 16
                                         ),
                                       ),),
                                     Expanded(child:   Align(
                                       alignment: Alignment.centerRight,
                                       child:Obx(()=> Text(

                                         "\$ "+"${(double.parse(cartViewPageController.totalPrice.toString())-
                                             double.parse(totalPromoAmount(cartViewPageController.couponDataList))).toString()}",
                                         style: TextStyle(fontWeight: FontWeight.w600,
                                             color: Colors.blue,
                                             fontSize: 18
                                         ),
                                       )),
                                     )),



                                   ],
                                 ),

                                 SizedBox(height: 20,),

                                 Row(
                                   children: [

                                     Expanded(child: _buildProceedToCheckoutButton(),),

                                   ],
                                 ),
                               ],
                             )



                         ),
                       ],
                     ),

                   ):
                   Container(
                     color: Colors.white,
                     child:LayoutBuilder(
                       builder: (context, constraints) => ListView(
                         children: [
                           Container(
                             padding: const EdgeInsets.all(20.0),
                             constraints: BoxConstraints(
                               minHeight: constraints.maxHeight,
                             ),
                             child: Center(
                               child:Column(

                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Image.asset(
                                     "assets/images/not_found.png",
                                     width: 180,
                                     height: 80,
                                   ),
                                   const SizedBox(height: 20,),
                                   const Text(
                                     "Cart list not found!",
                                     overflow: TextOverflow.ellipsis,
                                     softWrap: false,
                                     maxLines: 1,
                                     style: TextStyle(
                                         color:text_color,
                                         fontSize: 15,
                                         decoration: TextDecoration.none,
                                         fontWeight: FontWeight.w500),
                                   )
                                 ],
                               ),
                             ),
                           )
                         ],
                       ),
                     ) ,
                   )
                   ))
                  ],
                )

            )),

          ],
        ),

      ),



    );

  }

  Widget cartItem(CartNote response){
    return InkWell(
      onTap: (){
        // _showToast("seller id "+response.id.toString());
        // _showToast("seller id "+response.seller);
      },
      child:  Padding(padding: const EdgeInsets.only(right:10,top: 10,left: 10,bottom: 20),
        child:  Flex(
          direction: Axis.horizontal,
          children: [

            Container(
              width: 56,
              height: 56,

              margin:const EdgeInsets.only(left:0, top: 00, right: 22, bottom: 00),
              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      height: 56,
                      width: 56,
                      color:hint_color,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.fill,
                        placeholder: 'assets/images/loading.png',
                        image:BASE_URL_API_IMAGE_PRODUCT+response.productPhoto.toString(),
                        imageErrorBuilder: (context, url, error) =>
                            Image.asset(
                              'assets/images/loading.png',
                              fit: BoxFit.fill,
                            ),
                      )),
                ),
              ),

            ),

            Expanded(child:Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child:Text(
                    response.productName,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color:text_color,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // Container(
                //   margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                //   child:  Row(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.only(left: 00,right: 20),
                //         padding: EdgeInsets.all(7),
                //         // height: 80,
                //         width:80,
                //         child: Center(
                //           child: Text(
                //             "10.0% OFF",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 13,
                //                 fontWeight: FontWeight.normal
                //             ),
                //           ),
                //         ),
                //         decoration: BoxDecoration(
                //           color:Colors.blue,
                //           borderRadius: const BorderRadius.only(
                //             bottomRight: Radius.circular(7.0),
                //             bottomLeft: Radius.circular(7.0),
                //             topLeft: Radius.circular(7.0),
                //             topRight: Radius.circular(7.0),
                //           ),
                //           boxShadow: [BoxShadow(
                //
                //             color:Colors.grey.withOpacity(.5),
                //             //  blurRadius: 20.0, // soften the shadow
                //             blurRadius:20, // soften the shadow
                //             spreadRadius: 0.0, //extend the shadow
                //             offset:Offset(
                //               2.0, // Move to right 10  horizontally
                //               1.0, // Move to bottom 10 Vertically
                //             ),
                //           )],
                //         ),
                //       ),
                //       Expanded(child:  Row(
                //         children:  [
                //           Obx(() => Text(
                //             "\$${homeController.productRegularPrice.value}",
                //             overflow: TextOverflow.ellipsis,
                //             style:  TextStyle(
                //                 color: Colors.red,
                //                 fontSize: 13,
                //                 decoration: TextDecoration.lineThrough,
                //                 fontWeight: FontWeight.normal),
                //             softWrap: false,
                //             maxLines: 1,
                //           ),),
                //           SizedBox(width: 10,),
                //
                //           Obx(() =>  Text(
                //             "\$${homeController.productDiscountedPrice.value}",
                //             overflow: TextOverflow.ellipsis,
                //             style:  TextStyle(
                //                 color: Colors.blue,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w600),
                //             softWrap: false,
                //             maxLines: 1,
                //           ))
                //         ],
                //       ))
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 5,
                ),

                Row(
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 5,left: 10,right: 10),
                      height: 25,
                      child: Row(
                        children: [

                          Text("\$"+
                              response.productDiscountedPrice,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: fnf_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),

                          SizedBox(width: 10,),

                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: (){

                                if(int.parse(response.productQuantity)>1){

                                  CartNote cartNote=CartNote(
                                      id:response.id ,
                                      productId: response.productId,
                                      productName: response.productName,
                                      productRegularPrice: response.productRegularPrice,
                                      productDiscountedPrice: response.productDiscountedPrice,
                                      productPhoto: response.productPhoto,
                                      productQuantity: (int.parse(response.productQuantity)-1).toString(),
                                      weight: response.weight,
                                      seller: response.seller,
                                      sellerName: response.sellerName,
                                      slug: response.slug,
                                      colorImage: response.colorImage,
                                      size: response.size,
                                      color: response.color,
                                      shipping: response.shipping,
                                      shippingName: response.shippingName,
                                      sizeId: response.sizeId,
                                      colorId: response.colorId,
                                      grocery: response.grocery,
                                      tax: response.tax,
                                      width: response.width,
                                      height: response.height,
                                      depth: response.depth,
                                      weightOption: response.weightOption,
                                      commission: response.commission,
                                      commissionType:response.commissionType
                                  );
                                  cartViewPageController.updateNotes(cartNote);
                                }else{

                                //  _showToast("")
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

                          Text(
                            response.productQuantity.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600,
                                color: text_color,
                                fontSize: 15
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: (){
                                // productDetailsController.productQuantity++;

                                CartNote cartNote=CartNote(
                                    id:response.id ,
                                    productId: response.productId,
                                    productName: response.productName,
                                    productRegularPrice: response.productRegularPrice,
                                    productDiscountedPrice: response.productDiscountedPrice,
                                    productPhoto: response.productPhoto,
                                    productQuantity: (int.parse(response.productQuantity)+1).toString(),
                                    weight: response.weight,
                                    seller: response.seller,
                                    sellerName: response.sellerName,
                                    slug: response.slug,
                                    colorImage: response.colorImage,
                                    size: response.size,
                                    color: response.color,
                                    shipping: response.shipping,
                                    shippingName: response.shippingName,
                                    sizeId: response.sizeId,
                                    colorId: response.colorId,
                                    grocery: response.grocery,
                                    tax: response.tax,
                                    width: response.width,
                                    height: response.height,
                                    depth: response.depth,
                                    weightOption: response.weightOption,
                                    commission: response.commission,
                                    commissionType:response.commissionType
                                    );
                                cartViewPageController.updateNotes(cartNote);

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
                          ),

                          SizedBox(width: 10,),

                          Text("\$"+ (double.parse(response.productDiscountedPrice)* double.parse(response.productQuantity)).toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: fnf_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),

                          // Text("   \$"+ response.tax.toString(),
                          //   textAlign: TextAlign.center,
                          //   style: const TextStyle(
                          //       color: fnf_color,
                          //       fontSize: 13,
                          //       fontWeight: FontWeight.w400),
                          // )

                        ],
                      ) ,
                    ),
                  ],
                ),

                // Row(
                //   children: [
                //
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text(
                //         response.productQuantity+" X ",
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(
                //             color: hint_color,
                //             fontSize: 13,
                //             fontWeight: FontWeight.w400),
                //       ),
                //     ),
                //     Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text("\$"+
                //         response.productDiscountedPrice,
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(
                //             color: fnf_color,
                //             fontSize: 13,
                //             fontWeight: FontWeight.w400),
                //       ),
                //     ),
                //   ],
                // )


              ],
            ),),

            IconButton(
              iconSize: 22,
              color: fnf_color,
              icon: const Icon(Icons.delete),
              onPressed: () {
                //_showToast( response.id.toString());
                // response.id
                cartViewPageController.deleteNotes(int.parse(response.id.toString()));
              },
            ),

          ],
        ),
      ),
    );
  }

  //user name input field create
  Widget _buildTextFieldPromoCode({
    String? hintText,
    String? labelText,
    required TextEditingController controller
  }) {
    return Container(
      color:transparent,
      child: Focus(
        onFocusChange: (hasFocus) {
          cartViewPageController.inputLevelTextColor.value = hasFocus ? hint_color : hint_color;
        },

        child: TextField(
          cursorColor: awsCursorColor,
          cursorWidth: 1.5,


          // maxLength: 13,
          // autofocus: false,

          onSubmitted:(_){

          },
          controller: controller,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 15),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            // contentPadding: const EdgeInsets.all(17),
            contentPadding:  EdgeInsets.only(left: 15, right: 15,top: height/60,bottom:height/60 ),

            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
            ),
            labelStyle: TextStyle(
              color:cartViewPageController.inputLevelTextColor.value,
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: hint_color,
              fontWeight: FontWeight.normal,
              fontFamily: 'PTSans',
            ),
          ),
          keyboardType: TextInputType.text,

          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
          //   LengthLimitingTextInputFormatter(
          //     13,
          //   ),
          // ],
        ),
      ),
    );
  }

  Widget _buildProceedToCheckoutButton() {
    return ElevatedButton(
      onPressed: () {
       // _showToast(cartViewPageController.userToken.value);

        if(cartViewPageController.userToken.isNotEmpty &&
            cartViewPageController.userToken.value!=null){


          // Get.to(CheckoutPage());

          Get.to(() => CheckoutPage(), arguments: [
            {"couponCodes": cartViewPageController.couponCodes.value},
            {"couponAmount": totalPromoAmount(cartViewPageController.couponDataList)},
            {"couponSellerId": cartViewPageController.couponSellerId.value},
            {"couponInfoList": cartViewPageController.couponDataList},
          ])?.then((value) => Get.delete<CartViewPageController>());




        }else{
          showLoginWarning();
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
          padding: EdgeInsets.only(left: 20,right: 20),
          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "PROCEED TO CHECKOUT",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplyPromoCodeButton() {
    return ElevatedButton(
      onPressed: () {
        // _showToast(cartViewPageController.userToken.value);

        if(cartViewPageController.userToken.isNotEmpty &&
            cartViewPageController.userToken.value!=null){
          String couponCode=cartViewPageController.promoCodeController.value.text;
          if(couponCode.isNotEmpty){
            List<CheckPromoCode> checkPromoCodeDataList = [];
            for(int i=0;i<cartViewPageController.sellerGroupList.length;i++){
              checkPromoCodeDataList.add(CheckPromoCode(
                  sellerId: cartViewPageController.sellerGroupList[i].seller.toString(),
                  buyedAmount:totalPriceCalculate(cartViewPageController.cartList,
                      cartViewPageController.sellerGroupList[i].seller.toString()).toString()
              ) );
            }
            var checkPromoCodeDataListJson = checkPromoCodeDataList.map((e){
              return {
                "seller_id": e.sellerId,
                "buyed_amount": e.buyedAmount
              };
            }).toList();
            cartViewPageController.couponCodeCheck(
                token: cartViewPageController.userToken.value,
                couponCode: couponCode,
                couponInfoJson: checkPromoCodeDataListJson);

          }else{
            showToastShort("Please Enter Promo Code!");
          }


        }else{
          showLoginWarning();
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
          padding: EdgeInsets.only(left: 20,right: 20),
          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "Apply Promo Code",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplyPromoCodeButton2() {
    return ElevatedButton(
      onPressed: () {
        // _showToast(cartViewPageController.userToken.value);

        if(cartViewPageController.userToken.isNotEmpty &&
            cartViewPageController.userToken.value!=null){
          String couponCode=cartViewPageController.promoCodeController.value.text;
          if(couponCode.isNotEmpty){
            List<CheckPromoCode> checkPromoCodeDataList = [];
            for(int i=0;i<cartViewPageController.sellerGroupList.length;i++){
              checkPromoCodeDataList.add(CheckPromoCode(
                  sellerId: cartViewPageController.sellerGroupList[i].seller.toString(),
                  buyedAmount:totalPriceCalculate(cartViewPageController.cartList,
                      cartViewPageController.sellerGroupList[i].seller.toString()).toString()
              ) );
            }
            var checkPromoCodeDataListJson = checkPromoCodeDataList.map((e){
              return {
                "seller_id": e.sellerId,
                "buyed_amount": e.buyedAmount
              };
            }).toList();
            cartViewPageController.couponCodeCheck(
                token: cartViewPageController.userToken.value,
                couponCode: couponCode,
                couponInfoJson: checkPromoCodeDataListJson);

          }else{
            showToastShort("Please Enter Promo Code!");
          }


        }else{
          showLoginWarning();
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
          padding: EdgeInsets.only(left: 20,right: 20),
          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "Apply Promo Code",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String totalPriceCalculate(List cartList1, String sellerId){
   // j
    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      if(sellerId==cartList1[i].seller.toString()){
        double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
        subTotal=(subTotal+oneItemPrice);
      }
    }

    return double.parse((subTotal).toStringAsFixed(2)).toString();
    return subTotal.toString();
  //  totalPrice(subTotal);

  }

  String totalTaxCalculate(List cartList1, String sellerId){
   // j
    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      if(sellerId==cartList1[i].seller.toString()){
        double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);

        double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
        totalTax=(totalTax+singleProductTax);
      }
    }
    return double.parse((totalTax).toStringAsFixed(2)).toString();
    // return totalTax.toString();
  //  totalPrice(subTotal);

  }

  String totalPriceWithTaxCalculate(List cartList1, String sellerId){
    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      if(sellerId==cartList1[i].seller.toString()){
        double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
        subTotal=(subTotal+oneItemPrice);
      }
    }

    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      if(sellerId==cartList1[i].seller.toString()){
        double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);

        double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
        totalTax=(totalTax+singleProductTax);
      }
    }

    return ( double.parse((totalTax).toStringAsFixed(2))+double.parse((subTotal).toStringAsFixed(2))).toString();

      (totalTax+subTotal).toString();

  }


  String totalPromoAmount(List list ){

    double totalPromoAmount=0.0;

    for(int i=0;i<list.length;i++){
      if(list[i].couponAmount!=""){
        totalPromoAmount=totalPromoAmount+ double.parse(list[i].couponAmount);
      }
    }

    return totalPromoAmount.toString();
  }



}

class CheckPromoCode{
String sellerId;
String buyedAmount;
CheckPromoCode({
  required this.sellerId,
  required this.buyedAmount,

});
}





