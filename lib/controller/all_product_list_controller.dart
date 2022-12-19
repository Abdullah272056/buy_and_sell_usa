
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../model/CategoriesData.dart';
import '../model/FilterListDataModelClass.dart';
import '../model/FilterListDataModelClass2.dart';
import '../static/Colors.dart';

class AllProductListPageController extends GetxController {
  dynamic argumentData = Get.arguments;
  var filterProductList=[].obs;
  @override
  void onInit() {
    super.onInit();

    // _showToast(argumentData[0]['categoriesId']);
    // _showToast(argumentData[1]['subCategoriesId']);


    getCategories(categoryId: argumentData[0]['categoriesId'],
        subcategoryId: argumentData[1]['subCategoriesId'],
        innerCategoryId: '', filterCategoryList: [],
        filterSubCategoryList: [], filterInnerCategoryList: [],
        brandName: 'admin', minPrice: '', sortBy: '', search: '',
        brandsList: [], sizesList: [], colorsList: [], maxPrice: '');

  }

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.white,
        textColor: fnf_color,
        fontSize: 16.0);
  }

  void getCategories({
                required String categoryId,required String subcategoryId,
                required String innerCategoryId,
                required List filterCategoryList, required List filterSubCategoryList,required List filterInnerCategoryList,
                required String brandName,required String minPrice,
                required String maxPrice,
                required String sortBy,required String search,
                required List brandsList, required List sizesList,required List colorsList
            }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try {
          var response = await post(
            Uri.parse('http://192.168.68.106/bijoytech_ecomerce/api/products'),

            // Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_CATEGORIES}'),
              headers : {
                'Content-Type': 'application/json'
              },
             body: json.encode({
              "category": categoryId,
              "subcategory": subcategoryId,
              "innercategory": innerCategoryId,
              "filetercategory": filterCategoryList,
              "filtersubcategory": filterSubCategoryList,
              "filterinnercategory": filterInnerCategoryList,
              "brands": brandsList,
              "brand_name": brandName,
              "min_price":minPrice,
              "max_price": maxPrice,
              "sizes": sizesList,
              "colors": colorsList,
              "sort_by": sortBy,
              "search": search
          })
          );
          _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {
            var responseData = response.body;
            FilterListDataModelClass filterListDataModelClass= filterListDataModelClassFromJson(responseData);
           filterProductList(filterListDataModelClass.data!.products!.data);
           _showToast(filterProductList.length.toString());

          }
          else {
            // Fluttertoast.cancel();

            _showToast("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
          _showToast(e.toString());
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

}