
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../data_base/notes_database.dart';
import '../static/Colors.dart';
import '../view/dash_board/checkout step/checkout_page_step2.dart';

class CheckoutPageController extends GetxController {

  ///controller
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailAddressController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final townOrCityController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final countryController = TextEditingController().obs;
  final zipCodeController = TextEditingController().obs;

  ///Focus Node
  final firstNameControllerFocusNode = FocusNode().obs;
  final lastNameControllerFocusNode = FocusNode().obs;
  final emailAddressControllerFocusNode = FocusNode().obs;
  final phoneControllerFocusNode = FocusNode().obs;
  final addressControllerFocusNode = FocusNode().obs;
  final townOrCityControllerFocusNode = FocusNode().obs;
  final stateControllerFocusNode = FocusNode().obs;
  final countryControllerFocusNode = FocusNode().obs;
  final zipCodeControllerFocusNode = FocusNode().obs;
  var inputLevelTextColor = hint_color.obs;


  var stateList = [].obs;
  var countryList = [].obs;
  var selectStateId="".obs;
  var selectCountryId="".obs;


  var totalPrice=0.0.obs;
  var totalTaxAmount=0.0.obs;
  var cartList=[].obs;

  var userName="".obs;
  var userToken="".obs;
 // var userToken="18|55gHatBObrLJz3zR2XQ3ppLOGA7I6f4BAsfbr6m4".obs;

  var firstName="".obs;
  var lastName="".obs;
  var emailAddress="".obs;
  var phoneNumber="".obs;
  var address="".obs;
  var townCity="".obs;
  var zipCode="".obs;

  var selectedState="".obs;
  var selectedCountry="".obs;

  // dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    // abcd(argumentData[0]['first']);
    // print(argumentData[0]['first']);
    // print(argumentData[1]['second']);
    loadUserIdFromSharePref();
    refreshNotes();

    ///getStateList();
    getUserBillingInfoList(userToken.value);
    getCountryList(userToken.value);
    super.onInit();

  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));

       _showToast("anbv=  "+storage.read(pref_user_token).toString());

    } catch (e) {

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

  Future refreshNotes() async {
    NotesDataBase.instance;
    cartList(await NotesDataBase.instance.readAllNotes());

    totalPriceCalculate(cartList);
    totalTaxCalculation(cartList);
    // _showToast("Local length= "+cartList.length.toString());
  }

  Future deleteNotes(int id) async {
    NotesDataBase.instance;
    NotesDataBase.instance.delete(id)  ;
    refreshNotes();

  }

  void totalPriceCalculate(List cartList){
    double subTotal=0.0;
    for(int i=0;i<cartList.length;i++){
      double oneItemPrice=double.parse(cartList[i].productQuantity)*double.parse(cartList[i].productDiscountedPrice);
      subTotal=(subTotal+oneItemPrice);
    }
    totalPrice(subTotal);

  }

  totalTaxCalculation(List cartList){
    double totalTax=0.0;
    for(int i=0;i<cartList.length;i++){
      double oneItemPrice=double.parse(cartList[i].productQuantity)*double.parse(cartList[i].productDiscountedPrice);

      double singleProductTax=(double.parse(cartList[i].tax)*oneItemPrice)/100;
      totalTax=(totalTax+singleProductTax);
    }

    totalTaxAmount(totalTax);
    //  totalPrice(subTotal);

  }

  void getCountryList(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ALL_COUNTRY_LIST}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
          );
           _showToast("country = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);

            Country country=new Country(dataResponse["data"]["name"].toString(),dataResponse["data"]["id"].toString());
            List<Country> c_list=[country];
            countryList(c_list);


            // countryList([dataResponse["data"]["name"].toString()]);
            selectedCountry(dataResponse["data"]["name"].toString());
            selectCountryId(dataResponse["data"]["id"].toString());
            stateList(dataResponse["data"]["states"]);

            _showToast("leng= "+stateList.length.toString());

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

  void getStateList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ALL_STATE_LIST}'),
          );
           _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            stateList(dataResponse["data"]);
          //  _showToast("Colors= "+stateList.length.toString());
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

  void getUserBillingInfoList(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //  _showToast(token);
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_USER_BILLING_ADDRESS}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
          );

          _showToast("billing= "+response.statusCode.toString());
          if (response.statusCode == 200) {
            // var wishListResponse = jsonDecode(response.body);
            // wishList(wishListResponse["data"]["data"]);

            // _showToast("size  "+wishList.length.toString());
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

  void updateUserBillingInfoList({
            required String token,
            required String firstname,
            required String lastName,
            required String emailAddress,
            required String phoneNumber,
            required String address,
            required String townCity,
            required String zipCode,
            required String stateId,
            required String countryId
          }
      ) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       // _showToast(token);
        try {
          showLoadingDialog("Checking");
          var response = await post(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_ADD_USER_UPDATE_BILLING_ADDRESS}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
            body: {
              'first_name': firstname,
              'last_name': lastName,
              'email': emailAddress,
              'phone': phoneNumber,
              'address': address,
              'city': townCity,
              'country': countryId,
              'state': stateId,
              'zip': zipCode
            }
          );

          Get.back();
          _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {


           Get.to(() => CheckoutPageStep2Page(), arguments: [
             {"productId": ""},
             {"zipCode": zipCode},
             {"surName": firstname},
             {"mobileNumber": phoneNumber},
             {"totalAmountWithTax": (totalTaxAmount.value+totalPrice.value).toString()},
             {"emailAddress": emailAddress},

           ]);

            // var wishListResponse = jsonDecode(response.body);
            // wishList(wishListResponse["data"]["data"]);

            // _showToast("size  "+wishList.length.toString());
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

class Country{
  String c_name;
  String c_id;
  Country(this.c_name, this.c_id);
}
