
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data_base/note.dart';
import '../data_base/notes_database.dart';

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
  var productRegularPrice=5000.0.obs;
  var productDiscountedPrice=4500.0.obs;


  var abcd="0".obs;

  // List<CartNote> notesList=[].obs;
  var notesList=[].obs;

  // dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);
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

}