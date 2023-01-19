
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../../../api_service/api_service.dart';
import '../../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../../static/Colors.dart';
import 'package:http/http.dart' as http;

import '../../../view/dash_board/dash_board_page.dart';
import '../../checkout_step_controller/checkout_page_controller.dart';
import '../../dash_board_controller/dash_board_page_controller.dart';
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
  _inputValid({required String userName,required String userEmail,
    required String password, required String confirmPassword}) {
    if (userName.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Name can't empty!");
      return;
    }
    if (userEmail.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Email can't empty!");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(userEmail)) {
      Fluttertoast.cancel();
      _showToast("Enter valid email!");
      return;
    }

    if (password.isEmpty) {
      Fluttertoast.cancel();
      _showToast("Password can't empty!");
      return;
    }
    if (password.length < 8) {
      Fluttertoast.cancel();
      _showToast("Password must be 8 character!");
      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.cancel();
      _showToast("Confirm Password does not match!");
      return;
    }

    return false;
  }


  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:toast_bg_color,
        textColor: toast_text_color,
        fontSize: 16.0);
  }


  //loading dialog crete
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


  userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

          showLoadingDialog("Checking");

          var response = await http.post(Uri.parse('$BASE_URL_API$SUB_URL_API_SIGN_UP'),
              // var response = await http.post(Uri.parse('http://192.168.68.106/bijoytech_ecomerce/api/login'),
              body: {
                'name': name,
                'email': email,
                'password': password
              }
          );
          Get.back();
          // _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            // _showToast("success");
            var data = jsonDecode(response.body);
            saveUserInfo(
                userName: data["data"]["name"].toString(),
                userToken: data["data"]["token"].toString());

            Get.deleteAll();
            Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());

          }
          else if (response.statusCode == 404) {
            var data = jsonDecode(response.body);
            if(data["message"]["name"]!=null){
              _showToast(data["message"]["name"][0].toString());
              return;
            }

            if(data["message"]["email"]!=null){
              _showToast(data["message"]["email"][0].toString());
              return;
            }

            if(data["message"]["password"]!=null){
              _showToast(data["message"]["password"][0].toString());
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
      _showToast("No Internet Connection!");
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