
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/drawer/privacy_policy.dart';
import 'package:fnf_buy/view/drawer/refund_policy.dart';
import 'package:fnf_buy/view/drawer/terms_of_use.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/auth_controller/user_auth/log_in_page_controller.dart';
import '../../controller/auth_controller/user_auth/sign_up_page_controller.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
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
import '../common/login_warning.dart';
import '../dash_board/tracking_webview_page.dart';
import '../dash_board/wish_list_page.dart';
import '../product/product_list.dart';
import 'about_us.dart';
import 'contact_us.dart';
import 'faq.dart';

class CustomDrawer extends StatelessWidget {
  final customDrawerController = Get.put(CustomDrawerController());

  final Uri _url = Uri.parse('https://fnfbuy.bizoytech.com/tracking-api');

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
                    height: 180,
                    decoration: BoxDecoration(color: sohojatri_color),
                    child: Column(
                      children: [
                        Expanded(child:Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 30,left: 20,),
                              child: Column(
                              //  mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Row(
                                    children:  [

                                      Image.asset(
                                        "assets/images/fnf_logo.png",
                                        // width: 25,
                                        fit: BoxFit.fill,
                                        height: 60,
                                      ),

                                    ],
                                  ),

                                  SizedBox(height: 5,),
                                  Row(
                                    children: const [

                                      Expanded(child: Text(
                                        'An USA based buy and sale online platform',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'PT-Sans',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color:Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 2,
                                      ),)

                                    ],
                                  ),
                                  Expanded(child: Container())
                                ],
                              )


                            )
                        ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                  onTap: (){
                                    customDrawerController.drawerSelectedTab(1);
                                  },
                                  child: Container(
                                      height: 40,
                                      child: Column(
                                        children: [
                                          Expanded(child: Center(
                                            child:Obx(()=> Text("MAIN MENU",
                                              style: TextStyle(
                                                fontSize: 15,

                                                color:customDrawerController.drawerSelectedTab.value==1?fnf_color: Colors.white,

                                              ),
                                            )),
                                          ),),
                                          Row(
                                            children: [
                                              Expanded(child:Obx(()=> Container(
                                                height: 3,
                                                color:customDrawerController.drawerSelectedTab.value==1?fnf_color: Colors.white,
                                              )))
                                            ],
                                          )
                                        ],
                                      )


                                  ),
                                )),

                            Expanded(
                                child:InkWell(
                                  onTap: (){
                                    customDrawerController.drawerSelectedTab(2);
                                  },
                                  child: Container(
                                      height: 40,
                                      child: Column(
                                        children: [
                                          Expanded(child: Center(
                                            child:Obx(()=> Text("CATEGORIES",
                                              style: TextStyle(
                                                fontSize: 15,

                                                color:customDrawerController.drawerSelectedTab.value==2?fnf_color: Colors.white,

                                              ),
                                            )),
                                          ),),
                                          Row(
                                            children: [
                                              Expanded(child:Obx(()=>
                                                  Container(
                                                    height: 3,
                                                    color:customDrawerController.drawerSelectedTab.value==2?fnf_color: Colors.white,
                                                  )
                                              )

                                              )
                                            ],
                                          )
                                        ],
                                      )


                                  ),
                                )
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  Obx(()=> Expanded(child:customDrawerController.drawerSelectedTab.value==1?
                  ListView(
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
                      ListTile(
                        leading: Icon(Icons.favorite,
                          color: sohojatri_color.withOpacity(.6),
                          size: 22,
                        ),
                        title: Text("Wish List",),
                        onTap: (){
                          if(GetStorage().read(pref_user_token)!=null&&
                              GetStorage().read(pref_user_token)!="null"&&
                              GetStorage().read(pref_user_token).toString().isNotEmpty){

                            Get.to(WishListPage())?.then((value) => Get.delete<WishListPageController>());
                          }else{
                            showLoginWarning();
                          }
                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.track_changes,
                          color: sohojatri_color.withOpacity(.6),
                          size: 22,
                        ),
                        title: Text("Tracking",),
                        onTap: (){

                          Get.to(TrackingWebViewScreen());

                          // _launchUrl();


                        },
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
                              title: Text("FAQ"),
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
                      ListTile(
                        leading: Icon(Icons.shopping_cart,
                          color: sohojatri_color.withOpacity(.6),
                          size: 22,
                        ),
                        title: Text("Cart",
                        ),
                        onTap: (){

                          Get.to(CartPage())?.then((value) => Get.delete<CartPageController>());
                        },
                      ),

                      // ListTile(
                      //   leading: Icon(Icons.shopping_cart_checkout_outlined,
                      //     color: sohojatri_color.withOpacity(.6),
                      //     size: 22,
                      //   ),
                      //   title: Text("Checkout",
                      //   ),
                      //   onTap: (){
                      //
                      //
                      //     if(customDrawerController.userToken.isNotEmpty &&
                      //         customDrawerController.userToken.value!=null && customDrawerController.userToken.value!="null"){
                      //
                      //       Get.to(() => CheckoutPage(), arguments: [
                      //         {"couponCodes": ""},
                      //         {"couponAmount": ""},
                      //         {"couponSellerId": ""},
                      //       ])?.then((value) => Get.delete<ProductDetailsController>());
                      //
                      //     }else{
                      //       showLoginWarning();
                      //     }
                      //   },
                      //   //   onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AllCarListScreen())),
                      // ),

                      ExpansionTile(
                        leading:Icon(Icons.account_box,
                          color: sohojatri_color.withOpacity(.6),
                          size: 22,

                        ) ,
                        title: Text("My Account"),
                        children: [

                          Container(
                            margin: EdgeInsets.only(left: 20),
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
                            margin: EdgeInsets.only(left: 20),
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
                            margin: EdgeInsets.only(left: 20),
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

                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child:   ListTile(
                              leading: Icon(Icons.app_registration,
                                color: sohojatri_color.withOpacity(.6),
                                size: 20,
                              ),
                              title: Text("Seller Registation"),
                              onTap: (){

                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorSignUpScreen()));
                              },
                            ),
                          ),


                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child:   ListTile(
                              leading: Icon(
                                Icons.privacy_tip_outlined,
                                size: 20,
                                color: sohojatri_color.withOpacity(.6),

                              ),
                              title: Text("Refund & Return"),
                              onTap: (){
                                Get.to(RefundPolicyPage())?.then((value) => Get.delete<RefundPolicyController>());
                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                              },
                            ),
                          ),




                        ],


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

                            customDrawerController.getUserAccountLogOut(GetStorage().read(pref_user_token));

                            // removeUserInfo();
                            // Get.deleteAll();
                            // Get.offAll(LogInScreen());

                          },

                        )

                      },
                      // Obx(() => customDrawerController.userToken!=null&&
                      //     customDrawerController.userToken!="null"&&
                      //     customDrawerController.userToken!=""?ListTile(
                      //   leading: Icon(Icons.logout_rounded,
                      //     color: sohojatri_color.withOpacity(.6),
                      //     size: 22,
                      //   ),
                      //   title: const Text("Logout",
                      //   ),
                      //   onTap: (){
                      //
                      //     removeUserInfo();
                      //     Get.deleteAll();
                      //     Get.offAll(LogInScreen());
                      //
                      //   },
                      //
                      // ):Container()),

                      // if(customDrawerController.userToken!=null&&
                      //     customDrawerController.userToken!="null"&&
                      //     customDrawerController.userToken!="")...{
                      //
                      //
                      //
                      // },
                      SizedBox(height: 15,)
                    ],
                  ):
                      ///categories
                  ListView.builder(
                      itemCount:customDrawerController.categoriesList.length,
                      padding: EdgeInsets.only(top: 10),
                      scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return categoriesItemDesign(index);

                      }),

                  ))

                ],
              )


          ),),

        ],
      )
    );
  }

  //join now url page redirect
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Widget categoriesItemDesign(int index){
    return Container(

      child:ExpansionTile(
        leading:Icon(Icons.category_outlined,
          color: sohojatri_color.withOpacity(.6),
          size: 22,
        ) ,
        title: Text(
            customDrawerController.categoriesList[index].categoryName.toString()

        ),
        children: [

          ListView.builder(
            padding: EdgeInsets.only(top: 0),
              itemCount:customDrawerController.categoriesList[index].subCategories.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index2) {
                return Container(
                  margin: EdgeInsets.only(left:75),
                  child: ListTile(
                    // leading: Icon(Icons.info_outline,
                    //   color: sohojatri_color.withOpacity(.6),
                    //   size: 20,
                    // ),
                    title: Text("\t"+
                        customDrawerController.categoriesList[index].subCategories[index2].subcategoryName.toString(),
                      style: TextStyle(
                          fontSize: 13
                      ),

                    ),
                    onTap: (){
                      Get.to(() => ProductListPage(), arguments: [
                        {"categoriesId": customDrawerController.categoriesList[index].id.toString()},
                        {"subCategoriesId": customDrawerController.categoriesList[index].subCategories[index2].id.toString()},
                        {"searchValue": ""},
                      ]);
                      // _showToast(customDrawerController.categoriesList[index].id.toString());
                      // _showToast(customDrawerController.categoriesList[index].subCategories[index2].id.toString());
                    },
                  ),
                );

              }),

        ],


      ),
    );
  }

  void removeUserInfo() async  {
    try {
      var storage =GetStorage();
      storage.write(pref_user_name, "");
      storage.write(pref_user_token, "");

    } catch (e) {
      //code
    }


  }

}
