import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/dash_board/wish_list_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../../controller/dash_board_controller/search_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../controller/profile_section_controllert/profile_section_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/note.dart';
import '../../../static/Colors.dart';

import '../auth/user/change_password_page.dart';
import '../auth/user/fotget_password_page.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';

import '../order/order_page.dart';
import '../product/product_list.dart';



class SearchPage extends StatelessWidget {
  final searchPageController = Get.put(SearchPageController());
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
                height: MediaQuery.of(context).size.height / 20,
                // height: 50,
              ),

              ///title bar
              Row(
                children: [

                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: InkResponse(
                      onTap: () {
                       // homeController. searchBoxVisible(0);
                        Get.back();
                      },
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 25.0,
                      ),
                    ),
                  ),

                  Expanded(child: userInputSearchField(searchPageController.searchController.value, 'Search product/vendor', TextInputType.text),)

                ],
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 45,
                // height: 30,
              ),
              //SizedBox(height: 10,),
              Expanded(child: Container(
                color: Colors.white,

                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Container(height: 5,),

                      Obx(() =>   ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount:searchPageController.productNameDataList.length>10?10:searchPageController.productNameDataList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return productNameItem(searchPageController.productNameDataList[index]);
                          }),),

                      Obx(() =>   ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: searchPageController.sellerNameDataList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return sellerNameItem(searchPageController.sellerNameDataList[index]);
                          }),),


                    ],
                  ),
                ),
              ))
            ],
          )
      )
    );

  }


  Widget productNameItem(var response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 12,left: 20,bottom: 0),
      child: InkWell(
        onTap: (){
          // _showToast( response["product_name"].toString());
          searchPageController.searchController.value.text= response["product_name"].toString();

          Get.off(() => ProductListPage(), arguments: [
            {"categoriesId": ""},
            {"subCategoriesId": ""},
            {"searchValue": response["product_name"].toString()},

          ])?.then((value) => Get.delete<ProductDetailsController>());

          // Get.to(() => OrderDetailsPage(),
          //     arguments: [
          //       {"singleProductDetailsData": response}
          //     ]
          //
          // )?.then((value) => Get.delete<OrderPageController>());

        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [

                Expanded(child:Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(
                          response["product_name"].toString(),
                          // "05-Jan-2023",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),)
                      ],
                    ),
                  ],
                ),),

                Container(
                  child: Text(
                    "product".toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color:hint_color,
                        fontSize: 10,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),
                )

              ],
            ),
            SizedBox(height: 12,),
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

  Widget sellerNameItem(var response){
    return  Padding(padding: const EdgeInsets.only(right:20,top: 12,left: 20,bottom: 0),
      child: InkWell(
        onTap: (){
          searchPageController.searchController.value.text= response["seller_name"].toString();
          Get.off(() => ProductListPage(), arguments: [
            {"categoriesId": ""},
            {"subCategoriesId": ""},
            {"searchValue": response["seller_name"].toString()},

          ])?.then((value) => Get.delete<ProductDetailsController>());

        },
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [


                Expanded(child:Column(
                  children: [
                    Row(
                      children: [


                        Expanded(child: Text(
                          response["seller_name"].toString(),
                          // "05-Jan-2023",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),)
                      ],
                    ),
                  ],
                ),),

                Container(
                  child: Text(
                    "Vendor".toString(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: TextStyle(
                        color:hint_color,
                        fontSize: 10,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal),
                  ),
                )

              ],
            ),
            SizedBox(height: 12,),
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

  Widget userInputSearchField(TextEditingController userInputController, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          color:Colors.white,

          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 0.0, top: 5,bottom: 5, right: 0),
        child: TextFormField(
          controller: userInputController,
          textInputAction: TextInputAction.search,
          autofocus: true,
          cursorColor:fnf_color,
          textAlign: TextAlign.center,
          style: TextStyle(color:text_color,


          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              // color: Colors.intello_input_text_color,
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color:hint_color,

                  //color: Colors.intello_hint_color,
                  size: 25,
                ),
                onPressed: () {
                  Get.back();
                 // homeController. searchBoxVisible(0);

                }),
            suffixIconConstraints: BoxConstraints(
              minHeight: 10,
              minWidth: 10,
            ),
            suffixIcon: InkWell(

              onTap: (){

                searchPageController.searchController.value.text = "";

                searchPageController.productNameDataList([]);
                searchPageController.sellerNameDataList([]);

              },
              child: Padding(
                padding: EdgeInsets.only(right: 15,left: 10,top: 5,bottom: 5),
                child:Image.asset(
                  "assets/images/close1.png",
                  // width: 25,
                  fit: BoxFit.fill,
                  height: 12,
                )
                // "icon_close"
              ),
            ),

            // IconButton(
            //   // color: Colors.intello_input_text_color,
            //     icon: Icon(
            //       Icons.search,
            //       color:hint_color,
            //
            //       //color: Colors.intello_hint_color,
            //       size: 25,
            //     ),
            //     onPressed: () {
            //
            //       String searchValue = searchPageController.searchController.value.text;
            //
            //       if(searchValue.isNotEmpty){
            //         Get.to(() => ProductListPage(), arguments: [
            //           {"categoriesId": ""},
            //           {"subCategoriesId": ""},
            //           {"searchValue": searchValue},
            //
            //         ])?.then((value) => Get.delete<ProductDetailsController>());
            //       }else{
            //         _showToast("Enter search value!");
            //       }
            //
            //       // homeController. searchBoxVisible(0);
            //
            //     }),


            hintText: hintTitle,

            hintStyle:  TextStyle(fontSize: 16,
                color:hint_color,

                // color: Colors.intello_hint_color,
                fontStyle: FontStyle.normal),
          ),
          onChanged: (value){
            searchPageController.getSearchSuggestDataList(value);

          },
          onFieldSubmitted: (value) {
            String searchValue = searchPageController.searchController.value.text;

            if(searchValue.isNotEmpty){
              Get.off(() => ProductListPage(), arguments: [
                {"categoriesId": ""},
                {"subCategoriesId": ""},
                {"searchValue": searchValue},

              ])?.then((value) => Get.delete<ProductDetailsController>());
            }else{
              //  _showToast("Enter search value!");
            }

          },

          keyboardType: keyboardType,
        ),
      ),
    );
  }


  ///user info with share pref
  void saveUserInfoRemove({required String userName,required String userToken,}) async {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, userName);
      storage.write(pref_user_token, userToken);
      // _showToast(userToken.toString());
    } catch (e) {
      //code
    }
  }




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