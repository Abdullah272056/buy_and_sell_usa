
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import '../../api_service/api_service.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../model/CategoriesData.dart';
import '../../static/Colors.dart';
import '../../view/auth/user/log_in_page.dart';
import '../../view/common/loading_dialog.dart';

class CustomDrawerController extends GetxController {
  var drawerSelectedTab = 1.obs;
  var categoriesList=[].obs;
  var userName="".obs;
  var userToken="".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserIdFromSharePref();
    retriveUserInfo();
    getCategories();

  }

  updateUserNameLevelTextColor(int value) {
    drawerSelectedTab(value);
  }

  ///categories api call
  void getCategories() async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          var response = await get(
              Uri.parse('${BASE_URL_API}${SUB_URL_API_GET_CATEGORIES}'),
          );
          // _showToast("status = ${response.statusCode}");
          if (response.statusCode == 200) {

            var data = response.body;
            CategoriesData categoriesDataAllListModel= categoriesDataFromJson(data);

            categoriesList(categoriesDataAllListModel.data);
           // _showToast(categoriesList.length.toString());
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

  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:awsMixedColor,
        textColor: fnf_color,
        fontSize: 16.0);
  }

  ///get data from share pref
  void loadUserIdFromSharePref() async {
    try {
      var storage =GetStorage();

      userName(storage.read(pref_user_name));
      userToken(storage.read(pref_user_token));
   //   _showToast("qwer "+userToken.toString());
    } catch (e) {

    }

  }

  ///get user data from share pref
  void retriveUserInfo() async {
    try {
      var storage =GetStorage();
      userName(storage.read(pref_user_name).toString());
      userToken(storage.read(pref_user_token).toString());
     // _showToast("Tokenqw = "+storage.read(pref_user_token).toString());
    }catch(e){

    }

  }


  void getUserAccountLogOut(String token) async{
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //_showToast(token);
        try {
          showLoadingDialog("Processing...");
          var response = await post(

            Uri.parse('${BASE_URL_API}${SUB_URL_API_LOG_OUT}'),
            headers: {
              'Authorization': 'Bearer '+token,
              'Content-Type': 'application/json',
            },
          );

          Get.back();

          _showToast(response.statusCode.toString());
          if (response.statusCode == 200) {

            saveUserInfoRemove(
                userName:"",
                userToken:"");
            Get.deleteAll();
            Get.offAll(LogInScreen());

          }
          else {
            // Fluttertoast.cancel();
            //  _showToast("failed try again!");
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



  ///user info with share pref
  void saveUserInfoRemove({required String userName,required String userToken,}) async {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, userName);
      storage.write(pref_user_token, userToken);
      // _showToast(userToken.toString());
    } catch (e) {
      //code
    }
  }

}