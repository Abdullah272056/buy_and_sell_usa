
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data_base/note.dart';
import '../data_base/notes_database.dart';

class CartViewPageController extends GetxController {

  var totalPrice=0.0.obs;
  var cartList=[].obs;
  var sellerGroupList=[].obs;

  @override
  void onInit() {
    readAllNotes();
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


  Future readAllNotes() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());

    totalPriceCalculate(cartList);
    totalSellerCountCalculate(cartList);
   // _showToast("Local length= "+cartList.length.toString());
  }
  Future updateNotes(CartNote cartNote) async {
    NotesDataBase.instance;
    NotesDataBase.instance.update(cartNote)  ;
    readAllNotes();

  }

  Future deleteNotes(int id) async {
    NotesDataBase.instance;
    NotesDataBase.instance.delete(id)  ;
    readAllNotes();

  }


  void totalPriceCalculate(List cartList1){
    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
       subTotal=(subTotal+oneItemPrice);
    }
    totalPrice(subTotal);

  }
  

  void totalSellerCountCalculate(List cartList){
    var seen = Set<String>();
    List  uniqueList = cartList.where((student) => seen.add(student.seller)).toList();
    sellerGroupList(uniqueList);
    _showToast("remove="+uniqueList.length.toString());
  }


}