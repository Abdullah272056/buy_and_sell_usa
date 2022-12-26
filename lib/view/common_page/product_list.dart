

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../api_service/api_service.dart';
import '../../controller/all_product_list_controller.dart';


import '../../static/Colors.dart';
import 'product_details.dart';

class ProductListPage extends StatelessWidget {
  final allProductListPageController = Get.put(AllProductListPageController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.backGroundColor,
        // key: _key,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userInputSelectTopic(),
           Expanded(child:
           Obx(()=>GridView.builder(
               itemCount:allProductListPageController.filterProductList.length,
               // shrinkWrap: true,
               // physics: const ClampingScrollPhysics(),
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 10.0,
                   mainAxisSpacing: 10.0,
                   mainAxisExtent: 250
               ),
               itemBuilder: (BuildContext context, int index) {
                 return  productCardItemDesign(height: 00, width: MediaQuery.of(context).size.width, index: index);
               }),
           ),)
          ],
        )

      ),
    );
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
        Get.to(() => ProductDetailsePageScreen(), arguments: [
          {"productId": allProductListPageController.filterProductList[index].id.toString()},
          {"second": 'Second data'}
        ]);

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
                                // image:"http://192.168.68.106/bijoytech_ecomerce/public/images/product/1669097419-637c67cbbabda.webp",
                                image:BASE_URL_API_IMAGE+
                                    allProductListPageController.filterProductList[index].coverImage??"",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:  Text(
                            allProductListPageController.filterProductList[index].productName,
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
                          child:  Text("\$ "+
                              allProductListPageController.filterProductList[index].price,
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
      ) ,
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
                border: Border(

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

                            String data= allProductListPageController.selectSizeId(value.toString());
                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
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

                            String data= allProductListPageController.selectBrandsId(value.toString());
                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["category_name"].toString(),
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

                            String data= allProductListPageController.selectCategoriesId(value.toString());
                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["subcategory_name"].toString(),
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

                            String data= allProductListPageController.selectSubCategoriesId(value.toString());
                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
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
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [


                                  Expanded(child: Center(
                                    child: Text(
                                        list["inner_category_name"].toString(),
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

                            String data= allProductListPageController.selectInnerCategoriesId(value.toString());
                            // _showToast("Id ="+submitAssignmentPageController.selectAssignmentId.value);
                          },

                        ),)),



                  ],
                )
                    :Container())
              ],
            )
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


}
