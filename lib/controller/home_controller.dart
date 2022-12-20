
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController? searchController = TextEditingController();

  var categoryList=["Phone","Laptop","Book Book","Fresh Food","Fashion","Toys",
    "Grocery","Jewellery","Software","Car","Shoee","Matrix","Furniture","Building"].obs;
  var isDrawerOpen = false.obs;

  var subCategoriesButtonColorStatus=0.obs;

  var searchBoxVisible=0.obs;

  var selectedTabIndex=0.obs;
  var selectedPageIndex=1.obs;
  var abcd="0".obs;

  // dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);
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

}