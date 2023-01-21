import 'package:badges/badges.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/order/vendor/vendor_order_details_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../api_service/api_service.dart';
import '../../../controller/order_controller/order_page_controller.dart';
import '../../../controller/order_controller/vendor_order_controller/vendor_order_details_page_controller.dart';
import '../../../controller/order_controller/vendor_order_controller/vendor_order_page_controller.dart';
import '../../../controller/product_controller/product_details_controller.dart';
import '../../../data_base/sqflite/note.dart';
import '../../../../static/Colors.dart';


import '../../drawer/custom_drawer.dart';
import '../../drawer/vendor_custom_drawer.dart';
import '../order_details_page.dart';

class VendorOrderPage extends StatelessWidget {

  final vendorOrderPageController = Get.put(VendorOrderPageController());
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey();
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
                                    ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: 5,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return orderItem("sd");
                                        }),
                                  ]

                                  ,
                                );
                              }),


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

  Widget orderItem(var respons){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 10,left: 20,bottom: 0),
      child: InkWell(
        onTap: (){

          Get.to(() => VendorOrderDetailsPage(),
            //  arguments: [{"singleProductDetailsData": response}]

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
                          "created_at".toString(),
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
                          "order_id".toString(),
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
                          "Abdullah".toString(),
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
                          "\$"+"120",
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
                      IconButton(
                        iconSize: 20,
                        color: fnf_color,
                        icon:Icon(Icons.edit),
                        onPressed: () {
                          vendorOrderPageController.selectStateId("Pending");
                          openBottomSheet("");
                        },
                      ),
                      Text(
                        "status".toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            color:fnf_color,
                            fontSize: 13,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500),
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
                  color:hint_color,
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
    var outputFormat = DateFormat('dd/MMM/yyyy');
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
                      "#order_id".toString(),
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
                      "Abdullah".toString(),
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


}

