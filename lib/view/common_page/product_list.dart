

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../api_service/api_service.dart';
import '../../controller/all_product_list_controller.dart';


import '../../controller/product_details_controller.dart';
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
                      "All Categories",
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                      ),
                    )),


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
                        userInputSelectTopic(),
                        Expanded(child:
                        Obx(()=>GridView.builder(
                            itemCount:allProductListPageController.filterProductList.length,
                            // shrinkWrap: true,
                            // physics: const ClampingScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 7.0,
                                mainAxisSpacing: 7.0,
                                mainAxisExtent: 250
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return  productCardItemDesign(height: 00, width: MediaQuery.of(context).size.width, index: index);
                            }),
                        ),)
                      ],
                    )


                )),


              ],
            )

        )
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: fnf_title_bar_bg_color,

        // key: _key,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  "Categories name",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                )),


              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
              // height: 50,
            ),
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
       //  Get.to(() => ProductDetailsePageScreen(), arguments: [
       //    {"productId": allProductListPageController.filterProductList[index].id.toString()},
       //    {"second": 'Second data'}
       //  ]);

        Get.to(() => ProductDetailsePageScreen(), arguments: [
          {"productId": allProductListPageController.filterProductList[index].id.toString()},
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
                                // image:"http://192.168.68.106/bijoytech_ecomerce/public/images/product/1669097419-637c67cbbabda.webp",
                                image:BASE_URL_API_IMAGE_PRODUCT+
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
                            if(allProductListPageController.userToken.isNotEmpty &&
                                allProductListPageController.userToken.value!=null){
                              _showToast("add favourite");

                            }else{
                              showLoginWarning();
                            }
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
                                maxPrice: allProductListPageController.selectedMaxPrice.value);

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
                                maxPrice: allProductListPageController.selectedMaxPrice.value);
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
                          maxPrice: allProductListPageController.selectedMaxPrice.value);


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
                                maxPrice: allProductListPageController.selectedMaxPrice.value);

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
                                maxPrice: allProductListPageController.selectedMaxPrice.value);
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
