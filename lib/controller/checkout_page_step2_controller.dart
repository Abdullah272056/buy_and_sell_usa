
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../data_base/note.dart';
import 'package:http/http.dart' as http;
import '../data_base/notes_database.dart';
import '../view/dash_board/checkout step/productModel.dart';

class CheckoutPageStep2Controller extends GetxController {

  var totalPrice=0.0.obs;
  var cartList=[].obs;
  var sellerGroupList=[].obs;
  var selectedShippingValueList=[].obs;



  // var selectCountryId="".obs;
  // var countryList = [].obs;
  var expressShippingCheckList = [].obs;
  var totalTaxAmount=0.0.obs;


  var userName="".obs;
  var userToken="".obs;
  var zipCode="".obs;
  var surName="".obs;
  var mobileNumber="".obs;
  var totalAmountWithTax="".obs;
  var emailAddress="".obs;




  /// final calculation
  var allSubTotal="0.0".obs;
  var allShippingAmount="0.0".obs;
  var allTaxAmount="0.0".obs;
  var allTotalAmountWithAllCost="0.0".obs;


  dynamic argumentData = Get.arguments;
  @override
  void onInit() {


   // _showToast(argumentData[4]['totalAmountWithTax'].toString());
    zipCode(argumentData[1]['zipCode'].toString());
    surName(argumentData[2]['surName'].toString());
    mobileNumber(argumentData[3]['mobileNumber'].toString());
    totalAmountWithTax(argumentData[4]['totalAmountWithTax'].toString());
    emailAddress(argumentData[5]['emailAddress'].toString());

    readAllNotes();
    loadUserIdFromSharePref();
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

     allSubTotal(allSubTotalCalculate(cartList));
    allShippingAmount(allShippingPriceCalculate(cartList));
     allTaxAmount(allTaxCalculate(cartList));
    allTotalAmountWithAllCost((double.parse(allSubTotal.value)+ double.parse(allShippingAmount.value)+ double.parse(allTaxAmount.value)).toString());

   // _showToast("Local length= "+cartList.length.toString());
  }
  Future readAllNotes1() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());

    totalPriceCalculate(cartList);

    allSubTotal(allSubTotalCalculate(cartList));
    allShippingAmount(allShippingPriceCalculate(cartList));
    allTaxAmount(allTaxCalculate(cartList));

    allTotalAmountWithAllCost((double.parse(allSubTotal.value)+ double.parse(allShippingAmount.value)+ double.parse(allTaxAmount.value)).toString());

    // totalSellerCountCalculate(cartList);
    // _showToast("Local length= "+cartList.length.toString());
  }

  Future updateNotes(CartNote cartNote) async {
    NotesDataBase.instance;
    NotesDataBase.instance.update(cartNote)  ;
    readAllNotes1();
    // readAllNotes();

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

    totalPrice(subTotal+totalTax);


  }

  void totalSellerCountCalculate(List cartList){
    var seen = Set<String>();
    List  uniqueList = cartList.where((student) => seen.add(student.seller)).toList();
    sellerGroupList(uniqueList);


    List<String> sellerIdList=[];
    for(int i=0;i<sellerGroupList.length;i++){

      sellerIdList.add(sellerGroupList[i].seller.toString());
     // _showToast("aqw= "+sellerGroupList[i].seller.toString());

    }


    expressShippingCheck(sellerList: sellerIdList, zipCode:zipCode.value , token: userToken.value);


    List<String> abc = List.generate(4, (index) => "");
    selectedShippingValueList(abc);

  }


  ///final calculation
  String allSubTotalCalculate(List cartList1){
    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
      subTotal=(subTotal+oneItemPrice);
    }
    return subTotal.toString();

  }

  String allTaxCalculate(List cartList1){
    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);

      double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
      totalTax=(totalTax+singleProductTax);
    }
    return totalTax.toString();

  }

  String allShippingPriceCalculate(List cartList1){
    double shippingAmount=0.0;
    for(int i=0;i<cartList1.length;i++){
      shippingAmount=(shippingAmount+double.parse(cartList1[i].shipping));
    }

    return double.parse((shippingAmount).toStringAsFixed(2)).toString();
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

  // _showToast(storage.read(pref_user_token).toString());

    } catch (e) {

    }

  }



  expressShippingCheck({
    required List sellerList,
    required String zipCode,
    required String token,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          //_showToast("c 0");
          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_EXPRESS_SHIPPING_CHECK'),
              headers: {
                'Authorization': 'Bearer '+token,
                'Content-Type': 'application/json',
              },
              body: json.encode({
                "zipCode": zipCode,
                "sellerId": sellerList
                // "sellerId": sellerList
              })

          );

        // _showToast("check= "+response.statusCode.toString());


          if (response.statusCode == 200) {


            var data = jsonDecode(response.body);
            expressShippingCheckList(data["data"]);



          //  _showToast(expressShippingCheckList[0].length.toString());
          }

          else {
            var data = jsonDecode(response.body);
            // _showToast(data['message']);
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


  expressShippingCheck1({
    required String token,
    required String shippingType,
    required String shippingId,
    required String sellerId,
    required String totalPrice,
    required var productJson
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_EXPRESS_SHIPPING_AMOUNT'),
              headers: {
                'Authorization': 'Bearer '+token,
                'Content-Type': 'application/json',
              },
              body: json.encode({
                "handleShipping": [{
                  "shipping_type": shippingType,
                  "shipping_id": "null",
                  "seller_id": sellerId,
                  "total_price": totalPrice,
                  "products": productJson
                }
                ]
              })

          );
          _showToast("shippingType="+shippingType);
       //  _showToast("shippingType= "+shippingType.toString());


          if (response.statusCode == 200) {


             var data = jsonDecode(response.body);
             // _showToast(data["data"][0].length.toString());

             for(int j=0;j<data["data"][0].length;j++){

               for(int i=0;i<cartList.length;i++){

                 if(cartList[i].productId==data["data"][0][j]["product_id"]){

                   // _showToast("match");
                   // _showToast(data["data"][0][j]["rate"].toString());
                   CartNote cartNote=CartNote(
                       id:cartList[i].id ,
                       productId: cartList[i].productId,
                       productName: cartList[i].productName,
                       productRegularPrice: cartList[i].productRegularPrice,
                       productDiscountedPrice: cartList[i].productDiscountedPrice,
                       productPhoto: cartList[i].productPhoto,
                       productQuantity: cartList[i].productQuantity,
                       weight: cartList[i].weight,
                       seller: cartList[i].seller,
                       sellerName: cartList[i].sellerName,
                       slug: cartList[i].slug,
                       colorImage: cartList[i].colorImage,
                       size: cartList[i].size,
                       color: cartList[i].color,
                       // shipping: cartList[i].shipping,
                       shipping: data["data"][0][j]["rate"].toString(),
                       // shipping: "0.00".toString(),
                       sizeId: cartList[i].sizeId,
                       colorId: cartList[i].colorId,
                       grocery: cartList[i].grocery,
                       tax: cartList[i].tax,
                       width: cartList[i].width,
                       height: cartList[i].height,
                       depth: cartList[i].depth,
                       weightOption: cartList[i].weightOption,
                       commission: cartList[i].commission,
                       commissionType:cartList[i].commissionType
                   );

                   updateNotes(cartNote);



                 }

               }

             }



             _showToast(cartList.length.toString());






            // expressShippingCheckList(data["data"]);

            // _showToast(expressShippingCheckList[1].toString());
            //  _showToast(expressShippingCheckList[0].length.toString());
          }

          else {
            var data = jsonDecode(response.body);
            // _showToast(data['message']);
          }
          //   Get.back();

        } catch (e) {
          _showToast(e.toString());
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


  test1(
  //     {
  //   required String token,
  //   required String shippingType,
  //   required String shippingId,
  //   required String sellerId,
  //   required String totalPrice,
  //   required var productJson
  // }
  ) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          var headers = {
            'Authorization': 'Bearer 36|1K9t0q8HkttMxbAYWVOTw5JkT3cKGigCRc6HLt0R',
            'Content-Type': 'application/json',
            'Cookie': 'laravel_session=eyJpdiI6ImI3WjBkZlZ4SnlvOTdLUFhHVjlWY2c9PSIsInZhbHVlIjoiNGNBNk52eURTQzdlRlNCZGNFd1NyUS9WdEVaVXBlcVU4K2FmU3NBZVNFVmRHb25LQ3VaYTllQ1YrSmk4MlpWSlJTVWp3MzFJQWYzcTgxZDZUU3NhQ0ZNYklwUTU2dUFGckZ3UUd3S2E1MEU5d3IrUGRUN1N4UWZieklZQ1NiNmMiLCJtYWMiOiIzYzE4YTRhYjBiMzIxMGQ2NTZhNDNhMWNhYWVlYWQ3OTJmODlkMTFkNWY3Yjc3ZGI3ZjIwNTBmNzJiMzFiM2RlIiwidGFnIjoiIn0%3D'
          };
          var request = http.Request('POST', Uri.parse('http://192.168.0.115/bijoytech_ecomerce/api/order-store'));
          request.body = json.encode({
            "payment_info": {
              "coupon_code": null,
              "coupon_amount": null,
              "coupon_seller_id": null,
              "payment_id": "lptvcv25698452",
              "payer_id": "rony@gmail.com",
              "payment_method": "paypal",
              "shipping_name": "USPS Shipping in 2–5 Business Days"
            },
            "seller": [
              {
                "seller_id": 1,
                "shipping_charge": 8.8,
                "product": [
                  {
                    "product_id": 1,
                    "qty": 4,
                    "color_id": "1",
                    "size_id": null
                  }
                ]
              },
              {
                "seller_id": 3,
                "shipping_charge": 8.8,
                "product": [
                  {
                    "product_id": 2,
                    "qty": 1,
                    "color_id": null,
                    "size_id": null
                  }
                ]
              }
            ]
          });
          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();


          _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            print(await response.stream.bytesToString());
          }
          else {
            print(response.reasonPhrase);
          }

        } catch (e) {
          _showToast(e.toString());
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

  expressShippingCheck2({
    required String token,
    required String shippingType,
    required String shippingId,
    required String sellerId,
    required String totalPrice,
    required var productJson
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var headers = {
            'Authorization': 'Bearer '+token,
            'Content-Type': 'application/json'
          };
          var request = http.Request('POST', Uri.parse(
              '$BASE_URL_API$SUB_URL_API_EXPRESS_SHIPPING_AMOUNT'
              // 'http://192.168.0.115/bijoytech_ecomerce/api/express-shipping-amount'
          ));
          request.body = json.encode({
            "handleShipping": [{
                "shipping_type": shippingType,
                "shipping_id": "null",
                "seller_id": sellerId,
                "total_price": totalPrice,
                "products": productJson
              }
            ]
          });

          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();
          _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            print(await response.stream.bytesToString());
          }
          else {
            print(response.reasonPhrase);
          }

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

class Product{  //modal class
  String product_id, weight;

  Product({
    required this.product_id,
    required this.weight
  });
}