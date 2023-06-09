
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import 'package:http/http.dart' as http;

import '../../view/common/loading_dialog.dart';
import '../../view/common/toast.dart';

class AccountDetailsPageController extends GetxController {

  ///controller
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailAddressController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final mobileController = TextEditingController().obs;
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
  final mobileControllerFocusNode = FocusNode().obs;
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

  var firstName="".obs;
  var lastName="".obs;
  var emailAddress="".obs;
  var phoneNumber="".obs;
  var address="".obs;
  var townCity="".obs;
  var zipCode="".obs;

  var selectedState="".obs;
  var selectedCountry="".obs;

  var imageLink="".obs;

  PickedFile? _fornt_imageFile;
  final ImagePicker _fornt_picker=ImagePicker();
  String _imageLink = "";
  File? fornt_imageFile;


  @override
  void onInit() {

    loadUserIdFromSharePref();

    ///getStateList();
    getUserAccountDetails(userToken.value);

    super.onInit();

  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();
      //userName(storage.read(pref_user_name));
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

  void getUserAccountDetails(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       //_showToast(token);
        try {
          showLoadingDialog("Loading...");
          var response = await get(

            Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_ACCOUNT_DETAILS}'),
            headers: {
              'Authorization': 'Bearer '+token,
              // 'Authorization': 'Bearer '+'38|8NS9lFUKzmHJux4R0JRO8hTuMP0Phwrequ5myJ6u',
              //'Content-Type': 'application/json',
            },
          );

        // _showToast("account info= "+response.statusCode.toString());
          Get.back();
          if (response.statusCode == 200) {

            var addressResponseData = jsonDecode(response.body);

            // wishList(wishListResponse["data"]["data"]);
            // _showToast("size  "+wishList.length.toString());
            userName(addressResponseData["data"]["name"].toString());
             firstNameController.value.text =addressResponseData["data"]["name"];
             lastNameController.value.text = addressResponseData["data"]["name"];
             emailAddressController.value.text =addressResponseData["data"]["email"];
             phoneController.value.text = addressResponseData["data"]["phone"];
             addressController.value.text =addressResponseData["data"]["address"];
             townOrCityController.value.text =addressResponseData["data"]["city"];


            //  // selectedState(addressResponseData["data"]["city"].toString());
            //

            if(selectStateId(addressResponseData["data"]["state_id"].toString())!="null"){
              selectStateId(addressResponseData["data"]["state_id"].toString());
            }


            // _showToast(selectedState.value);
            //  stateController.value.text = addressResponseData["data"]["first_name"].toString() ;
            //  countryController.value.text = addressResponseData["data"]["first_name"].toString() ;
             zipCodeController.value.text = addressResponseData["data"]["zip_code"];

            imageLink(addressResponseData["data"]["image"].toString());

         //   _showToast(addressResponseData["data"]["image"].toString());





            getCountryList(token);


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

  void updateUserAccountDetails({
            required String token,
            required String firstname,
            required String mobile,
            required String emailAddress,
            required String phoneNumber,
            required String address,
            required String townCity,
            required String zipCode,
            required String stateId,
            required String countryId
          }) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       // _showToast(token);
        try {
          showLoadingDialog("Saving...");
          var response = await post(
            Uri.parse('${BASE_URL_API}${SUB_URL_API_ADD_USER_UPDATE_ACCOUNT_DETAILS}'),
            headers: {
              'Authorization': 'Bearer '+token,
              //'Content-Type': 'application/json',
            },
            body: {
              'image': "",
              'name': firstname,
              'phone': phoneNumber,
              'mobile': mobile,
              'email': emailAddress,
              'address': address,
              'city': townCity,
              'country_id': countryId,
              'state_id': stateId,
              'zip_code': zipCode,
            }
          );

          Get.back();
         // _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            showToastShort("Account info update success!");
            getUserAccountDetails(userToken.value);

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

  void openBottomSheet() {
    Get.bottomSheet(
        Container(
          height: 100,
          width: Get.size.width,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              Text("Choose",
                  style: const TextStyle(
                    fontFamily: 'PT-Sans',
                    fontSize: 18,
                    // color: Colors.black,
                  )
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: TextButton.icon(     // <-- TextButton
                    onPressed: () {
                    //  Navigator.of(context).pop();
                      Get.back();
                      takeImage(ImageSource.camera);
                    },
                    icon: Icon(
                      Icons.camera,
                      size: 30.0,
                    ),
                    label: Text('Camera',
                        style: const TextStyle(
                          fontFamily: 'PT-Sans',
                          fontSize: 18,
                          // color: Colors.black,
                        )
                    ),
                  ),),
                  Expanded(child: TextButton.icon(     // <-- TextButton
                    onPressed: () {
                     // Navigator.of(context).pop();
                      Get.back();
                     takeImage(ImageSource.gallery);
                    },
                    icon: Icon(
                      Icons.image,
                      size: 30.0,
                    ),
                    label: Text('Gallery',style: const TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 18,
                      // color: Colors.black,
                    ),),
                  ),)




                ],
              )
            ],
          ),

        ),


        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        isScrollControlled: true


      //  resizeToAvoidBottomInset: false
      // isScrollControlled: true,
    );
  }

  // Widget _buildImageUploadBottomSheet() {
  //   return Container(
  //     height: 100,
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
  //     child: Column(
  //       children: [
  //         Text("Choose",
  //             style: const TextStyle(
  //               fontFamily: 'PT-Sans',
  //               fontSize: 18,
  //               // color: Colors.black,
  //             )
  //         ),
  //         SizedBox(height: 20,),
  //
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Expanded(child: TextButton.icon(     // <-- TextButton
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 takeImage(ImageSource.camera);
  //               },
  //               icon: Icon(
  //                 Icons.camera,
  //                 size: 30.0,
  //               ),
  //               label: Text('Camera',
  //                   style: const TextStyle(
  //                     fontFamily: 'PT-Sans',
  //                     fontSize: 18,
  //                     // color: Colors.black,
  //                   )
  //               ),
  //             ),),
  //             Expanded(child: TextButton.icon(     // <-- TextButton
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 takeImage(ImageSource.gallery);
  //               },
  //               icon: Icon(
  //                 Icons.image,
  //                 size: 30.0,
  //               ),
  //               label: Text('Gallery',style: const TextStyle(
  //                 fontFamily: 'PT-Sans',
  //                 fontSize: 18,
  //                 // color: Colors.black,
  //               ),),
  //             ),)
  //
  //
  //
  //
  //           ],
  //         )
  //       ],
  //     ),
  //
  //   );
  // }
  void takeImage(ImageSource source)async{
    final pickedFile= await _fornt_picker.getImage(source: source);
    _fornt_imageFile=pickedFile!;
    fornt_imageFile = File(pickedFile.path);
    final bytes = File(_fornt_imageFile!.path).readAsBytesSync();

    String img64 = base64Encode(bytes);

    _uploadImage(
        fontImage: fornt_imageFile!,
      token: userToken.value,
    );

  }


  ///upload image
  _uploadImage({
    required File fontImage,
    required String token,
  }) async {

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        try {
          showLoadingDialog("Saving...");
          var headers = {
            'Authorization': 'Bearer '+token,
            // 'Authorization': 'Bearer 16|GcZjU2qXDUN2IIS6HDiDJvOPut6hOPT35HgN2qql',
          };
        //  _showToast(fontImage.path.toString());
          var request = http.MultipartRequest('POST', Uri.parse('${BASE_URL_API}${SUB_URL_API_UPLOAD_PROFILE_IMAGE}'));
          request.files.add(await http.MultipartFile.fromPath('image', fontImage.path));
          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();

           final res = await http.Response.fromStream(response);

           Get.back();
        //  _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {

            var data = jsonDecode(res.body);
            showToastShort("Image Saved Successfully!");
            getUserAccountDetails(token);

          }
          if (response.statusCode == 404) {
            var data = jsonDecode(res.body);
            showToastShort(data["message"]["image"]["0"]);
           // getUserBillingInfoList(token);
          }
          else {
            print(response.reasonPhrase);
          }
        } catch (e) {
       //   Navigator.of(context).pop();
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      showToastShort("No Internet Connection!");
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
