
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../api_service/api_service.dart';
import '../data_base/note.dart';
import '../data_base/notes_database.dart';
import '../model/FilterListDataModelClass.dart';

class ProductDetailsController extends GetxController {
  TextEditingController? searchController = TextEditingController();

  var categoryList=["Phone","Laptop","Book Book","Fresh Food","Fashion","Toys",
    "Grocery","Jewellery","Software","Car","Shoee","Matrix","Furniture","Building"].obs;
  var isDrawerOpen = false.obs;

  var subCategoriesButtonColorStatus=0.obs;
  var searchBoxVisible=0.obs;
  var selectedTabIndex=0.obs;
  var selectedPageIndex=1.obs;
  var selectedColorIndex=0.obs;
  var selectedSizeIndex=0.obs;
  var selectedTypeIndex=0.obs;

  var cartCount=0.obs;


  var productQuantity=1.obs;
  var totalPrice=0.00.obs;
  var productRegularPrice=0.0.obs;
  var productDiscountedPrice=0.0.obs;


  var abcd="0".obs;
  var productId="".obs;

  // var productDetailsData=[].obs;

  // List<CartNote> notesList=[].obs;
  var notesList=[].obs;
 dynamic argumentData = Get.arguments;


 var productName="".obs;
 var productDetails ="".obs;
 var productPrice="".obs;
 var productDiscountPrice="".obs;
 var productReviewCount="0".obs;
 var productReviewRating="0.0".obs;
 var productImage="".obs;
 var colorsList=[].obs;
 var sizeList=[].obs;
 var relatedProductList=[].obs;
  var filterProductList=[].obs;

  var productDetailsDataList=[].obs;



  // var productId="".obs;
  // var productName="".obs;
  // var productRegularPrice="".obs;
  // var productDiscountedPrice="".obs;
  // var productQuantity="".obs;
  var productPhoto="".obs;

  var weight="".obs;
  var seller="".obs;
  var sellerName="".obs;
  var slug="".obs;
  var colorImage="".obs;
  var  size="".obs;
  var color="".obs;
  var  sizeId="".obs;
  var colorId="".obs;
  var grocery="".obs;
  var tax="".obs;
  var shipping="".obs;
  var width="".obs;
  var height="".obs;
  var depth="".obs;
  var weightOption="".obs;
  var commission="".obs;
  var  commissionType="".obs;




  @override
  void onInit() {
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);
    productId(argumentData[0]['productId'].toString());
    _showToast(argumentData[0]['productId'].toString());
    getProductDetailsData(productId.value);

    refreshNotes();
    super.onInit();
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

  updateSelectedTabIndex(int index){
    selectedTabIndex(index);
  }

// Widget
  void onItemTapped(int index) {
    selectedTabIndex(index) ;
    // _selectedPageIndex = index;
    if(index==0){
      // selectedPage(HomePage( ));
      return;
    }
    if(index==1){
      //  selectedPage(HomePage( ));
      // selectedPage= ShopPage( );
      return;
    }
    if(index==2){
      // selectedPage= AccountPage( );
      return;
    }
    if(index==3){
      // selectedPage= CartPage( );
      return;
    }
    if(index==4){
      // selectedPage= SearchPage( );
      return;
    }
  }


  Future refreshNotes() async {
    NotesDataBase.instance;
    notesList(await NotesDataBase.instance.readAllNotes());
    cartCount(notesList.length);
   // _showToast("Local length= "+notesList.length.toString());
  }
  void insertData(CartNote cartNote){

    // CartNote abc= CartNote(
    //     productId: '12',
    //     productName: 'Test',
    //     productRegularPrice: '120',
    //     productDiscountedPrice: '100',
    //     productPhoto: 'https://cdn.vox-cdn.com/thumbor/UMnuubuFGIsw339rSvq3HtaoczQ=/0x0:2048x1280/2000x1333/filters:focal(1024x640:1025x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/22406771/Exbfpl2WgAAQkl8_resized.jpeg',
    //     productQuantity: '2'
    //
    //   // id: 1,
    //
    // );


    NotesDataBase.instance.create( cartNote);
    // NotesDataBase.instance.create( abc);

    refreshNotes();
  }

  void getProductDetailsData(String productId) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_INDIVIDUAL_PRODUCT_DETAILS}${productId}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {


            // var responseData = response.body;
            // FilterListDataModelClass filterListDataModelClass= filterListDataModelClassFromJson(responseData);
            // filterProductList(filterListDataModelClass.data!.products!.data);


            var dataResponse = jsonDecode(response.body);

            productDetailsDataList(dataResponse);


             productName(dataResponse[1]["product"]["product_name"].toString());
             productDetails (dataResponse[1]["product"]["short_description"].toString());
             productPrice(dataResponse[1]["product"]["price"].toString());
             productDiscountPrice(dataResponse[1]["product"]["price"].toString());

            productRegularPrice(double.parse(dataResponse[1]["product"]["price"].toString()));
             productDiscountedPrice(double.parse(dataResponse[1]["product"]["price"].toString()));

              productImage(dataResponse[1]["product"]["cover_image"].toString());
            colorsList(dataResponse[1]["product"]["colors"]);
            sizeList(dataResponse[1]["product"]["sizes"]);
            _showToast("color len=  "+dataResponse[1]["product"]["colors"].length.toString());
             if(dataResponse[1]["reviews"]!=null){
                productReviewRating(dataResponse[1]["product"]["price"].toString());
               productReviewCount(dataResponse[1]["reviews"].length.toString());

             }




             productPhoto(dataResponse[1]["product"]["cover_image"].toString());
             weight(dataResponse[1]["product"]["weight"].toString());
             width(dataResponse[1]["product"]["width"].toString());
             height(dataResponse[1]["product"]["height"].toString());
            depth(dataResponse[1]["product"]["depth"].toString());
            grocery(dataResponse[1]["product"]["grocery"].toString());
            commission(dataResponse[1]["product"]["commission"].toString());
            commissionType(dataResponse[1]["product"]["commissionType"].toString());
            tax(dataResponse[1]["product"]["tax_percent"].toString());
            seller(dataResponse[1]["product"]["seller"]["id"].toString());
            sellerName(dataResponse[1]["product"]["seller"]["name"].toString());
            slug(dataResponse[1]["product"]["slug"]["id"].toString());


           sizeId(sizeList[0]["size"]["id"].toString());
           size(sizeList[0]["size"]["name"].toString());
           colorId(colorsList[0]["color"]["id"].toString());
           color(colorsList[0]["color"]["name"].toString());


            shipping("");
            weightOption("");
            colorImage("");



            getCategoriesProductsDataList(categoryId: dataResponse[1]["product"]["category_id"].toString(),
                subcategoryId: "",
                innerCategoryId: '', filterCategoryList: [],
                filterSubCategoryList: [], filterInnerCategoryList: [],
                brandName: '', minPrice: '', sortBy: '', search: '',
                brandsList: [], sizesList: [], colorsList: [], maxPrice: '');


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


  void getCategoriesProductsDataList({
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
             _showToast("related="+filterProductList.length.toString());

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