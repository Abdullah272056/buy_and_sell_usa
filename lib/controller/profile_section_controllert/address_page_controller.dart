
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';



import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../static/Colors.dart';
import '../../view/common/loading_dialog.dart';
import '../../view/common/toast.dart';
import 'address_page_controller.dart';

class AddressPageController extends GetxController {

  ///controller
  final firstNameController = TextEditingController().obs;
  final middleNameController = TextEditingController().obs;
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
  final middleNameControllerFocusNode = FocusNode().obs;
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

  @override
  void onInit() {

    loadUserIdFromSharePref();

    ///getStateList();
    getUserBillingInfoList(userToken.value);

    super.onInit();

  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));

       //_showToast("anbv=  "+storage.read(pref_user_token).toString());

    } catch (e) {

    }

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
         //  _showToast("country = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);

            Country country=new Country(dataResponse["data"]["name"].toString(),dataResponse["data"]["id"].toString());
            List<Country> c_list=[country];
            countryList(c_list);

            // countryList([dataResponse["data"]["name"].toString()]);
            selectedCountry(dataResponse["data"]["name"].toString());
            selectCountryId(dataResponse["data"]["id"].toString());


           var stateListResponse=dataResponse["data"]["states"];
            // stateList(dataResponse["data"]["states"]);
          //  _showToast("leng= "+stateListResponse.length.toString());
            List<StateData> tempStateList=[];

            for(int i=0;i<stateListResponse.length;i++){
             // _showToast("mill");


              StateData stateData= StateData(
                  stateId: stateListResponse[i]["id"].toString(),
                  country_id:stateListResponse[i]["country_id"].toString(),
                  stateName: stateListResponse[i]["name"].toString()
              );


              if(stateListResponse[i]["id"].toString()==selectStateId.value){
                selectedState(stateListResponse[i]["name"].toString());
              }



              tempStateList.add(stateData);



            }
            stateList(tempStateList);


         // _showToast("leng1= "+stateList.length.toString());

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



  void getUserBillingInfoList(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //  _showToast(token);
        try {
          showLoadingDialog("Loading...");
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_USER_BILLING_ADDRESS}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
          );

          Get.back();

         //_showToast("billing= "+response.statusCode.toString());
          if (response.statusCode == 200) {


            var addressResponseData = jsonDecode(response.body);
            // wishList(wishListResponse["data"]["data"]);
            // _showToast("size  "+wishList.length.toString());


             firstNameController.value.text =addressResponseData["data"]["first_name"] ;
             lastNameController.value.text = addressResponseData["data"]["last_name"] ;
             emailAddressController.value.text =addressResponseData["data"]["email"]  ;
             phoneController.value.text = addressResponseData["data"]["phone"] ;
             addressController.value.text =addressResponseData["data"]["address"]  ;
             townOrCityController.value.text =addressResponseData["data"]["city"]  ;
             // selectedState(addressResponseData["data"]["city"].toString());

            if(selectStateId(addressResponseData["data"]["state"].toString())!="null"){
              selectStateId(addressResponseData["data"]["state"].toString());
            }

            // _showToast(selectedState.value);
             stateController.value.text = addressResponseData["data"]["first_name"] ;
             countryController.value.text = addressResponseData["data"]["first_name"] ;
             zipCodeController.value.text = addressResponseData["data"]["zip"] ;

            getCountryList(userToken.value);


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

  void updateUserBillingInfoList({
            required String token,
            required String firstname,
            required String middleName,
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
          showLoadingDialog("Saving...");
          var response = await post(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_ADD_USER_UPDATE_BILLING_ADDRESS}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
            body: {
              'first_name': firstname,
              'middle_name': middleName,
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
        //  _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            showToastShort("Address info update successfully!");
            getUserBillingInfoList(userToken.value);

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


  void getStateList() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ALL_STATE_LIST}'),
          );
         // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var dataResponse = jsonDecode(response.body);
            stateList(dataResponse["data"]);
            //  _showToast("Colors= "+stateList.length.toString());
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

}



class Country{
  String c_name;
  String c_id;
  Country(this.c_name, this.c_id);
}

class StateData{
  String stateId;
  String country_id;
  String stateName;
  StateData(
  { required this.stateId,
    required this.country_id,
    required this.stateName,}
      );
}
