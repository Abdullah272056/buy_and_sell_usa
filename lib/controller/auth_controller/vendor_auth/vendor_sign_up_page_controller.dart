
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/controller/auth_controller/vendor_auth/vendor_email_verification_page_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../../../api_service/api_service.dart';
import '../../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../../static/Colors.dart';
import 'package:http/http.dart' as http;

import '../../../view/auth/vendor_or_seller/vendor_email_verification.dart';
import '../../../view/common/loading_dialog.dart';
import '../../../view/common/toast.dart';
import '../../../view/dash_board/dash_board_page.dart';
import '../../checkout_step_controller/checkout_page_controller.dart';
import '../../dash_board_controller/dash_board_page_controller.dart';
import '../../product_controller/product_details_controller.dart';
import '../../profile_section_controllert/account_details_page_controller.dart';

class  VendorSignUpPageController extends GetxController {

  ///input box controller
  final userEmailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final fullNameController = TextEditingController().obs;
  final companyNameController = TextEditingController().obs;
  final storeCompanyWebsiteController = TextEditingController().obs;
  final phoneNoController = TextEditingController().obs;
  final mobileNoController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final zipCodeController = TextEditingController().obs;


  final  userEmailControllerFocusNode = FocusNode().obs;
  final  passwordControllerFocusNode = FocusNode().obs;
  final  confirmPasswordControllerFocusNode = FocusNode().obs;

  final fullNameControllerFocusNode = FocusNode().obs;
  final companyNameControllerFocusNode = FocusNode().obs;
  final storeCompanyWebsiteControllerFocusNode = FocusNode().obs;
  final phoneNoControllerFocusNode = FocusNode().obs;
  final mobileNoControllerFocusNode = FocusNode().obs;
  final addressControllerFocusNode = FocusNode().obs;
  final cityControllerFocusNode = FocusNode().obs;
  final zipCodeControllerFocusNode = FocusNode().obs;

  ///input box color and operation
  var userEmailLevelTextColor = hint_color.obs;
  var passwordLevelTextColor = hint_color.obs;
  var emailFocusNode = FocusNode().obs;
  var isObscurePassword = true.obs;
  var isObscureConfirmPassword = true.obs;

  var stateList = [].obs;
  var countryList = [].obs;
  var selectStateId="".obs;
  var selectCountryId="".obs;
  var selectedState="".obs;
  var selectedCountry="".obs;


  @override
  void onInit() {
    super.onInit();

    getCountryList();

  }


  updateUserNameLevelTextColor(Color value) {
    userEmailLevelTextColor(value);
  }

  updateIsObscureConfirmPassword(var value) {
    isObscureConfirmPassword(value);
  }

  updateIsObscurePassword(var value) {
    isObscurePassword(value);
  }

  updatePasswordLevelTextColor(Color value) {
    passwordLevelTextColor(value);
  }


  //input text validation check
  inputValidation({
    required String fullNameTxt,
    required String userEmail,
    required String password,
    required String confirmPassword,
    required String companyNameTxt,
    required String storeCompanyWebsiteTxt,
    required String phoneNoTxt,
    required String mobileNoTxt,
    required String addressTxt,
    required String cityTxt,
    required String zipCodeTxt,
    required String selectedState,
    required String selectedCountry,
  }) {

    if (fullNameTxt.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Name can't empty!");
      return;
    }
    if (userEmail.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Email can't empty!");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    ).hasMatch(userEmail)) {
      Fluttertoast.cancel();
      showToastShort("Enter valid email!");
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Password can't empty!");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      showToastShort("Password must be 8 character!");
      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.cancel();
      showToastShort("Confirm Password does not match!");
      return;
    }

    if (companyNameTxt.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Company Name can't empty!");
      return;
    }

    if (phoneNoTxt.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Phone  can't empty!");
      return;
    }

    if (cityTxt.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("City can't empty!");
      return;
    }
    if (mobileNoTxt.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Mobile can't empty!");
      return;
    }

    if (zipCodeTxt.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Zip Code  can't empty!");
      return;
    }
    if (addressTxt.isEmpty) {
      Fluttertoast.cancel();
      showToastShort("Address  can't empty!");
      return;
    }


    if (selectedState.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Please select State!");
      return;
    }
    if (selectedCountry.isEmpty) {
      Fluttertoast.cancel();
      showToastLong("Please select Country!");
      return;
    }

    return false;
  }

  userSignUp({
    required String fullNameTxt,
    required String userEmail,
    required String password,
    required String confirmPassword,
    required String companyNameTxt,
    required String storeCompanyWebsiteTxt,
    required String phoneNoTxt,
    required String mobileNoTxt,
    required String addressTxt,
    required String cityTxt,
    required String zipCodeTxt,
    required String selectedState,
    required String selectedCountry,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        try {
          showLoadingDialog("Checking");
          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_SIGN_UP_VENDOR'),
              // var response = await http.post(Uri.parse('http://192.168.68.106/bijoytech_ecomerce/api/login'),
              body: {
                'owner_name': fullNameTxt,
                'store_name': companyNameTxt,
                'store_social_link': storeCompanyWebsiteTxt,
                'phone': phoneNoTxt,
                'mobile': mobileNoTxt,
                'address': addressTxt,
                'city': cityTxt,
                'state': selectedState,
                'zip': zipCodeTxt,
                'country': selectedCountry,
                'email': userEmail,
                'password': password,
                'password_confirmation': confirmPassword,

              }
          );
          Get.back();
           showToastShort(response.statusCode.toString());
          if (response.statusCode == 200) {

            // _showToast("success");
            // var data = jsonDecode(response.body);

            Get.to(VendorEmailVerificationScreen(),
                arguments: [
                  {"productId": ""},
                  {"userEmail": userEmail.toString()}
                ]
            )?.then((value) => Get.delete<VendorEmailVerifyPageController>());

          }

          else if (response.statusCode == 404) {
            var data = jsonDecode(response.body);
            if(data["message"]["name"]!=null){
              showToastShort(data["message"]["name"][0].toString());
              return;
            }

            if(data["message"]["email"]!=null){
              showToastShort(data["message"]["email"][0].toString());
              return;
            }

            if(data["message"]["password"]!=null){
              showToastShort(data["message"]["password"][0].toString());
              return;
            }

          }

          else {
            var data = jsonDecode(response.body);
            //_showToast(data['message']);
          }


        } catch (e) {
          //  Navigator.of(context).pop();
          //print(e.toString());
        } finally {

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

  void getCountryList( ) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ALL_COUNTRY_LIST}'),
            headers: {
              //'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
          );
          // showToastShort("country = ${response.statusCode}");
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