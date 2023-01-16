
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/checkout%20step/webview_page_payment.dart';

import 'package:get/get.dart';

import '../../controller/checkout_step_controller/checkout_page_step2_controller.dart';
import '../../controller/checkout_step_controller/web_view_page_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../../static/Colors.dart';

import '../auth/log_in_page.dart';
import '../auth/sign_up_page.dart';



class CheckoutPageStep2Page extends StatelessWidget {

  final cartViewPageController = Get.put(CheckoutPageStep2Controller());

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
                    "CHECKOUT ORDER",
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
                                        itemCount: cartViewPageController.sellerGroupList.isNotEmpty?cartViewPageController.sellerGroupList.length:0,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index){
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

                                             Obx(() =>ListView.builder(
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

                                             Obx(()=> cartViewPageController.expressShippingCheckList!=null && cartViewPageController.expressShippingCheckList.length>0?
                                              userShippingSelect(
                                                  response: cartViewPageController.expressShippingCheckList[index], index: index, sellerId: cartViewPageController.sellerGroupList[index].seller.toString()):Container(),),

                                             Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 15),
                                                child:  Row(
                                                  children: [
                                                    const Expanded(
                                                      child:  Text("Total Shipping: ",
                                                        style: TextStyle(fontWeight: FontWeight.w600,
                                                            color: text_color,
                                                            fontSize: 15
                                                        ),
                                                      ),),
                                                    Expanded(child:   Align(
                                                      alignment: Alignment.centerRight,
                                                      child:Obx(()=> Text(
                                                        "\$ ${totalShippingPriceCalculate(cartViewPageController.cartList,
                                                            cartViewPageController.sellerGroupList[index].seller.toString())}",
                                                        style: const TextStyle(fontWeight: FontWeight.w600,
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


                                    const SizedBox(height: 30,),

                                    Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 0),
                                      child:  Row(
                                        children: [
                                          Expanded(child: Align(
                                            alignment: Alignment.topLeft,
                                            child:  Text("Your Orders",
                                              style: TextStyle(
                                                  color:text_color,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              // textAlign: TextAlign.left,

                                            ),
                                          ),),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20,),


                                    Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 0),
                                      child:  Row(
                                        children: const [
                                          Expanded(child: Align(
                                            alignment: Alignment.topLeft,
                                            child:  Text("Product",
                                              style: TextStyle(
                                                  color:text_color,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                              // textAlign: TextAlign.left,

                                            ),
                                          ),),
                                        ],
                                      ) ,
                                    ),

                                    Obx(() =>ListView.builder(
                                        padding: EdgeInsets.only(left: 10),
                                        itemCount: cartViewPageController.cartList.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return cartItem2(cartViewPageController.cartList[index]);
                                        }),),

                                    Row(
                                      children: [
                                        Expanded(child: Container(height: .8,
                                          color: Colors.black,
                                        ))
                                      ],
                                    ),

                                    Padding(padding: EdgeInsets.only(left: 20,right: 10,top: 10),
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
                                              child: Obx(()=> Text(
                                                "\$ "+ "${cartViewPageController.allSubTotal.value}",
                                                style: TextStyle(fontWeight: FontWeight.w600,
                                                    color: Colors.blue,
                                                    fontSize: 16
                                                ),
                                              )),



                                          )),



                                        ],
                                      ) ,
                                    ),

                                    Padding(padding: EdgeInsets.only(left: 20,right: 10,top: 10),
                                      child: Row(
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
                                              "\$ "+
                                               //   allTaxCalculate(cartViewPageController.cartList),

                                              "${cartViewPageController.allTaxAmount}",
                                              // totalPriceCalculate(cartViewPageController.cartList,
                                              // cartViewPageController.sellerGroupList[index].seller.toString()),

                                              style: TextStyle(fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                  fontSize: 16
                                              ),
                                            )),
                                          )),



                                        ],
                                      ) ,
                                    ),

                                    //promo
                                    Obx(() =>
                                        Padding(padding: EdgeInsets.only(left: 20,right: 10,top: 10),
                                          child:  Row(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              if(cartViewPageController.couponAmount!="")...{

                                                Expanded(
                                                  child:  Text("Promo Amount : ",
                                                    style: TextStyle(fontWeight: FontWeight.w600,
                                                        color: text_color,
                                                        fontSize: 16
                                                    ),
                                                  ),),
                                                Expanded(child:   Align(
                                                  alignment: Alignment.centerRight,
                                                  child:Obx(()=> Text(
                                                    // j
                                                    "-\$ "+"${cartViewPageController.couponAmount}",
                                                    style: TextStyle(fontWeight: FontWeight.w600,
                                                        color: Colors.blue,
                                                        fontSize: 18
                                                    ),
                                                  )),
                                                )),
                                              }




                                            ],
                                          ),
                                        ),
                                    ),

                                    Padding(padding: EdgeInsets.only(left: 20,right: 10,top: 10),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child:  Text("Shipping: ",
                                              style: TextStyle(fontWeight: FontWeight.w600,
                                                  color: text_color,
                                                  fontSize: 15
                                              ),
                                            ),),
                                          Expanded(child:   Align(
                                            alignment: Alignment.centerRight,

                                            child:Obx(()=> Text(
                                              "\$ "+
                                                  //   allTaxCalculate(cartViewPageController.cartList),

                                                  "${cartViewPageController.allShippingAmount}",
                                              // totalPriceCalculate(cartViewPageController.cartList,
                                              // cartViewPageController.sellerGroupList[index].seller.toString()),

                                              style: TextStyle(fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                  fontSize: 16
                                              ),
                                            )),
                                          )),



                                        ],
                                      ) ,
                                    ),

                                    Padding(padding: EdgeInsets.only(left: 20,right: 10,top: 10),
                                      child: Row(
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

                                              cartViewPageController.couponAmount!=""?
                                              "\$ "+"${(
                                                  double.parse((cartViewPageController.allTotalAmountWithAllCost.value))-
                                                  double.parse(cartViewPageController.couponAmount.toString())).toString()}":

                                              "\$ "+
                                                  "${cartViewPageController.allTotalAmountWithAllCost.value}",

                                              style: TextStyle(fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                  fontSize: 16
                                              ),
                                            )),

                                          )),



                                        ],
                                      ) ,
                                    ),


                                  ],
                                );
                              }),
                        )
                    ),

                    SizedBox(height: 20,),

                    /// add to cart button section
                    Container(
                    //  height: 50,
                      padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 15),

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
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(child: _buildPlaceOrderButton(),),

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

  Widget cartItem2(CartNote response){
    return  Padding(padding: const EdgeInsets.only(right:10,top: 8,left: 10,bottom: 8),
      child: Row(

        children: [

          Text(
            response.productQuantity.toString()+" x ",
            // response.productName,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: TextStyle(
                color:text_color,
                fontSize: 14,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
          Expanded(child:   Text(
            response.productName,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            style: TextStyle(
                color:text_color,
                fontSize: 14,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),),
          SizedBox(width: 10,),
          Text(
            "\$ "+"${double.parse(response.productQuantity)*double.parse(response.productDiscountedPrice)}",
            // totalPriceCalculate(cartViewPageController.cartList,
            // cartViewPageController.sellerGroupList[index].seller.toString()),

            style: TextStyle(fontWeight: FontWeight.w600,
                color: Colors.blue,
                fontSize: 16
            ),
          )


        ],
      ),
    );
  }

  Widget cartItem(CartNote response){
    return InkWell(
      onTap: (){
        _showToast("seller id "+response.id.toString());
        // _showToast("seller id "+response.seller);
      },
      child:  Padding(padding: const EdgeInsets.only(right:10,top: 10,left: 10,bottom: 10),
        child:  Flex(
          direction: Axis.horizontal,
          children: [

            Expanded(child: Column(
              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child:Row(
                    children: [
                      Text(
                        response.productQuantity.toString()+" x ",
                        // response.productName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color:text_color,
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(child:Text(
                        response.productName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color:text_color,
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),),
                    ],
                  )


                  // Text(
                  //   response.productName,
                  //   overflow: TextOverflow.ellipsis,
                  //   softWrap: false,
                  //   maxLines: 1,
                  //   style: TextStyle(
                  //       color:text_color,
                  //       fontSize: 15,
                  //       decoration: TextDecoration.none,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ),

                Row(
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 5,left: 10,right: 10),
                     // height: 25,
                      child: Row(
                        children: [

                          Text("Subtotal: ",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: hint_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),

                          SizedBox(width: 10,),

                          Text(
                            "\$ "+"${double.parse(response.productQuantity)*double.parse(response.productDiscountedPrice)}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: hint_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),

                        ],
                      ) ,
                    ),
                  ],
                ),



                Row(
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 5,left: 10,right: 10),
                     // height: 25,
                      child: Row(
                        children: [
                          Text("Shipping Amount: ",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: hint_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
                          ),

                          SizedBox(width: 10,),

                          if(response.shipping!="")...{

                            Text("\$"+ response.shipping,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: hint_color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),

                          }
                          else...{
                            Text("\$"+ "0.0",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: hint_color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          }
                        ],
                      ) ,
                    ),
                  ],
                ),

              ],
            ),),

          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return ElevatedButton(
      onPressed: () {


        for(int i=0; i<cartViewPageController.selectedShippingValueList.length;i++){
          if(cartViewPageController.selectedShippingValueList[i]==""){
            _showToast("Select all shipping!");
           return;
          }

        }



        String paymentLink="https://fnfbuy.bizoytech.com/api/payment-api?surname=${cartViewPageController.surName}&"
            "email=${cartViewPageController.emailAddress}&mobile=${cartViewPageController.mobileNumber}&amount=${cartViewPageController.allTotalAmountWithAllCost}";

        Get.to(()=>
            WebviewPaymentScreen(
            productId: '',
            zipCode: cartViewPageController.zipCode.value,
            surName: cartViewPageController.surName.value,
            mobileNumber:cartViewPageController.mobileNumber.value,
            totalAmountWithTax: cartViewPageController.totalAmountWithTax.value,
            emailAddress: cartViewPageController.emailAddress.value,
            paymentLink: paymentLink,
            couponCodes: cartViewPageController.couponCodes.value,
            couponAmount: cartViewPageController.couponAmount.value,
            couponSellerId: cartViewPageController.couponSellerId.value,
        ));



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
            "PLACE ORDER",
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

    return totalTax.toString();
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

    return (totalTax+subTotal).toString();

  }

  String allSubTotalCalculate(List cartList1){
    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
      subTotal=(subTotal+oneItemPrice);
    }
    return subTotal.toString();

  }

  String allTaxCalculate(List cartList1){
    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);

      double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
      totalTax=(totalTax+singleProductTax);
    }
    return totalTax.toString();

  }

  String totalShippingPriceCalculate(List cartList1, String sellerId){
    double shippingAmount=0.0;
    for(int i=0;i<cartList1.length;i++){
      if(sellerId==cartList1[i].seller.toString()){
        shippingAmount=(shippingAmount+double.parse(cartList1[i].shipping));
      }
    }
    return shippingAmount.toString();
  }

  Widget userShippingSelect({required List response,required int index, required String sellerId}) {
    return Column(
      children: [
        Container(
          // height: 50,
            alignment: Alignment.center,
             margin: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20,),
            decoration: BoxDecoration(
                color:Colors.white,
                border: const Border(
                  left: BorderSide(width: 1.0, color: hint_color),
                  right: BorderSide(width:1.0, color: hint_color),
                  bottom: BorderSide(width: 1.0, color: hint_color),
                  top: BorderSide(width: 1.0, color: hint_color),
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Obx(()=>DropdownButton2(
              //  buttonHeight: 40,
              //   menuMaxHeight:55,
              itemPadding: EdgeInsets.only(left: 5,right: 0),
              value: cartViewPageController.selectedShippingValueList[index].isNotEmpty ?
              cartViewPageController.selectedShippingValueList[index].toString() : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 5,),
                  Expanded(child: Center(child: Text("Selected Shipping",
                      style: TextStyle(
                          color: hint_color,
                          fontSize: 15,
                          fontWeight: FontWeight.normal)),))
                ],
              ),
              isExpanded: true,
              /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 0),

              items: response.map((list) {
                return DropdownMenuItem(
                  alignment: Alignment.center,

                  // Text(list["country_name"].toString()),
                  value: list["shipping_type"].toString(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Expanded(child: Center(
                        child: Text(
                            list["shipping_name"].toString(),
                            textAlign: TextAlign.center,
                            style:  const TextStyle(
                                color: text_color,
                                //color: intello_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ),),

                    ],
                  ),
                );

              },
              ).toList(),
              onChanged:(String? value){


                cartViewPageController.selectedShippingValueList[index]=value.toString();
              // _showToast("sellerid= "+sellerId);
                List<Product> products = [];

                for(int i=0;i<cartViewPageController.cartList.length;i++){
                  if(sellerId==cartViewPageController.cartList[i].seller.toString()){
                  //  _showToast("weight= " +cartViewPageController.cartList[i].weight.toString());
                    products.add(Product(
                        product_id: cartViewPageController.cartList[i].productId,
                        weight:cartViewPageController.cartList[i].weight ));
                  //  _showToast("id= " +cartViewPageController.cartList[i].productId.toString());
                  //  _showToast("weight= " +cartViewPageController.cartList[i].weight.toString());
                  }
                }

              // _showToast("abs= " +products.length.toString());


                var indivitualSellerProductListJson = products.map((e){
                  return {
                    "product_id": e.product_id,
                    "weight": e.weight
                  };
                }).toList();

                // list["shipping_name"]
            //   _showToast("abs= "  +value.toString());

                cartViewPageController.expressShippingCheckAmount(
                  token: cartViewPageController.userToken.value,
                //  token: '19|hrU6XnznlpR16wyNUF1b65puSi1Z55cqVvMcVcfD',
                  shippingType: cartViewPageController.selectedShippingValueList[index],
                  shippingId: "null",
                  sellerId: sellerId,
                  totalPrice: totalPriceCalculate(cartViewPageController.cartList,
                      sellerId).toString(),
                  productJson: indivitualSellerProductListJson,

                );



              },

            ))
        ),

      ],
    )
    ;
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
        titleStyle: const TextStyle(fontSize: 0),
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

                            margin:const EdgeInsets.only(right:00.0,top: 0,left: 00,
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
                            margin: const EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  const Align(
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

