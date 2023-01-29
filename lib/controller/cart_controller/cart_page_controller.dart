
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/note.dart';
import '../../data_base/sqflite/notes_database.dart';
import 'cart__view_page_controller.dart';

class CartPageController extends GetxController {



  // List<CartNote> notesList=[].obs;
  var totalPrice=0.0.obs;
  var cartList=[].obs;

  var userName="".obs;
  var userToken="".obs;
  var cartListShimmerStatus=1.obs;

  var couponDataList = [].obs;
  var sellerGroupList=[].obs;

  // dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);
    loadAllCartNotes();
    loadUserIdFromSharePref();
    super.onInit();
  }




  Future loadAllCartNotes() async {
    cartListShimmerStatus(1);
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());
    cartListShimmerStatus(0);
    totalPriceCalculate(cartList);
    sellerIdUnique(cartList);


   // _showToast("Local length= "+cartList.length.toString());
  }

  Future loadAllCartNotesAgain() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());
    sellerIdUnique(cartList);


    var seen = Set<String>();
    List  uniqueList = cartList.where((student) => seen.add(student.seller)).toList();
    sellerGroupList(uniqueList);

    couponDataList([]);

    for(int i=0;i<sellerGroupList.length;i++){
      CouponData couponData=CouponData(sellerId: sellerGroupList[i].seller, couponStatus: 'true', couponAmount: '', couponCode: '');
      couponDataList.add(couponData);
    }

  }

  void sellerIdUnique(List cartList){
    var seen = Set<String>();
    List  uniqueList = cartList.where((student) => seen.add(student.seller)).toList();
    sellerGroupList(uniqueList);

    couponDataList([]);

    for(int i=0;i<sellerGroupList.length;i++){
      CouponData couponData=CouponData(sellerId: sellerGroupList[i].seller, couponStatus: 'true', couponAmount: '', couponCode: '');
      couponDataList.add(couponData);
    }

  }

  Future deleteNotes(int id) async {
    NotesDataBase.instance;
    NotesDataBase.instance.delete(id)  ;
    loadAllCartNotes();

  }

  void totalPriceCalculate(List cartList){
    double subTotal=0.0;
    for(int i=0;i<cartList.length;i++){
      double oneItemPrice=double.parse(cartList[i].productQuantity)*double.parse(cartList[i].productDiscountedPrice);
       subTotal=(subTotal+oneItemPrice);
    }
    totalPrice(double.parse((subTotal).toStringAsFixed(2)));
    // totalPrice(subTotal);

  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {

      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));
      //  _showToast(storage.read(pref_user_token).toString());

    } catch (e) {
    }
  }


}