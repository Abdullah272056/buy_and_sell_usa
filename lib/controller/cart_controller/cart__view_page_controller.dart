
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/note.dart';
import 'package:http/http.dart' as http;
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import '../../view/common/loading_dialog.dart';
import '../../view/common/toast.dart';

class CartViewPageController extends GetxController {

  var totalPrice=0.0.obs;
  var totalSuTotalPrice=0.0.obs;
  var totalTaxPrice=0.0.obs;

  var cartList=[].obs;
  var sellerGroupList=[].obs;

  // var sellerCouponStatusCheck=[].obs;
  var textFieldControllers = [].obs;
  // var sellerCouponAmount = [].obs;
  var couponDataList = [].obs;

  var userName="".obs;
  var userToken="".obs;
  var inputLevelTextColor = hint_color.obs;
  final promoCodeController = TextEditingController().obs;

  var couponCodes= "".obs;
  var couponAmount="".obs;
  var couponSellerId="".obs;

  var promoCodeServerResponse=0.obs;

  @override
  void onInit() {
    readAllNotes();
    loadUserIdFromSharePref();
    super.onInit();
  }



  Future readAllNotes() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());

    totalPriceCalculate(cartList);
    subTotalPriceCalculate(cartList);
    totalSellerCountCalculate(cartList);
    totalTaxPriceCalculate(cartList);
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

    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);

      double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
      totalTax=(totalTax+singleProductTax);
    }

    totalPrice((double.parse((subTotal).toStringAsFixed(2))+double.parse((totalTax).toStringAsFixed(2))));


  }
  void totalTaxPriceCalculate(List cartList1){

    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
      double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
      totalTax=(totalTax+singleProductTax);
    }

    totalTaxPrice(double.parse((totalTax).toStringAsFixed(2)));

  }
  void subTotalPriceCalculate(List cartList1){
    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
       subTotal=(subTotal+oneItemPrice);
    }
    totalSuTotalPrice(double.parse((subTotal).toStringAsFixed(2)));
  }

  void totalSellerCountCalculate(List cartList){
    var seen = Set<String>();
    List  uniqueList = cartList.where((student) => seen.add(student.seller)).toList();
    sellerGroupList(uniqueList);
    final generated = List.generate(sellerGroupList.length, (index) => "1");
    // sellerCouponStatusCheck(generated);

    List onlySellerIdList=[];
    textFieldControllers([]);
    for(int i=0;i<sellerGroupList.length;i++){
      onlySellerIdList.add(sellerGroupList[i].seller);
      textFieldControllers.add(TextEditingController(text: ""));
    }

    // for(int i=0;i<sellerCouponStatusCheck.length;i++){
    // //  textFieldControllers.add(TextEditingController());
    //   sellerCouponAmount.add("0.0");
    //  // sellerCouponCodeAvailableCheck(sellerId: sellerGroupList[i].seller, index: i);
    //  // couponDataList()
    // }

   // _showToast("call=  "+onlySellerIdList.length.toString());

    couponDataList([]);

    sellerCouponCodeAvailableCheckList(sellerList: onlySellerIdList);


  }
  void totalSellerCountCalculate1(List cartList){
    var seen = Set<String>();
    List  uniqueList = cartList.where((student) => seen.add(student.seller)).toList();
    sellerGroupList(uniqueList);
    final generated = List.generate(sellerGroupList.length, (index) => "1");
   // sellerCouponStatusCheck(generated);

    // for(int i=0;i<sellerCouponStatusCheck.length;i++){
    //   textFieldControllers.add(TextEditingController());
    //   sellerCouponAmount.add("0.0");
    //
    //
    //   // sellerCouponCodeAvailableCheck(sellerId: sellerGroupList[i].seller, index: i);
    //
    //
    //
    //
    //   // couponDataList()
    //
    // }


  }

  // couponCodeCheck1({
  //   required String token,
  //   required String couponCode,
  //   required var couponInfoJson
  // }) async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       try {
  //         var headers = {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': 'application/json'
  //         };
  //         var request = http.Request('POST', Uri.parse(
  //            "$BASE_URL_API$SUB_URL_API_COUPON_CODE_CHECK"
  //             //'http://192.168.0.115/bijoytech_ecomerce/api/coupon-check'
  //         ));
  //         request.body = json.encode({
  //           "coupon_code": couponCode,
  //           "coupon_info":couponInfoJson
  //         });
  //         request.headers.addAll(headers);
  //
  //         http.StreamedResponse response = await request.send();
  //
  //         _showToast(response.statusCode.toString());
  //
  //         if (response.statusCode == 200) {
  //           var homeDataResponse = jsonDecode(response.body);
  //
  //           _showToast(message)
  //
  //           print(await response.stream.bytesToString());
  //         }
  //         else {
  //           _showToast("Invalid Promo Code!");
  //           print(response.reasonPhrase);
  //         }
  //
  //
  //       } catch (e) {
  //         //  Navigator.of(context).pop();
  //         //print(e.toString());
  //       } finally {
  //         //   Get.back();
  //
  //         /// Navigator.of(context).pop();
  //       }
  //     }
  //   } on SocketException catch (_) {
  //
  //     Fluttertoast.cancel();
  //     _showToast("No Internet Connection!");
  //   }
  // }

  couponCodeCheck({
    required String token,
    required String couponCode,
    required var couponInfoJson
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          showLoadingDialog("Checking...");
          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_COUPON_CODE_CHECK'),
               headers : {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
              },
              body: json.encode({
                "coupon_code": couponCode,
                "coupon_info":couponInfoJson
              })
          );
          // _showToast(response.statusCode.toString());
          Get.back();
          if (response.statusCode == 200) {
            showToastShort("success");

            var couponCodeResponse = jsonDecode(response.body);
            couponCodes(couponCodeResponse["data"]["coupon_info"]["code"].toString());
             couponAmount(couponCodeResponse["data"]["coupon_info"]["coupon_amount"].toString());
            //  couponSellerId(couponCodeResponse["data"]["coupon_info"]["seller_id"].toString());
            couponSellerId(double.parse(couponCodeResponse["data"]["coupon_info"]["seller_id"].toStringAsFixed(2)).toString());

          }
          else {
            promoCodeController.value.text="";
            showToastShort("Invalid Promo Code!");
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



  sellerCouponCodeAvailableCheckList({
    required List sellerList,
  })  async

  {
    promoCodeServerResponse(0);
    showLoadingDialog("Checking...");
    var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_COUPON_AVAILABLE_SELLER_LIST'),
      headers : {
        //'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
        body:json.encode({
          "seller_id": sellerList
        }),

    );
    Get.back();
   //   _showToast("check list= "+response.statusCode.toString());
    if (response.statusCode == 200) {
      promoCodeServerResponse(1);

      var responseCoupon = jsonDecode(response.body);

      for(int i=0;i<responseCoupon["data"].length;i++){
        couponDataList.add(CouponData(
            sellerId: responseCoupon["data"][i]["seller_id"].toString(),
            couponStatus: responseCoupon["data"][i]["promoCodeStatus"].toString(),
            couponAmount: '',
            couponCode: ''
        ));
      }

     // _showToast("couponDataList=  "+couponDataList.length.toString());

    }

  }

  sellerCouponCodeAvailableCheck({
      required String sellerId,
      required int index,
    })  async {
   var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_COUPON_AVAILABLE_SELLER'),
       body: {
         // "seller_id": sellerId,
         "seller_id": sellerId,
       }
   );
 //  _showToast("check= "+response.statusCode.toString());
   if (response.statusCode == 200) {
     promoCodeServerResponse(1);
     var responseCoupon = jsonDecode(response.body);
     //_showToast(sellerId.toString());
    //sellerCouponStatusCheck[index]=responseCoupon["promoCodeStatus"].toString();

     couponDataList.add(CouponData(
         sellerId: sellerId.toString(),
         couponStatus: responseCoupon["promoCodeStatus"].toString(),
         couponAmount: '',
         couponCode: ''
     ));
     // _showToast("sellerId ="+sellerId);
     // _showToast("couponDataList ="+couponDataList[index].couponStatus.toString());
    // sellerCouponStatusCheck[index](responseCoupon["promoCodeStatus"].toString());

     //_showToast(sellerCouponStatusCheck[index].toString());

   }

  }


  couponCodeCheckIndividual({
    required String token,
    required String couponCode,
    required String sellerId,
    required String totalAmount,
    required int index,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          showLoadingDialog("Checking...");
          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_COUPON_CODE_CHECK_INDIVIDUAL'),
              headers : {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json'
              },
              body: json.encode({
                "coupon_code": couponCode,
                "seller_id":sellerId,
                "buyed_amount":totalAmount
              })
          );

         // _showToast(response.statusCode.toString());
          Get.back();
          if (response.statusCode == 200) {

            showToastShort("Successfully!".toString());

            var couponCodeResponse = jsonDecode(response.body);

            String  amount=double.parse(couponCodeResponse["data"]['coupon_amount_result'].toString()).toStringAsFixed(2);
            CouponData couponData= CouponData(
                sellerId: sellerId.toString(),
                couponStatus: "true",
                couponAmount: amount,
                couponCode: couponCode.toString()
            );

            couponDataList[index]=couponData;


           // _showToast(couponDataList[index].couponAmount);

          }
          else {

            textFieldControllers[index].text="";

            CouponData couponData= CouponData(
                sellerId: sellerId.toString(),
                couponStatus: "true",
                couponAmount: "",
                couponCode: ""
            );

            couponDataList[index]=couponData;

            // promoCodeController.value.text="";
            showToastShort("Your promo code is not valid!");
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




  ///user info with share pref
  void saveUserInfo({required String userName,required String userToken,}) async {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, userName);
      storage.write(pref_user_token, userToken);
    } catch (e) {
      //code
    }
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


class CouponData{
  String sellerId;
  String couponStatus;
  String couponAmount;
  String couponCode;

  CouponData({
    required this.sellerId,
    required this.couponStatus,
    required this.couponAmount,
    required this.couponCode
      });
}

