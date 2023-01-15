
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


class CheckoutPageStep2Controller extends GetxController {

  var totalPrice=0.0.obs;
  var cartList=[].obs;
  var sellerGroupList=[].obs;
  var selectedShippingNameWithSellerIdList=[].obs;
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

  var couponCodes= "".obs;
  var couponAmount="".obs;
  var couponSellerId="".obs;

  dynamic argumentData = Get.arguments;


  @override
  void onInit() {

   // _showToast(argumentData[4]['totalAmountWithTax'].toString());
    zipCode(argumentData[1]['zipCode'].toString());
    surName(argumentData[2]['surName'].toString());
    mobileNumber(argumentData[3]['mobileNumber'].toString());
    totalAmountWithTax(argumentData[4]['totalAmountWithTax'].toString());
    emailAddress(argumentData[5]['emailAddress'].toString());

    couponCodes(argumentData[6]['couponCodes'].toString());
    couponAmount(argumentData[7]['couponAmount'].toString());
    couponSellerId(argumentData[8]['couponSellerId'].toString());

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

    double totalAmount = double.parse((double.parse(allSubTotal.value)+ double.parse(allShippingAmount.value)+ double.parse(allTaxAmount.value)).toStringAsFixed(2));
    allTotalAmountWithAllCost(
        totalAmount.toString()
    );

   // _showToast("Local length= "+cartList.length.toString());
  }
  Future readAllNotes1() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());

    totalPriceCalculate(cartList);

    allSubTotal(allSubTotalCalculate(cartList));
    allShippingAmount(allShippingPriceCalculate(cartList));
    allTaxAmount(allTaxCalculate(cartList));

    double totalAmount = double.parse((double.parse(allSubTotal.value)+ double.parse(allShippingAmount.value)+ double.parse(allTaxAmount.value)).toStringAsFixed(2));
    allTotalAmountWithAllCost(
        totalAmount.toString()
    );

  //  allTotalAmountWithAllCost((double.parse(allSubTotal.value)+ double.parse(allShippingAmount.value)+ double.parse(allTaxAmount.value)).toString());

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


      selectedShippingNameWithSellerIdList.add(SelectedShippingNameWithSellerId(seller_id: sellerGroupList[i].seller.toString(), shipping_name: ''));


     // _showToast("aqw= "+sellerGroupList[i].seller.toString());

    }



    expressShippingCheck(sellerList: sellerIdList, zipCode:zipCode.value , token: userToken.value);
   // _showToast("awe= "+selectedShippingNameWithSellerIdList.length.toString());


    List<String> abc = List.generate(sellerIdList.length, (index) => "");
    selectedShippingValueList(abc);

  }


  ///final calculation
  String allSubTotalCalculate(List cartList1){
    double subTotal=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);
      subTotal=(subTotal+oneItemPrice);
    }
    return double.parse((subTotal).toStringAsFixed(2)).toString();

    //  subTotal.toString();

  }

  String allTaxCalculate(List cartList1){
    double totalTax=0.0;
    for(int i=0;i<cartList1.length;i++){
      double oneItemPrice=double.parse(cartList1[i].productQuantity)*double.parse(cartList1[i].productDiscountedPrice);

      double singleProductTax=(double.parse(cartList1[i].tax)*oneItemPrice)/100;
      totalTax=(totalTax+singleProductTax);
    }
    return double.parse((totalTax).toStringAsFixed(2)).toString();

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

       // _showToast("zipCode= "+zipCode.toString());
       // _showToast("sellerList = "+sellerList.length.toString());


          if (response.statusCode == 200) {


            var data = jsonDecode(response.body);
            expressShippingCheckList(data["data"]);



        //   _showToast("abs="+expressShippingCheckList[0].length.toString());
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


  expressShippingCheckAmount({
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
          showLoadingDialog("Checking...");
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

            Get.back();
            _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {

            var data = jsonDecode(response.body);

          //  _showToast(data["data"][0].length.toString());

             for(int j=0;j<data["data"][0].length;j++){



               for(int i=0;i<cartList.length;i++){

                 if(cartList[i].productId.toString()==data["data"][0][j]["product_id"].toString()){
                   if(shippingType.toString()=="1"){
                   //  _showToast("rate="+data["data"][0][j]["rate"].toString());
                     CartNote cartNote=CartNote(
                         id:cartList[i].id ,
                         productId: cartList[i].productId.toString(),
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
                         shipping:data["data"][0][j]["rate"].toString(),
                         shippingName: data["data"][0][j]["shipping_name"].toString(),
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
                   else{
                    // _showToast("rate="+data["data"][0][j]["rate"].toString());
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
                         shipping: data["data"][0][j]["rate"].toString(),
                         shippingName: data["data"][0][j]["shipping_name"].toString(),
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

             }

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
                      backgroundColor: fnf_color,
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

  test1({
    required String token,
    required String coupon_code,
    required String coupon_amount,
    required String coupon_seller_id,
    required String payment_id,
    required String payer_id,
    required String payment_method,
    required String shipping_name,
    required var productJson
  }
  ) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          var headers = {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          };
          var request = http.Request('POST', Uri.parse('http://192.168.0.115/bijoytech_ecomerce/api/order-store'));
          request.body = json.encode({
              "payment_info": {
              "coupon_code": coupon_code,
              "coupon_amount":coupon_amount,
              "coupon_seller_id": coupon_seller_id,
              "payment_id": payment_id,
              "payer_id": payer_id,
              "payment_method": payment_method,
              "shipping_name": shipping_name
            },
            "product": productJson
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
          //_showToast(response.statusCode.toString());

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

class SelectedShippingNameWithSellerId{  //modal class
  String seller_id, shipping_name;

  SelectedShippingNameWithSellerId({
    required this.seller_id,
    required this.shipping_name,

  });
}