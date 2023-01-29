import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/order/vendor/vendor_order_details_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../api_service/api_service.dart';
import '../../../controller/order_controller/order_page_controller.dart';
import '../../../controller/order_controller/vendor_order_controller/vendor_order_details_page_controller.dart';
import '../../../controller/order_controller/vendor_order_controller/vendor_order_page_controller.dart';
import '../../../controller/product_controller/product_details_controller.dart';
import '../../../data_base/sqflite/note.dart';
import '../../../../static/Colors.dart';


import '../../drawer/custom_drawer.dart';
import '../../drawer/vendor_custom_drawer.dart';
import '../../shimer/product_shimmir.dart';
import '../order_details_page.dart';

class VendorOrderPage extends StatelessWidget {

  final vendorOrderPageController = Get.put(VendorOrderPageController());
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: _drawerKey,
        drawer: VendorCustomDrawer(),
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
                  SizedBox(width: 10,),


                  IconButton(
                    iconSize: 25,
                    icon:Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_drawerKey.currentState!.isDrawerOpen) {
                        vendorOrderPageController.isDrawerOpen(false);
                        _drawerKey.currentState!.openEndDrawer();
                        return;
                      } else
                        _drawerKey.currentState!.openDrawer();
                      vendorOrderPageController.isDrawerOpen(true);
                    },
                  ),
                  SizedBox(width: 5,),
                  Expanded(child: Text(
                    "MY ORDER",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )),


                ],
              ),
              SizedBox(height: 10,),
              Expanded(child: Container(
                color: Colors.white,

                child: Column(
                  children: [

                    Expanded(
                      child:
                      Container(
                          color: Colors.white,

                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Obx(() =>   _buildTotalCalculationItem(
                                    item_marginLeft: 20,
                                    item_marginRight: 10,
                                    name: "Sell Today",
                                    value:vendorOrderPageController.sellTodayAmount.value ,
                                  )),

                                  Obx(() =>  _buildTotalCalculationItem(
                                    item_marginLeft: 10,
                                    item_marginRight: 20,
                                    name: "Order Today",
                                    value:vendorOrderPageController.orderTodayCount.value ,
                                  ),)

                                ],
                              ),
                              Row(
                                children: [
                                  Obx(() => _buildTotalCalculationItem(
                                    item_marginLeft: 20,
                                    item_marginRight: 10,
                                    name: "Total Sell",
                                    value:vendorOrderPageController.totalSellAmount.value ,
                                  ),),

                                  Obx(() => _buildTotalCalculationItem(
                                    item_marginLeft: 10,
                                    item_marginRight: 20,
                                    name: "Total Order",
                                    value:vendorOrderPageController.totalOrderCount.value ,
                                  ),)

                                ],
                              ),

                              Expanded(child:
                              Obx(() => vendorOrderPageController.isFirstLoadRunning==true? Center(
                                child: CircularProgressIndicator(),
                              ):
                              Column(
                                children: [
                                  Expanded(child:
                                  Obx(() =>
                                      // GridView.builder(
                                      //     itemCount:vendorOrderPageController.myOrderList.length,
                                      //     // shrinkWrap: true,
                                      //     // physics: const ClampingScrollPhysics(),
                                      //     controller: vendorOrderPageController.controller,
                                      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      //         crossAxisCount: 2,
                                      //         crossAxisSpacing: 7.0,
                                      //         mainAxisSpacing: 7.0,
                                      //         mainAxisExtent: 250
                                      //     ),
                                      //     itemBuilder: (BuildContext context, int index) {
                                      //       return  productCardItemDesign(height: 00, width: MediaQuery.of(context).size.width, index: index,
                                      //           response: allProductListPageController.allProductList[index]);
                                      //     }),
                                    ListView.builder(
                                        controller: vendorOrderPageController.controller,
                                        padding: EdgeInsets.zero,
                                        itemCount:vendorOrderPageController.myOrderList.length,
                                        // shrinkWrap: true,
                                        // physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return orderItem(vendorOrderPageController.myOrderList[index]);
                                        }),

                                  )
                                  ),
                                  Obx(() =>
                                  vendorOrderPageController.isMoreLoadRunning==true?Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 20),
                                    child: Center(
                                        child: LinearProgressIndicator()
                                    ),
                                  ):Container()

                                  )

                                ],
                              )

                              ),),


                              // ListView.builder(
                              //     padding: EdgeInsets.zero,
                              //     itemCount:1,
                              //     shrinkWrap: true,
                              //     physics: const NeverScrollableScrollPhysics(),
                              //     itemBuilder: (BuildContext context, int index) {
                              //       return Column(
                              //         children: [
                              //           ListView.builder(
                              //               padding: EdgeInsets.zero,
                              //               itemCount: 10,
                              //               shrinkWrap: true,
                              //               physics: const NeverScrollableScrollPhysics(),
                              //               itemBuilder: (BuildContext context, int index) {
                              //                 return orderItem("sd");
                              //               }),
                              //         ],
                              //       );
                              //     }),
                            ],
                          )




                      ),

                    ),

                  ],
                ),

              ))
            ],
          )

      )
    );

  }

  Widget orderItem(var response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 0),
      child: InkWell(
        onTap: (){

          Get.to(() => VendorOrderDetailsPage(),
              arguments: [{"singleOrderDetailsData": response}]

          )?.then((value) => Get.delete<VendorOrderDetailsPageController>());

        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [

                SizedBox(width: 5,),

                Expanded(child:Column(
                  children: [

                    Row(
                      children: [
                        Text(
                          "Date: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:fnf_small_text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(width: 10,),
                        Text(
                            dateFormat(response["created_at"].toString()),
                          // "05-Jan-2023",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [
                        Text(
                          "ID: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:fnf_small_text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          response["order_id"].toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [

                        Text(
                          "Order By:",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:fnf_small_text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),

                        SizedBox(width: 10,),

                        Text(
                          response["billings"]["first_name"].toString()+" "+ response["billings"]["last_name"].toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),

                      ],
                    ),

                    SizedBox(height: 5,),

                    // Row(
                    //   children: [
                    //     Text(
                    //       "Total: ",
                    //       overflow: TextOverflow.ellipsis,
                    //       softWrap: false,
                    //       maxLines: 1,
                    //       style: TextStyle(
                    //           color:fnf_small_text_color,
                    //           fontSize: 15,
                    //           decoration: TextDecoration.none,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //     SizedBox(width: 10,),
                    //     Text(
                    //       "\$"+response["total"].toString(),
                    //       overflow: TextOverflow.ellipsis,
                    //       softWrap: false,
                    //       maxLines: 1,
                    //       style: TextStyle(
                    //           color:text_color,
                    //           fontSize: 15,
                    //           decoration: TextDecoration.none,
                    //           fontWeight: FontWeight.normal),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      children: [
                        Text(
                          "Status: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:fnf_small_text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          response["status"].toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:response["status"].toString().toLowerCase()=="complete"?Colors.green:fnf_color,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                  ],
                ),),

                Container(
                  child: Column(
                    children: [

                      // IconButton(
                      //   iconSize: 20,
                      //   color: hint_color,
                      //   icon:Icon(Icons.edit),
                      //   onPressed: () {
                      //     vendorOrderPageController.selectStateId("Pending");
                      //     if(response["status"].toString().toLowerCase()!="complete"){
                      //       openBottomSheet(response);
                      //     }
                      //
                      //   },
                      // ),

                      Text(
                        "\$"+response["total"].toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color:fnf_color,
                            fontSize: 16,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w700),
                      ),

                    ],
                  ),
                )

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: Container(
                  height: .5,
                  color:fnf_color,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget orderItem1(var response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 0),
      child: InkWell(
        onTap: (){

          Get.to(() => VendorOrderDetailsPage(),
              arguments: [{"singleOrderDetailsData": response}]

          )?.then((value) => Get.delete<VendorOrderDetailsPageController>());

        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [

                SizedBox(width: 15,),

                Expanded(child:Column(
                  children: [

                    Row(
                      children: [
                        Text(
                          "Date: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          dateFormat(response["created_at"].toString()),
                          // "05-Jan-2023",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [
                        Text(
                          "ID: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          response["order_id"].toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [

                        Text(
                          "Order By:",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),

                        SizedBox(width: 10,),

                        Text(
                          response["billings"]["first_name"].toString()+" "+ response["billings"]["last_name"].toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),

                      ],
                    ),

                    SizedBox(height: 5,),

                    Row(
                      children: [
                        Text(
                          "Total: ",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "\$"+response["total"].toString(),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),

                  ],
                ),),

                Container(
                  child: Column(
                    children: [

                      // IconButton(
                      //   iconSize: 20,
                      //   color: hint_color,
                      //   icon:Icon(Icons.edit),
                      //   onPressed: () {
                      //     vendorOrderPageController.selectStateId("Pending");
                      //     if(response["status"].toString().toLowerCase()!="complete"){
                      //       openBottomSheet(response);
                      //     }
                      //
                      //   },
                      // ),

                      Text(
                        response["status"].toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color:response["status"].toString().toLowerCase()=="complete"?Colors.green:fnf_color,
                            fontSize: 13,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w600),
                      ),

                    ],
                  ),
                )

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: Container(
                  height: .5,
                  color:fnf_color,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }


  String dateFormat(String dateString){

    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateString);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd-MMM-yyyy  hh:mm aa');
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  //join now url page redirect

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

  void openBottomSheet(var response) {
    Get.bottomSheet(
        ListView(
          padding: EdgeInsets.only(left: 20,right: 20),
          shrinkWrap: true,
          children: [
            Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   InkResponse(
                     onTap: (){
                      Get.back();
                     },
                     child: Icon(
                       Icons.arrow_drop_down,
                     color: hint_color,
                     size: 40,
                   ),
                   )
                  ],

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Order Status".toString(),
                      style: TextStyle(
                          color:fnf_color,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500),
                    ),
                  ],

                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Text(
                      "ID: ",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                          color:text_color,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      response["order_id"].toString(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                          color:text_color,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text(
                      "Order By: ",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                          color:text_color,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      response["user_id"].toString(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: TextStyle(
                          color:text_color,
                          fontSize: 15,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Text(
                      "Order Status",
                      style: TextStyle(
                          color:fnf_small_text_color,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500),
                    ),
                  ],

                ),
                const SizedBox(height: 10),
                orderStatusSelect(),


                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(child:  ElevatedButton(
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
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),),

                    SizedBox(width: 10,),
                    Expanded(child:ElevatedButton(
                      onPressed: () {
                      //  Get.back();

                        if(vendorOrderPageController.selectStateId.value=="Pending"){
                          _showToast("Pending");

                        }
                        else if(vendorOrderPageController.selectStateId.value=="Complete"){
                          _showToast("Complete");

                        }else{
                          _showToast("cancel");

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
                            "Save",
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
                    ),),

                  ],
                ),
                const SizedBox(height: 20),
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
    );
  }

  Widget orderStatusSelect() {
    return Column(
      children: [
        Container(
          // height: 50,
            alignment: Alignment.center,
            //  margin: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20,),
            decoration: BoxDecoration(
                color:Colors.white,
                border: Border(

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
              value: vendorOrderPageController.selectStateId.value != null &&
                  vendorOrderPageController.selectStateId.value.isNotEmpty ?
              vendorOrderPageController.selectStateId.value : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 5,),
                  Expanded(child: Center(child: Text("Selected Country",
                      style: TextStyle(
                          color: text_color,
                          fontSize: 15,
                          fontWeight: FontWeight.normal)),))
                ],
              ),
              isExpanded: true,
              /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 0),

              items: vendorOrderPageController.statusList.map((list) {
                return DropdownMenuItem(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [


                      Expanded(child: Center(
                        child: Text(
                            list.toString(),
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                                color: text_color,
                                //color: intello_text_color,
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                      ),),




                    ],
                  ),

                  // Text(list["country_name"].toString()),
                  value: list.toString(),
                );

              },
              ).toList(),
              onChanged:(String? value){
                vendorOrderPageController.selectStateId(value);
                //  String data= checkoutPageController.selectCountryId(value.toString());
                // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
              },

            ))
        ),

      ],
    );
  }

  Widget _buildTotalCalculationItem({
    required double item_marginLeft,
    required double item_marginRight,
    required String name,
    required String value,
  }) {
    return Container(
      margin:  EdgeInsets.only(left: item_marginLeft, right: item_marginRight,bottom: 7,top: 7),
      width: (Get.width/2)-30,
      decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(

            color: Colors.grey.withOpacity(.25) ,
            //  blurRadius: 20.0, // soften the shadow
            blurRadius: 20 , // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            )
        )],
      ),
      //   height: 150,
      child: Container(
        margin: const EdgeInsets.only(right: 10.0,top: 20,bottom: 20,left: 20),
        // height: double.infinity,
        // width: double.infinity,

        child: Center(
          child: Column(
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: fnf_color,
                      fontSize: (Get.width/20),
                      fontWeight: FontWeight.w800),
                  softWrap: false,

                ),
              ),
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: fnf_small_text_color,
                      fontSize: (Get.width/27),
                      fontWeight: FontWeight.w500),
                  softWrap: false,
                ),
              ),

            ],
          ),
        ),
      ) ,
    );
  }


  ///shimmer
  Widget orderItemShimmer(){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 20),
      child:Flex(
        direction: Axis.horizontal,
        children: [


          Expanded(child:Column(
            children: [

              Row(children: [
                Expanded(child: buildRectangleShimmer(
                    height: 18,
                    width: double.infinity,
                    marginLeft: 0,
                    marginTop: 0,
                    marginRight: 10,
                    marginBottom: 0
                ),),
              ],),

              SizedBox(
                height: 4,
              ),
              Row(children: [
                Expanded(child: buildRectangleShimmer(
                    height: 18,
                    width: double.infinity,
                    marginLeft: 0,
                    marginTop: 0,
                    marginRight: 10,
                    marginBottom: 0
                ),),

              ],),

              SizedBox(
                height: 4,
              ),
              Row(children: [
                Expanded(child: buildRectangleShimmer(
                    height: 18,
                    width: double.infinity,
                    marginLeft: 0,
                    marginTop: 0,
                    marginRight: 10,
                    marginBottom: 0
                ),),

              ],),

            ],
          ),),


          buildRectangleShimmer(
              height: 20,
              width: 80,
              marginLeft: 0,
              marginTop: 0,
              marginRight: 0,
              marginBottom: 0
          )


        ],
      ),
    );
  }


}

