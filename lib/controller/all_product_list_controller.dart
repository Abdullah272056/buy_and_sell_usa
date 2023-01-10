
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../model/CategoriesData.dart';
import '../model/FilterListDataModelClass.dart';
import '../model/FilterListDataModelClass2.dart';
import '../static/Colors.dart';

class AllProductListPageController extends GetxController {
  dynamic argumentData = Get.arguments;
  var filterProductList=[].obs;
  var showFilterStatus=1.obs;

  var selectCategoriesId="".obs;
  var categoriesList = [].obs;

  var selectColorsId="".obs;
  var colorsList = [].obs;

  var selectSizeId="".obs;
  var sizeList = [].obs;

  var selectBrandsId="".obs;
  var brandsList = [].obs;

  var selectSubCategoriesId="".obs;
  var subCategoriesList = [].obs;

  var selectInnerCategoriesId="".obs;
  var innerCategoriesList = [].obs;


  ////selected data
  var categoryId="".obs;
  var subCategoryId="".obs;
  var selectedInnerCategoryId= ''.obs;
  var selectedFilterCategoryList= [].obs;
  var selectedFilterSubCategoryList= [].obs;
  var selectedFilterInnerCategoryList= [].obs;
  var selectedBrandName= ''.obs;
  var selectedMinPrice= ''.obs;
  var selectedSortBy= ''.obs;
  var selectedSearch=''.obs;
  var selectedBrandsList= [].obs;
  var selectedSizesList= [].obs;
  var selectedColorsList= [].obs;
  var selectedMaxPrice= "".obs;

  var userName="".obs;
  var userToken="".obs;



  @override
  void onInit() {
    super.onInit();

    // _showToast(argumentData[0]['categoriesId']);
    // _showToast(argumentData[1]['subCategoriesId']);
    loadUserIdFromSharePref();

    getColors();
    getProductSize();
    getCategories();
    getBrands();
    getSubCategoriesList();
    categoryId(argumentData[0]['categoriesId']);
    subCategoryId(argumentData[1]['subCategoriesId']);
    selectedSearch(argumentData[2]['searchValue']);

    getCategoriesProductsDataList(
        categoryId: categoryId.value,
        subcategoryId: subCategoryId.value,
        innerCategoryId: selectedInnerCategoryId.value,
        filterCategoryList: selectedFilterCategoryList,
        filterSubCategoryList:selectedFilterSubCategoryList,
        filterInnerCategoryList: selectedFilterInnerCategoryList,
        brandName: selectedBrandName.value,
        minPrice: selectedMinPrice.value,
        sortBy: selectedSortBy.value,
        search: selectedSearch.value,
        brandsList: selectedBrandsList,
        sizesList: selectedSizesList,
        colorsList: selectedColorsList,
        maxPrice: selectedMaxPrice.value);



    // getCategoriesProductsDataList(categoryId: argumentData[0]['categoriesId'],
    //     subcategoryId: argumentData[1]['subCategoriesId'],
    //     innerCategoryId: '', filterCategoryList: [],
    //     filterSubCategoryList: [], filterInnerCategoryList: [],
    //     brandName: 'admin', minPrice: '', sortBy: '', search: '',
    //     brandsList: [], sizesList: [], colorsList: [], maxPrice: '');

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

  void getCategories() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_CATEGORIES}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            categoriesList(dataResponse["data"]);
          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  void getColors() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_COLOR_LIST}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            colorsList(dataResponse["data"]);
           // _showToast("Colors= "+colorsList.length.toString());
          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  void getProductSize() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_SIZE_LIST}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            sizeList(dataResponse["data"]);
           // _showToast("Colors= "+sizeList.length.toString());
          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  void getBrands() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_BRANDS_LIST}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            brandsList(dataResponse["data"]);
           // _showToast("brandsList= "+brandsList.length.toString());
          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again111!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  void getSubCategoriesList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_SUBCATEGORIES}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            subCategoriesList(dataResponse["data"]);
           // _showToast("brandsList= "+brandsList.length.toString());
          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again111!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  void getInnerCategoriesList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_INNER_CATEGORIES}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            innerCategoriesList(dataResponse["data"]);
          //   _showToast("innerCategoriesList= "+innerCategoriesList.length.toString());
          }
          else {
            // Fluttertoast.cancel();
            _showToast("failed try again111!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  void getCategoriesProductsDataList({
    required String categoryId,
    required String subcategoryId,
    required String innerCategoryId,
    required List filterCategoryList,
    required List filterSubCategoryList,
    required List filterInnerCategoryList,
    required String brandName,
    required String minPrice,
    required String maxPrice,
    required String sortBy,
    required String search,
    required List brandsList,
    required List sizesList,
    required List colorsList
  }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try {
          var response = await post(

              // Uri.parse('http://192.168.68.106/bijoytech_ecomerce/api/products'),
              Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_PRODUCT_DATA_LIST}'),

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
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {
            var responseData = response.body;
            FilterListDataModelClass filterListDataModelClass= filterListDataModelClassFromJson(responseData);
            filterProductList(filterListDataModelClass.data!.products!.data);
          //  _showToast(filterProductList.length.toString());

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

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));

    } catch (e) {

    }

  }

}