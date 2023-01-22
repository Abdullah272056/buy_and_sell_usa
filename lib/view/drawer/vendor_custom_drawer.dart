
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/drawer/privacy_policy.dart';
import 'package:fnf_buy/view/drawer/refund_policy.dart';
import 'package:fnf_buy/view/drawer/terms_of_use.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/auth_controller/user_auth/log_in_page_controller.dart';
import '../../controller/auth_controller/user_auth/sign_up_page_controller.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/drawer_controller/about_us_controller.dart';
import '../../controller/drawer_controller/contact_us_controller.dart';
import '../../controller/drawer_controller/faq_controller.dart';
import '../../controller/drawer_controller/privacy_policy_controller.dart';
import '../../controller/drawer_controller/refund_policy_controller.dart';
import '../../controller/drawer_controller/terms_of_use_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../controller/drawer_controller/custom_drawer_controller.dart';
import '../../static/Colors.dart';
import '../auth/user/log_in_page.dart';
import '../auth/user/sign_up_page.dart';
import '../auth/vendor_or_seller/vendor_log_in_page.dart';
import '../auth/vendor_or_seller/vendor_sign_up_page.dart';
import '../cart/cart_page.dart';
import '../checkout step/checkout_page.dart';
import '../product/product_list.dart';
import 'about_us.dart';
import 'contact_us.dart';
import 'faq.dart';


class VendorCustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Column(
        children: [
          Expanded(child:  SizedBox(
             // height: MediaQuery.of(context).size.height-kBottomNavigationBarHeight,
              child:Column(
                children: [
                  Container(
                    height: 150,

                    child: Column(
                      children: [
                        Expanded(child:Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 20,left: 20),
                              child: Image.asset(
                                "assets/images/fnf_logo.png",
                                // width: 25,
                                fit: BoxFit.fill,
                                height: 50,
                              ),
                            )
                        ),
                        ),

                      ],
                    ),
                    decoration: BoxDecoration(color: sohojatri_color),
                  ),
                     Expanded(child:ListView(
                padding: EdgeInsets.only(top: 10),
                children:  [
                  ListTile(
                    leading: Icon(Icons.dashboard,
                      color: sohojatri_color.withOpacity(.6),
                      size: 22,
                    ),
                    title: Text("Home"),
                    onTap: (){

                      Navigator.pop(context);
                    },
                    // onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen())),
                  ),

                  ExpansionTile(
                    leading:Icon(Icons.pages,
                      color: sohojatri_color.withOpacity(.6),
                      size: 22,
                    ) ,
                    title: Text("Pages"),
                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: ListTile(
                          leading: Icon(Icons.info_outline,
                            color: sohojatri_color.withOpacity(.6),
                            size: 20,
                          ),
                          title: Text("About Us"),
                          onTap: (){

                            Get.to(AboutUsPage())?.then((value) => Get.delete<AboutUsController>());
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>OfferRide()));
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: ListTile(
                          leading: Icon(Icons.contact_page,
                            color: sohojatri_color.withOpacity(.6),
                            size: 20,
                          ),
                          title: Text("Contact Us"),
                          onTap: (){

                            Get.to(ContactUsPage())?.then((value) => Get.delete<ContactUsController>());
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child:  ListTile(
                          leading: Icon(Icons.privacy_tip_outlined,
                            color: sohojatri_color.withOpacity(.6),
                            size: 20,
                          ),
                          title: Text("Faq"),
                          onTap: (){
                            Get.to(FaqPage())?.then((value) => Get.delete<FaqController>());
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>OfferRide()));
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: ListTile(
                          leading: Icon(Icons.privacy_tip_outlined,
                            color: sohojatri_color.withOpacity(.6),
                            size: 20,
                          ),
                          title: Text("Privacy Policy"),
                          onTap: (){
                            Get.to(PrivacyPolicyPage())?.then((value) => Get.delete<PrivacyPolicyController>());
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child:   ListTile(
                          leading: Icon(Icons.privacy_tip_outlined,
                            color: sohojatri_color.withOpacity(.6),
                            size: 20,
                          ),
                          title: Text("Terms of Use"),
                          onTap: (){
                            Get.to(TermsOfUsePage())?.then((value) => Get.delete<TermsOfUseController>());
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                          },
                        ),
                      ),


                    ],


                  ),


                  Container(
                    margin: EdgeInsets.only(left: 00),
                    child: ListTile(
                      leading: Icon(Icons.login,
                        color: sohojatri_color.withOpacity(.6),
                        size: 20,
                      ),
                      title: Text("Customer Login"),
                      onTap: (){
                        Get.to(LogInScreen())?.then((value) => Get.delete<LogInPageController>());
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 00),
                    child:  ListTile(
                      leading: Icon(Icons.app_registration,
                        color: sohojatri_color.withOpacity(.6),
                        size: 20,
                      ),
                      title: Text("Customer Registration"),
                      onTap: (){
                        Get.to(SignUpScreen())?.then((value) => Get.delete<SignUpPageController>());
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>OfferRide()));
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 00),
                    child: ListTile(
                      leading: Icon(Icons.login,
                        color: sohojatri_color.withOpacity(.6),
                        size: 20,
                      ),
                      title: Text("Seller Login"),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorLogInScreen()));
                      },
                    ),
                  ),


                  if(GetStorage().read(pref_user_token)!=null&&
                      GetStorage().read(pref_user_token)!="null"&&
                      GetStorage().read(pref_user_token).toString().isNotEmpty)...{

                    ListTile(
                      leading: Icon(Icons.logout_rounded,
                        color: sohojatri_color.withOpacity(.6),
                        size: 22,
                      ),
                      title: const Text("Logout",
                      ),
                      onTap: (){

                        removeUserInfo();
                        Get.deleteAll();
                        Get.offAll(LogInScreen());

                      },

                    )

                  },
                  SizedBox(height: 15,)
                ],
              ))

                ],
              )


          ),)

        ],
      )
    );
  }

  void removeUserInfo() async {
    try {

      var storage =GetStorage();
      storage.write(pref_user_name, "");
      storage.write(pref_user_token, "");
      storage.write(pref_user_type, "");

    } catch (e) {
      //code
    }


  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: fnf_color,
        fontSize: 15.0);
  }
}
