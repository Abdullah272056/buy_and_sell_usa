
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../data_base/notes_database.dart';

class HomeController extends GetxController {
  TextEditingController? searchController = TextEditingController();

  // var categoryList=["Phone","Laptop","Book Book","Fresh Food","Fashion","Toys",
  //   "Grocery","Jewellery","Software","Car","Shoee","Matrix","Furniture","Building"].obs;
  var isDrawerOpen = false.obs;

  var subCategoriesButtonColorStatus=0.obs;

  var searchBoxVisible=0.obs;

  var selectedTabIndex=0.obs;
  var selectedPageIndex=1.obs;
  var abcd="0".obs;
  var notesList=[].obs;
  var cartCount=0.obs;


  var homeDataList=[].obs;
  var categoriesDataList=[].obs;

  var userName="".obs;
  var userToken="".obs;

  // dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);

    super.onInit();


    //loadUserIdFromSharePref();
    refreshNotes();
    getHomeData();
    getCategoriesDataList();

  }

  Future refreshNotes() async {
    NotesDataBase.instance;
    notesList(await NotesDataBase.instance.readAllNotes());
    cartCount(notesList.length);
    retriveUserInfo();
    //_showToast("Local length= "+notesList.length.toString());
  }

  ///get user data from share pref
  void retriveUserInfo() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name).toString());
      userToken(storage.read(pref_user_token).toString());
     _showToast("Token= "+storage.read(pref_user_token).toString());
    }catch(e){

    }

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


  void getHomeData() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_HOME_DATA}'),
          );
        //  _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {
             var homeDataResponse = jsonDecode(response.body);
             homeDataList(homeDataResponse["data"]);
           //  retriveUserInfo();
            // _showToast("size  "+homeDataList.length.toString());
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

  void getCategoriesDataList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ONLY_CATEGORIES_LIST}'),

          );
         //   _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {
            var homeDataResponse = jsonDecode(response.body);
            categoriesDataList(homeDataResponse["data"]);


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


  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));

      _showToast("Token= "+storage.read(pref_user_token).toString());

    } catch (e) {

    }

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
              _showToast("Wishlist added Successfully!");
            }
            else {
              var data = jsonDecode(response.body);
              _showToast(data['message']);
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
      _showToast("No Internet Connection!");
    }
  }


}