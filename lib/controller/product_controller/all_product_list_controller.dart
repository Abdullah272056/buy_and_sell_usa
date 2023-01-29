
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../static/Colors.dart';
import '../../view/common/toast.dart';

class AllProductListPageController extends GetxController {


  final minPriceController = TextEditingController().obs;
  final maxPriceController = TextEditingController().obs;

  final  minPriceFocusNode = FocusNode().obs;
  final  maxPriceFocusNode = FocusNode().obs;
  var userEmailLevelTextColor = hint_color.obs;

  dynamic argumentData = Get.arguments;
  var filterProductLis1=[].obs;
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

  var selectedSortBy= ''.obs;
  var selectedSearch=''.obs;
  var selectedBrandsList= [].obs;
  var selectedSizesList= [].obs;
  var selectedColorsList= [].obs;
  var selectedMinPrice= ''.obs;
  var selectedMaxPrice= "".obs;

  var userName="".obs;
  var userToken="".obs;


  var pageNo="1".obs;
  var perPage="18".obs;

  var allProductList=[].obs;



  var isFirstLoadRunning = true.obs;
  var hasNextPage = true.obs;
  var isMoreLoadRunning = false.obs;
  var productShimmerStatus=1.obs;

  ScrollController controller=ScrollController();

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
        maxPrice: selectedMaxPrice.value,
        pageNo: pageNo.value,
        perPage: perPage.value,

    );


    /// homePageController.firstLoad();
    controller.addListener(() async{
      if(controller.position.maxScrollExtent==controller.position.pixels){

        int pageNoInt=int.parse(pageNo.value.toString());
        pageNoInt++;

        pageNo(pageNoInt.toString());
       // _showToast("page no= "+pageNoInt.toString());

        if( hasNextPage == true ){

          getCategoriesProductsDataList2(
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
            maxPrice: selectedMaxPrice.value,

            pageNo: pageNoInt.toString(),
            perPage: perPage.value,

          );

        }


      }

    });

  }


  addWishList(
      {
        required String token,
        required String productId
      }
      ) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          //  _showToast("1");
          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_ADD_WISGLIST'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
            body: {
              'product_id': productId,
            },
          );

          // _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            showToastShort("Wishlist added Successfully!");
          }
          else {
            var data = jsonDecode(response.body);
            showToastShort(data['message']);
          }
          //   Get.back();

        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {
          //   Get.back();

          /// Navigator.of(context).pop();
        }
      }
    } on SocketException catch (_) {

      Fluttertoast.cancel();
      showToastShort("No Internet Connection!");
    }
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
            showToastShort("failed try again!");
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
            showToastShort("failed try again!");
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
            showToastShort("failed try again!");
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
            showToastShort("failed try again111!");
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
            showToastShort("failed try again111!");
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
            showToastShort("failed try again111!");
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
    required List colorsList,
    required String pageNo,
    required String perPage
  }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try {
          productShimmerStatus(1);
          isFirstLoadRunning(true);
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
                "search": search,
                "page_no": pageNo,
                "per_page": perPage,
              })
          );
          isFirstLoadRunning(false);
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {
            // var responseData = response.body;
            var responseData = jsonDecode(response.body);

            allProductList(responseData["data"]["products"]);
            productShimmerStatus(0);

          //  _showToast(allProductList.length.toString());

            // FilterListDataModelClass filterListDataModelClass= filterListDataModelClassFromJson(responseData);
            // filterProductList(filterListDataModelClass.data!.products!.data);
          //  _showToast(filterProductList.length.toString());

          }
          else {
            // Fluttertoast.cancel();

            showToastShort("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
          showToastShort(e.toString());
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }

  void getCategoriesProductsDataList2({
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
    required List colorsList,
    required String pageNo,
    required String perPage
  }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try {
         isMoreLoadRunning(true);
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
                "search": search,
                "page_no": pageNo,
                "per_page": perPage,
              })
          );
         isMoreLoadRunning(false);
         // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {
            var responseData = jsonDecode(response.body);

            if(responseData["data"]["products"].length>0){
              allProductList.addAll(responseData["data"]["products"]);
            }else{

              hasNextPage(false);

            }



           // allProductList(responseData["data"]["products"]);

         //  _showToast("lent="+allProductList.length.toString());

          }
          else {
            // Fluttertoast.cancel();

            showToastShort("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
          showToastShort(e.toString());
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      // _showToast("No Internet Connection!");
    }
  }


  //get next page data
  // void nextPageHandle() async{
  //   if(
  //   hasNextPage ==true &&
  //       isFirstLoadRunning==false &&
  //       isMoreLoadRunning==false
  //   ){
  //
  //     updateIsMoreLoadRunning(true);
  //
  //     updatePageNumber();
  //     //page number increase
  //
  //     try {
  //       final result = await InternetAddress.lookup('example.com');
  //       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //
  //
  //         try {
  //           var response = await get(
  //             Uri.parse('https://jsonplaceholder.typicode.com/todos?_page=${pageNumber}&_limit=${ limitCount}'),
  //
  //           );
  //           if (response.statusCode == 200) {
  //             final List fetchData=json.decode(response.body);
  //
  //             if(fetchData.isNotEmpty){
  //               var data = response.body;
  //               updateTodoList(todoListModelFromJson(data));
  //
  //
  //             }else{
  //
  //               updateHasNextPage(false);
  //
  //             }
  //
  //
  //           }
  //           else {
  //             Fluttertoast.cancel();
  //           }
  //         } catch (e) {
  //           // Fluttertoast.cancel();
  //
  //         }
  //       }
  //     } on SocketException catch (e) {
  //       Fluttertoast.cancel();
  //       // _showToast("No Internet Connection!");
  //     }
  //
  //     updateIsMoreLoadRunning(false);
  //
  //   }
  //
  //
  //
  // }

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