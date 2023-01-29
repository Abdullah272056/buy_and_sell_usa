
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import '../../view/common/toast.dart';

class HomeController extends GetxController {

  final searchController = TextEditingController().obs;
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

  var categoriesDataListForTab=[].obs;

  var userName="".obs;
  var userToken="".obs;

  var homeShimmerStatus=1.obs;
  var tabShimmerStatus=1.obs;

  // dynamic argumentData = Get.arguments;

  void ref(){
    onInit();
  }
  @override
  void onInit() {
    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);
    loadUserIdFromSharePref();
    super.onInit();


    loadUserIdFromSharePref();
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
     //_showToast("Token= "+storage.read(pref_user_token).toString());
    }catch(e){

    }

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
          homeShimmerStatus(1);
         // showLoadingDialog("loading...");
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_HOME_DATA}'),
          );
         // Get.back();
        //  _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {


             var homeDataResponse = jsonDecode(response.body);
             homeDataList(homeDataResponse["data"]);
             homeShimmerStatus(0);
           //  retriveUserInfo();
            // _showToast("size  "+homeDataList.length.toString());
          }
          else {
            // Fluttertoast.cancel();
            showToastShort("failed try again!");
          }
        } catch (e) {
          // Fluttertoast.cancel();
        }
      }
      else{
        showToastShort("No Internet Connection!");
      }
    } on SocketException {
    //  Fluttertoast.cancel();
      showToastShort("No Internet Connection!");
    }
  }

  void getCategoriesDataList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          tabShimmerStatus(1);
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ONLY_CATEGORIES_LIST}'),

          );
         //   _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var homeDataResponse = jsonDecode(response.body);
            categoriesDataList(homeDataResponse["data"]);


            tabShimmerStatus(0);
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


  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));



   //   _showToast("Token1= "+storage.read(pref_user_token).toString());

    } catch (e) {

    }

  }

  addWishList({
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


  void showLoadingDialog(String message) {

    Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [
            Container(
              alignment: Alignment.center,
              // margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 20),
              child:Column(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height:50,
                    width: 50,
                    margin: EdgeInsets.only(top: 10),
                    child: CircularProgressIndicator(
                      backgroundColor: awsStartColor,
                      color: awsEndColor,
                      strokeWidth: 6,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child:Text(
                      message,
                      style: const TextStyle(fontSize: 25,),
                    ),
                  ),

                ],
              ),
            )
          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }

}