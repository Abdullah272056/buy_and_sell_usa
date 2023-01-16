import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../controller/cart_controller/cart__view_page_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../static/Colors.dart';
import '../auth/log_in_page.dart';
import '../auth/sign_up_page.dart';
import '../checkout step/checkout_page.dart';


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
      body:Container(
          decoration: BoxDecoration(
            color:fnf_title_bar_bg_color,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 22,
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
                ],
              ),
              Expanded(child: Container(
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
                                          return Column(
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
                                              Padding(padding: EdgeInsets.only(left: 10,right: 10,),
                                                child:  Row(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
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

                                              Container(height: 20,)
                                            ],
                                          );
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
                          _buildTextFieldPromoCode(
                            obscureText: false,
                           // prefixedIcon: const Icon(Icons.person, color: input_box_icon_color),
                            labelText: "Promo Code",
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          _buildApplyPromoCodeButton(),
                          SizedBox(height: 20,),
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
                                  // j
                                  "\$ "+"${cartViewPageController.totalPrice}",
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

              ))
            ],
          )

      )
    );

  }

  Widget cartItem(CartNote response){
    return InkWell(
      onTap: (){
        _showToast("seller id "+response.id.toString());
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
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
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
          controller: cartViewPageController.promoCodeController.value,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            // contentPadding: const EdgeInsets.all(17),
            contentPadding:  EdgeInsets.only(left: 17, right: 17,top: height/50,bottom:height/50 ),

            prefixIcon: prefixedIcon,
            prefixIconColor: input_box_icon_color,

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
            {"couponAmount": cartViewPageController.couponAmount.value},
            {"couponSellerId": cartViewPageController.couponSellerId.value},
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
            _showToast("Please Enter Promo Code!");
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

  void showLoginWarning( ) {

    Get.defaultDialog(
        contentPadding: EdgeInsets.zero,

        //  title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [

            Stack(
              children: [
                Container(

                    child:   Center(
                      child: Column(
                        children: [

                          Container(

                            margin:EdgeInsets.only(right:00.0,top: 0,left: 00,
                              bottom: 0,
                            ),
                            child:Image.asset(
                              "assets/images/fnf_logo.png",
                              // color: sohojatri_color,
                              // width: 81,
                              height: 40,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child:   Text(
                                "This section is Locked",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Go to login or Sign Up screen \nand try again ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.to(SignUpScreen());

                                //  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));

                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              child: Ink(

                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [sohojatri_color, sohojatri_color],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                child: Container(

                                  height: 40,
                                  alignment: Alignment.center,
                                  child:  Text(
                                    "SIGN UP",
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
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 0),
                            child: InkWell(
                              onTap: (){
                                Get.back();
                                Get.to(LogInScreen());
                                //   Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                height: 40,
                                alignment: Alignment.center,
                                child:  Text(
                                  "LOG IN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PT-Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: sohojatri_color,
                                  ),
                                ),
                              ),
                            ),
                          )
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

}

class CheckPromoCode{
String sellerId;
String buyedAmount;
CheckPromoCode({
  required this.sellerId,
  required this.buyedAmount,

});
}





