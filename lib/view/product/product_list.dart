

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../api_service/api_service.dart';
import '../../controller/product_controller/all_product_list_controller.dart';


import '../../controller/product_controller/product_details_controller.dart';
import '../../static/Colors.dart';
import '../auth/log_in_page.dart';
import '../auth/sign_up_page.dart';
import 'product_details.dart';

class ProductListPage extends StatelessWidget {

  final allProductListPageController = Get.put(AllProductListPageController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:Container(
            decoration: BoxDecoration(
              color:fnf_title_bar_bg_color,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height / 16,
                  // height: 50,
                ),

                Flex(direction: Axis.horizontal,
                  children: [
                    SizedBox(width: 30,),

                    SizedBox(width: 5,),
                    Expanded(child: Text(
                      "Product list",
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                      ),
                    )),


                    InkResponse(
                      onTap: (){
                        openBottomSheet("df");
                       // _showToast("filter");

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [

                          SizedBox(width: 5,),

                          Text("Filter",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal)
                          ),

                          SizedBox(width: 5,),

                          Icon(
                            Icons.filter_alt_outlined,
                            color:  Colors.white,
                            size: 20.0,
                          ),

                        ],
                      ),
                    ),

                    SizedBox(width: 20,),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                  // height: 50,
                ),

                Expanded(child: Container(
                    color: Colors.white,
                  //  padding: EdgeInsets.only(left: 10,right: 10,top: 10),

                    child:Column(
                      children: [
                       // userInputSelectTopic(),
                        Expanded(child:
                        Obx(() => allProductListPageController.isFirstLoadRunning==true? Center(
                          child: CircularProgressIndicator(),
                        ):
                        Column(
                          children: [
                            Expanded(child:
                            Obx(() =>
                                GridView.builder(
                                    itemCount:allProductListPageController.allProductList.length,
                                    // shrinkWrap: true,
                                    // physics: const ClampingScrollPhysics(),
                                    controller: allProductListPageController.controller,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 7.0,
                                        mainAxisSpacing: 7.0,
                                        mainAxisExtent: 250
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return  productCardItemDesign(height: 00, width: MediaQuery.of(context).size.width, index: index,
                                          response: allProductListPageController.allProductList[index]);
                                    }),


                                // ListView.builder(
                                //     itemCount: homePageController.todoList.length,
                                //     controller:_controller,
                                //
                                //     itemBuilder: (_, index)=>InkWell(
                                //       onTap: (){
                                //
                                //         Get.to(TodoDetailsPage("${homePageController.todoList[index].id}"));
                                //         // Get.to(page)
                                //       },
                                //       child: Card(
                                //           margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                //
                                //
                                //           child: Container(
                                //             padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                                //
                                //             child: Column(
                                //               children: [
                                //
                                //                 Row(
                                //                   children: [
                                //
                                //                     Text("User Id: ${homePageController.todoList[index].userId}"),
                                //
                                //                   ],
                                //                 ),
                                //                 Row(
                                //                   children: [
                                //                     Text("Id: ${homePageController.todoList[index].id}"),
                                //
                                //                   ],
                                //                 ),
                                //                 Row(
                                //                   mainAxisAlignment: MainAxisAlignment.start,
                                //                   children: [
                                //                     Flexible(
                                //                       child: Text("Title: ${homePageController.todoList[index].title}"),
                                //                     ),
                                //
                                //                   ],
                                //                 ),
                                //                 Row(
                                //                   mainAxisAlignment: MainAxisAlignment.start,
                                //                   children: [
                                //                     Text("Completed:"),
                                //                     SizedBox(
                                //                       height: 30,
                                //                       width: 30,
                                //                       child: Checkbox(
                                //                         value:homePageController.todoList[index].completed,
                                //                         onChanged: ( value) {
                                //
                                //                         },
                                //                       ),
                                //                     )
                                //
                                //
                                //                   ],
                                //                 ),
                                //
                                //
                                //
                                //               ],
                                //             ),
                                //           )
                                //
                                //       ),
                                //     )
                                //
                                // )
                            )
                            ),
                            Obx(() =>
                            allProductListPageController.isMoreLoadRunning==true?Padding(
                              padding: EdgeInsets.only(top: 10,bottom: 20),
                              child: Center(
                                  child: LinearProgressIndicator()
                              ),
                            ):Container()

                            )

                          ],
                        )

                        )





                        )
                      ],
                    )


                )),

              ],
            )

        )
    );
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: fnf_title_bar_bg_color,
    //
    //     // key: _key,
    //     body:Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height / 16,
    //           // height: 50,
    //         ),
    //
    //         Flex(direction: Axis.horizontal,
    //           children: [
    //             SizedBox(width: 30,),
    //
    //             SizedBox(width: 5,),
    //             Expanded(child: Text(
    //               "Categories name",
    //               style: TextStyle(color: Colors.white,
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 17
    //               ),
    //             )),
    //
    //
    //           ],
    //         ),
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height / 40,
    //           // height: 50,
    //         ),
    //         userInputSelectTopic(),
    //        Expanded(child:
    //        Obx(()=>GridView.builder(
    //            itemCount:allProductListPageController.filterProductList.length,
    //            // shrinkWrap: true,
    //            // physics: const ClampingScrollPhysics(),
    //            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                crossAxisCount: 2,
    //                crossAxisSpacing: 10.0,
    //                mainAxisSpacing: 10.0,
    //                mainAxisExtent: 250
    //            ),
    //            itemBuilder: (BuildContext context, int index) {
    //              return  productCardItemDesign(height: 00, width: MediaQuery.of(context).size.width, index: index, response: null);
    //            }),
    //        ),)
    //       ],
    //     )
    //
    //   ),
    // );
  }

  void openBottomSheet(String text) {
    Get.bottomSheet(
        ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),



                userInputSelectTopic1()





              ],
            ),
          ],
        ),


        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        isScrollControlled: true


      //  resizeToAvoidBottomInset: false
      // isScrollControlled: true,
    );
  }

  //product item
  Widget productCardItemDesign({
    required double height,
    required double width,
    required int index,
    required var response,
  }) {
    return InkWell(
      onTap: (){

       /// _showToast(allProductListPageController.filterProductList[index].id.toString());
       //  Get.to(() => ProductDetailsePageScreen(), arguments: [
       //    {"productId": allProductListPageController.filterProductList[index].id.toString()},
       //    {"second": 'Second data'}
       //  ]);

        Get.to(() => ProductDetailsePageScreen(), arguments: [
          {"productId": response["id"].toString(),

         // allProductListPageController.filterProductList[index].id.toString()
          },
          {"second": 'Second data'}
        ])?.then((value) => Get.delete<ProductDetailsController>());

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
                            // padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                              padding: EdgeInsets.only(left: 0,right: 0,top: 0),
                              // padding: EdgeInsets.all(16),
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                placeholder: 'assets/images/loading.png',

                                image:BASE_URL_API_IMAGE_PRODUCT+response["cover_image"].toString(),
                                 //   allProductListPageController.filterProductList[index].coverImage??"",
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
                      Positioned(
                        right: 5,
                        top: 5,
                        child: InkWell(
                          onTap: (){

                            if(allProductListPageController.userToken.isNotEmpty &&
                                allProductListPageController.userToken.value!="null"&&
                                allProductListPageController.userToken.value!=null){
                              allProductListPageController.addWishList(
                                  token: allProductListPageController.userToken.toString(),
                                  productId: response["id"].toString());

                            }else{
                              showLoginWarning();
                            }


                            // if(allProductListPageController.userToken.isNotEmpty &&
                            //     allProductListPageController.userToken.value!=null){
                            //   _showToast("add favourite");
                            //
                            // }else{
                            //   showLoginWarning();
                            // }
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
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:  Text(
                            response["product_name"].toString(),
                          //  allProductListPageController.filterProductList[index].productName,
                            //"Men Grey Classic Regular Fit Formal Shirt",
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: Colors.black.withOpacity(0.7),
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
                                rating:double.parse(response["av_review"].toString()),
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
                                response["count_review"].toString()+
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
                        Text(
                          "\$ "+ response["price"].toString(),


                          // productDetailsController.productPrice.value ,
                          //  overflow: TextOverflow.ellipsis,

                          style:  TextStyle(
                              color: hint_color,
                              fontSize: 13,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.normal),
                          softWrap: false,
                          maxLines: 1,
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            "\$ "+discountedPriceCalculate(regularPrice:response["price"].toString(),
                                discountedPercent: response["discount_percent"].toString()),

                            //allProductListPageController.filterProductList[index].price,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                            softWrap: false,
                            maxLines: 2,
                          )
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
      ) ,
    );
  }

  // filter button
  Widget _buildResetFilterButton() {
    return ElevatedButton(
      onPressed: () {

        allProductListPageController.minPriceController.value.text="";
        allProductListPageController.maxPriceController.value.text="";
        allProductListPageController.selectedSearch("");
        allProductListPageController.pageNo("1");
        allProductListPageController.selectCategoriesId("");
        allProductListPageController.categoryId("");
        allProductListPageController.selectSubCategoriesId("");
        allProductListPageController.subCategoryId("");
        String data= allProductListPageController.selectColorsId("");
        allProductListPageController.selectedColorsList([]);
        allProductListPageController.selectSizeId("");
        allProductListPageController.selectedSizesList([]);
        allProductListPageController.selectBrandsId("");
        allProductListPageController.selectedBrandsList([]);
        allProductListPageController.hasNextPage(true);

        Get.back();

        allProductListPageController.getCategoriesProductsDataList(
          categoryId: allProductListPageController.categoryId.value,
          subcategoryId: allProductListPageController.subCategoryId.value,
          innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
          filterCategoryList: allProductListPageController.selectedFilterCategoryList,
          filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
          filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
          brandName: allProductListPageController.selectedBrandName.value,
          minPrice: allProductListPageController.selectedMinPrice.value,
          sortBy: allProductListPageController.selectedSortBy.value,
          search: allProductListPageController.selectedSearch.value,
          brandsList: allProductListPageController.selectedBrandsList,
          sizesList: allProductListPageController.selectedSizesList,
          colorsList: allProductListPageController.selectedColorsList,
          maxPrice: allProductListPageController.selectedMaxPrice.value,
          pageNo: allProductListPageController.pageNo.value,
          perPage: allProductListPageController.perPage.value,
        );


      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5))),
      child: Ink(
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [button_bg_color,button_bg_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(

          height: 40,
          alignment: Alignment.center,
          child:  const Text(
            "RESET",
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
  Widget _buildFilterButton() {
    return ElevatedButton(
      onPressed: () {

        String minPriceTxt = allProductListPageController.minPriceController.value.text;
        String maxPriceTxt = allProductListPageController.maxPriceController.value.text;
        if(minPriceTxt.isEmpty){
          allProductListPageController.selectedMinPrice("");
        }else{
          allProductListPageController.selectedMinPrice(minPriceTxt.toString());
        }
        if(maxPriceTxt.isEmpty){
          allProductListPageController.selectedMaxPrice("");
        }else{
          allProductListPageController.selectedMaxPrice(maxPriceTxt.toString());
        }
        allProductListPageController.pageNo("1");

        Get.back();
        allProductListPageController.hasNextPage(true);
        allProductListPageController.getCategoriesProductsDataList(
          categoryId: allProductListPageController.categoryId.value,
          subcategoryId: allProductListPageController.subCategoryId.value,
          innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
          filterCategoryList: allProductListPageController.selectedFilterCategoryList,
          filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
          filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
          brandName: allProductListPageController.selectedBrandName.value,
          minPrice: allProductListPageController.selectedMinPrice.value,
          sortBy: allProductListPageController.selectedSortBy.value,
          search: allProductListPageController.selectedSearch.value,
          brandsList: allProductListPageController.selectedBrandsList,
          sizesList: allProductListPageController.selectedSizesList,
          colorsList: allProductListPageController.selectedColorsList,
          maxPrice: allProductListPageController.selectedMaxPrice.value,
          pageNo: allProductListPageController.pageNo.value,
          perPage: allProductListPageController.perPage.value,
        );


        // String passwordTxt = signUpPageController.passwordController.value.text;
        // String confirmPasswordTxt = signUpPageController.confirmPasswordController.value.text;
        //
        // if (_inputValid(userName: userNameTxt, userEmail:userEmailTxt,
        //     password: passwordTxt, confirmPassword: confirmPasswordTxt)== false) {
        //   // userAutoLogIn();
        //   userSignUp(name: userNameTxt, email: userEmailTxt, password: confirmPasswordTxt);
        //
        //   //    LogInApiService().userLogIn(userName: userNameTxt, password: passwordTxt);
        //
        // }


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
            "FILTER",
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
  Widget userInputSelectTopic() {
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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectColorsId.value != null &&
                              allProductListPageController.selectColorsId.value.isNotEmpty ?
                          allProductListPageController.selectColorsId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("color",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.colorsList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["color_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                            String data= allProductListPageController.selectColorsId(value.toString());
                            allProductListPageController.selectedColorsList([value.toString()]);

                            allProductListPageController.getCategoriesProductsDataList(
                                categoryId: allProductListPageController.categoryId.value,
                                subcategoryId: allProductListPageController.subCategoryId.value,
                                innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                                filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                                filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                                filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                                brandName: allProductListPageController.selectedBrandName.value,
                                minPrice: allProductListPageController.selectedMinPrice.value,
                                sortBy: allProductListPageController.selectedSortBy.value,
                                search: allProductListPageController.selectedSearch.value,
                                brandsList: allProductListPageController.selectedBrandsList,
                                sizesList: allProductListPageController.selectedSizesList,
                                colorsList: allProductListPageController.selectedColorsList,
                                maxPrice: allProductListPageController.selectedMaxPrice.value,
                                pageNo: allProductListPageController.pageNo.value,
                                perPage: allProductListPageController.perPage.value,
                            );

                            // getCategoriesProductsDataList(categoryId: argumentData[0]['categoriesId'],
                            //     subcategoryId: argumentData[1]['subCategoriesId'],
                            //     innerCategoryId: '', filterCategoryList: [],
                            //     filterSubCategoryList: [], filterInnerCategoryList: [],
                            //     brandName: 'admin', minPrice: '', sortBy: '', search: '',
                            //     brandsList: [], sizesList: [], colorsList: [], maxPrice: '');



                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
                          },

                        ),)),
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectSizeId.value != null &&
                              allProductListPageController.selectSizeId.value.isNotEmpty ?
                          allProductListPageController.selectSizeId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("Size",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.sizeList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["size_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                             allProductListPageController.selectSizeId(value.toString());

                            allProductListPageController.selectedSizesList([value.toString()]);

                            allProductListPageController.getCategoriesProductsDataList(
                                categoryId: allProductListPageController.categoryId.value,
                                subcategoryId: allProductListPageController.subCategoryId.value,
                                innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                                filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                                filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                                filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                                brandName: allProductListPageController.selectedBrandName.value,
                                minPrice: allProductListPageController.selectedMinPrice.value,
                                sortBy: allProductListPageController.selectedSortBy.value,
                                search: allProductListPageController.selectedSearch.value,
                                brandsList: allProductListPageController.selectedBrandsList,
                                sizesList: allProductListPageController.selectedSizesList,
                                colorsList: allProductListPageController.selectedColorsList,
                                maxPrice: allProductListPageController.selectedMaxPrice.value,
                              pageNo: allProductListPageController.pageNo.value,
                              perPage: allProductListPageController.perPage.value,
                            );
                          },

                        ),)),
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectBrandsId.value != null &&
                              allProductListPageController.selectBrandsId.value.isNotEmpty ?
                          allProductListPageController.selectBrandsId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("Brands",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.brandsList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["vendor_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                          allProductListPageController.selectBrandsId(value.toString());

                          allProductListPageController.selectedBrandsList([value.toString()]);

                          allProductListPageController.getCategoriesProductsDataList(
                          categoryId: allProductListPageController.categoryId.value,
                          subcategoryId: allProductListPageController.subCategoryId.value,
                          innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                          filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                          filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                          filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                          brandName: allProductListPageController.selectedBrandName.value,
                          minPrice: allProductListPageController.selectedMinPrice.value,
                          sortBy: allProductListPageController.selectedSortBy.value,
                          search: allProductListPageController.selectedSearch.value,
                          brandsList: allProductListPageController.selectedBrandsList,
                          sizesList: allProductListPageController.selectedSizesList,
                          colorsList: allProductListPageController.selectedColorsList,
                          maxPrice: allProductListPageController.selectedMaxPrice.value,
                            pageNo: allProductListPageController.pageNo.value,
                            perPage: allProductListPageController.perPage.value,
                          );


                          },

                        ),)),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      color: hint_color,
                      width: 1,
                      height: 30,
                    ),

                    Expanded(child: InkWell(
                      onTap: (){

                        if(allProductListPageController.showFilterStatus==1){
                          allProductListPageController.showFilterStatus(2);
                        }
                        else{
                          allProductListPageController.showFilterStatus(1);
                        }

                       // _showToast("df");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(width: 5,),
                          Text("Filter",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(width: 5,),

                          Icon(
                            Icons.filter_alt_outlined,
                            color: text_color,
                            size: 20.0,
                          ),
                        ],
                      ),
                    )),




                  ],
                ),

                Obx(() => allProductListPageController.showFilterStatus==1?
                Row(
                  children: [
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectCategoriesId.value != null &&
                              allProductListPageController.selectCategoriesId.value.isNotEmpty ?
                          allProductListPageController.selectCategoriesId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("Categories",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.categoriesList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["category_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  const TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {
                            allProductListPageController.selectCategoriesId(value.toString());

                            allProductListPageController.categoryId(value.toString() );

                            allProductListPageController.getCategoriesProductsDataList(
                                categoryId: allProductListPageController.categoryId.value,
                                subcategoryId: allProductListPageController.subCategoryId.value,
                                innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                                filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                                filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                                filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                                brandName: allProductListPageController.selectedBrandName.value,
                                minPrice: allProductListPageController.selectedMinPrice.value,
                                sortBy: allProductListPageController.selectedSortBy.value,
                                search: allProductListPageController.selectedSearch.value,
                                brandsList: allProductListPageController.selectedBrandsList,
                                sizesList: allProductListPageController.selectedSizesList,
                                colorsList: allProductListPageController.selectedColorsList,
                                maxPrice: allProductListPageController.selectedMaxPrice.value,
                              pageNo: allProductListPageController.pageNo.value,
                              perPage: allProductListPageController.perPage.value,

                            );

                          },

                        ),)),
                    Expanded(child: Obx(() =>
                     DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectSubCategoriesId.value != null &&
                              allProductListPageController.selectSubCategoriesId.value.isNotEmpty ?
                          allProductListPageController.selectSubCategoriesId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("Sub categories",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.subCategoriesList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["subcategory_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  const TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                           allProductListPageController.selectSubCategoriesId(value.toString());

                            allProductListPageController.subCategoryId(value.toString() );

                            allProductListPageController.getCategoriesProductsDataList(
                                categoryId: allProductListPageController.categoryId.value,
                                subcategoryId: allProductListPageController.subCategoryId.value,
                                innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                                filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                                filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                                filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                                brandName: allProductListPageController.selectedBrandName.value,
                                minPrice: allProductListPageController.selectedMinPrice.value,
                                sortBy: allProductListPageController.selectedSortBy.value,
                                search: allProductListPageController.selectedSearch.value,
                                brandsList: allProductListPageController.selectedBrandsList,
                                sizesList: allProductListPageController.selectedSizesList,
                                colorsList: allProductListPageController.selectedColorsList,
                                maxPrice: allProductListPageController.selectedMaxPrice.value,
                              pageNo: allProductListPageController.pageNo.value,
                              perPage: allProductListPageController.perPage.value,

                            );
                          },

                        ),)),
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectInnerCategoriesId.value != null &&
                              allProductListPageController.selectInnerCategoriesId.value.isNotEmpty ?
                          allProductListPageController.selectInnerCategoriesId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("Sort",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.innerCategoriesList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["inner_category_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  const TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                            String data= allProductListPageController.selectInnerCategoriesId(value.toString());
                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
                          },

                        ),)),

                  ],
                ) :Container())
              ],
            )
        ),

      ],
    )
     ;
  }
  Widget userInputSelectTopic1() {
    return Column(
      children: [
        Container(
          // height: 50,

            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10,),

            // decoration: BoxDecoration(
            //     color:Colors.white,
            //     border: const Border(
            //
            //       left: BorderSide(width: 1.0, color: hint_color),
            //       right: BorderSide(width:1.0, color: hint_color),
            //       bottom: BorderSide(width: 1.0, color: hint_color),
            //       top: BorderSide(width: 1.0, color: hint_color),
            //     ),
            //     borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Categories & Sub Categories:",
                        style: TextStyle(
                            color: fnf_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value:
                            allProductListPageController.selectCategoriesId.value != null &&
                                allProductListPageController.selectCategoriesId.value.isNotEmpty ?
                            allProductListPageController.selectCategoriesId.value : null

                          ,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child:
                              Text(
                                  "Categories",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),
                              ))
                            ],
                          ),
                          isExpanded: true,
                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.categoriesList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["category_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  const TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {
                            allProductListPageController.selectCategoriesId(value.toString());
                            allProductListPageController.categoryId(value.toString() );


                            // allProductListPageController.getCategoriesProductsDataList(
                            //     categoryId: allProductListPageController.categoryId.value,
                            //     subcategoryId: allProductListPageController.subCategoryId.value,
                            //     innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                            //     filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                            //     filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                            //     filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                            //     brandName: allProductListPageController.selectedBrandName.value,
                            //     minPrice: allProductListPageController.selectedMinPrice.value,
                            //     sortBy: allProductListPageController.selectedSortBy.value,
                            //     search: allProductListPageController.selectedSearch.value,
                            //     brandsList: allProductListPageController.selectedBrandsList,
                            //     sizesList: allProductListPageController.selectedSizesList,
                            //     colorsList: allProductListPageController.selectedColorsList,
                            //     maxPrice: allProductListPageController.selectedMaxPrice.value);
                          },
                        ),)),


                    Expanded(child: Obx(() => DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectSubCategoriesId.value != null &&
                              allProductListPageController.selectSubCategoriesId.value.isNotEmpty ?
                          allProductListPageController.selectSubCategoriesId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(
                                child: Text(
                                    "Sub categories",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,
                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),
                          items: allProductListPageController.subCategoriesList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(child: Center(
                                    child: Text(
                                        list["subcategory_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  const TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),
                                ],
                              ),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                            allProductListPageController.selectSubCategoriesId(value.toString());

                            allProductListPageController.subCategoryId(value.toString() );

                            // allProductListPageController.getCategoriesProductsDataList(
                            //     categoryId: allProductListPageController.categoryId.value,
                            //     subcategoryId: allProductListPageController.subCategoryId.value,
                            //     innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                            //     filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                            //     filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                            //     filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                            //     brandName: allProductListPageController.selectedBrandName.value,
                            //     minPrice: allProductListPageController.selectedMinPrice.value,
                            //     sortBy: allProductListPageController.selectedSortBy.value,
                            //     search: allProductListPageController.selectedSearch.value,
                            //     brandsList: allProductListPageController.selectedBrandsList,
                            //     sizesList: allProductListPageController.selectedSizesList,
                            //     colorsList: allProductListPageController.selectedColorsList,
                            //     maxPrice: allProductListPageController.selectedMaxPrice.value);
                          },

                        ),)),
                  ],
                ),
                Row(
                  children: [
                    Text("Colors & Size:",
                        style: TextStyle(
                            color: fnf_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectColorsId.value != null &&
                              allProductListPageController.selectColorsId.value.isNotEmpty ?
                          allProductListPageController.selectColorsId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("color",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.colorsList.map((list){
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["color_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                            String data= allProductListPageController.selectColorsId(value.toString());
                            allProductListPageController.selectedColorsList([value.toString()]);


                            // allProductListPageController.getCategoriesProductsDataList(
                            //     categoryId: allProductListPageController.categoryId.value,
                            //     subcategoryId: allProductListPageController.subCategoryId.value,
                            //     innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                            //     filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                            //     filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                            //     filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                            //     brandName: allProductListPageController.selectedBrandName.value,
                            //     minPrice: allProductListPageController.selectedMinPrice.value,
                            //     sortBy: allProductListPageController.selectedSortBy.value,
                            //     search: allProductListPageController.selectedSearch.value,
                            //     brandsList: allProductListPageController.selectedBrandsList,
                            //     sizesList: allProductListPageController.selectedSizesList,
                            //     colorsList: allProductListPageController.selectedColorsList,
                            //     maxPrice: allProductListPageController.selectedMaxPrice.value);





                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
                          },

                        ),)),
                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectSizeId.value != null &&
                              allProductListPageController.selectSizeId.value.isNotEmpty ?
                          allProductListPageController.selectSizeId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("Size",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.sizeList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(child: Center(
                                    child: Text(
                                        list["size_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),


                                ],
                              ),

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                            allProductListPageController.selectSizeId(value.toString());

                            allProductListPageController.selectedSizesList([value.toString()]);


                            // allProductListPageController.getCategoriesProductsDataList(
                            //     categoryId: allProductListPageController.categoryId.value,
                            //     subcategoryId: allProductListPageController.subCategoryId.value,
                            //     innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                            //     filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                            //     filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                            //     filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                            //     brandName: allProductListPageController.selectedBrandName.value,
                            //     minPrice: allProductListPageController.selectedMinPrice.value,
                            //     sortBy: allProductListPageController.selectedSortBy.value,
                            //     search: allProductListPageController.selectedSearch.value,
                            //     brandsList: allProductListPageController.selectedBrandsList,
                            //     sizesList: allProductListPageController.selectedSizesList,
                            //     colorsList: allProductListPageController.selectedColorsList,
                            //     maxPrice: allProductListPageController.selectedMaxPrice.value);
                          },

                        ),)),


                  ],
                ),

                Row(
                  children: [
                    Text("Brands:",
                        style: TextStyle(
                            color: fnf_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                Row(
                  children: [

                    Expanded(child: Obx(() =>
                        DropdownButton2(
                          //  buttonHeight: 40,
                          //   menuMaxHeight:55,
                          itemPadding: EdgeInsets.only(left: 5,right: 0),
                          value: allProductListPageController.selectBrandsId.value != null &&
                              allProductListPageController.selectBrandsId.value.isNotEmpty ?
                          allProductListPageController.selectBrandsId.value : null,
                          underline:const SizedBox.shrink(),
                          hint:Row(
                            children: const [
                              SizedBox(width: 5,),
                              Expanded(child: Center(child: Text("Brands",
                                  style: TextStyle(
                                      color: text_color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal)),))
                            ],
                          ),
                          isExpanded: true,

                          /// icon: SizedBox.shrink(),
                          buttonPadding: const EdgeInsets.only(left: 0, right: 0),

                          items: allProductListPageController.brandsList.map((list) {
                            return DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["vendor_name"].toString(),
                                        textAlign: TextAlign.center,
                                        style:  TextStyle(
                                            color: text_color,
                                            //color: intello_text_color,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal)),
                                  ),),




                                ],
                              ),

                              // Text(list["country_name"].toString()),
                              value: list["id"].toString(),
                            );

                          },
                          ).toList(),
                          onChanged: (String? value) {

                            allProductListPageController.selectBrandsId(value.toString());

                            allProductListPageController.selectedBrandsList([value.toString()]);

                            // allProductListPageController.getCategoriesProductsDataList(
                            //     categoryId: allProductListPageController.categoryId.value,
                            //     subcategoryId: allProductListPageController.subCategoryId.value,
                            //     innerCategoryId: allProductListPageController.selectedInnerCategoryId.value,
                            //     filterCategoryList: allProductListPageController.selectedFilterCategoryList,
                            //     filterSubCategoryList:allProductListPageController.selectedFilterSubCategoryList,
                            //     filterInnerCategoryList: allProductListPageController.selectedFilterInnerCategoryList,
                            //     brandName: allProductListPageController.selectedBrandName.value,
                            //     minPrice: allProductListPageController.selectedMinPrice.value,
                            //     sortBy: allProductListPageController.selectedSortBy.value,
                            //     search: allProductListPageController.selectedSearch.value,
                            //     brandsList: allProductListPageController.selectedBrandsList,
                            //     sizesList: allProductListPageController.selectedSizesList,
                            //     colorsList: allProductListPageController.selectedColorsList,
                            //     maxPrice: allProductListPageController.selectedMaxPrice.value);


                          },

                        ),)),
                    Expanded(child: Container())







                  ],
                ),


                Row(
                  children: [
                    Text("Price:",
                        style: TextStyle(
                            color: fnf_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                SizedBox(height: 7,),
                Row(
                  children: [
                    SizedBox(width: 10,),
                    Expanded(child: _buildTextFieldMinPrice(hintText:"min")),
                    SizedBox(width: 10,),
                    Expanded(child: _buildTextFieldMaxPrice(hintText:"max")),
                    SizedBox(width: 10,),


                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [

                    Expanded(child: _buildResetFilterButton()),
                    SizedBox(width: 10,),
                    Expanded(child: _buildFilterButton()),



                  ],
                ),
              ],
            )
        ),

      ],
    )
    ;
  }

  //user name input field create
  Widget _buildTextFieldMinPrice({
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: TextField(
        cursorColor: awsCursorColor,
        cursorWidth: 1.5,
        // maxLength: 13,
        // autofocus: false,

        focusNode:allProductListPageController.minPriceFocusNode.value,
        onSubmitted:(_){
          allProductListPageController.maxPriceFocusNode.value.requestFocus();
        },
        controller: allProductListPageController.minPriceController.value,
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.black, fontSize: 13),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          // contentPadding: const EdgeInsets.all(17),
          contentPadding:  EdgeInsets.only(left: 10, right: 10,top: 7,bottom:7 ),

          prefixIcon: prefixedIcon,
          prefixIconColor: input_box_icon_color,

          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
          ),
          labelStyle: TextStyle(
            color:allProductListPageController.userEmailLevelTextColor.value,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: hint_color,
            fontWeight: FontWeight.normal,
            fontFamily: 'PTSans',
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
      ),
    );
  }

  //user name input field create
  Widget _buildTextFieldMaxPrice({
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color:transparent,
      child: TextField(
        cursorColor: awsCursorColor,
        cursorWidth: 1.5,
        // maxLength: 13,
        // autofocus: false,

        focusNode:allProductListPageController.maxPriceFocusNode.value,
        onSubmitted:(_){
          // allProductListPageController.maxPriceFocusNode.value.requestFocus();
        },
        controller: allProductListPageController.maxPriceController.value,
        textInputAction: TextInputAction.next,
        style: const TextStyle(color: Colors.black, fontSize: 13),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          // contentPadding: const EdgeInsets.all(17),
          contentPadding:  EdgeInsets.only(left: 10, right: 10,top: 7,bottom:7 ),

          prefixIcon: prefixedIcon,
          prefixIconColor: input_box_icon_color,

          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:input_box_OutlineInputBorder_active_color, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color:input_box_OutlineInputBorder_de_active_color, width: .6),
          ),
          labelStyle: TextStyle(
            color:allProductListPageController.userEmailLevelTextColor.value,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: hint_color,
            fontWeight: FontWeight.normal,
            fontFamily: 'PTSans',
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
      ),
    );
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


  String discountedPriceCalculate({required String regularPrice,required String discountedPercent}){

   return double.parse(((double.parse(regularPrice)-
       ((double.parse(regularPrice)*
           double.parse(discountedPercent))/100))).toStringAsFixed(2)).toString();

  }
}

class Student {
  String categoriesName;
  String categoriesId;

  Student(this.categoriesName, this.categoriesId);
}
