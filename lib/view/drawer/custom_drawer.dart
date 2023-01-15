
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/view/drawer/privacy_policy.dart';
import 'package:fnf_buy/view/drawer/refund_policy.dart';
import 'package:fnf_buy/view/drawer/terms_of_use.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../controller/drawer_controller/custom_drawer_controller.dart';
import '../../static/Colors.dart';
import '../auth/log_in_page.dart';
import '../auth/sign_up_page.dart';
import '../cart/cart_page.dart';
import '../checkout step/checkout_page.dart';
import '../product/product_list.dart';
import 'about_us.dart';
import 'faq.dart';


class CustomDrawer extends StatelessWidget {
  final customDrawerController = Get.put(CustomDrawerController());
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
                    decoration: BoxDecoration(color: sohojatri_color),
                  ),
                  Obx(()=> Expanded(child:customDrawerController.drawerSelectedTab.value==1? ListView(
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
                        leading: Icon(Icons.hail,
                          color: sohojatri_color.withOpacity(.6),
                          size: 22,
                        ),
                        title: Text("Shop",
                        ),
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

                                Get.to(AboutUsPage());
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
                                Get.to(FaqPage());
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
                                Get.to(PrivacyPolicyPage());
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
                                Get.to(TermsOfUsePage());
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
                      ListTile(
                        leading: Icon(Icons.shopping_cart_checkout_outlined,
                          color: sohojatri_color.withOpacity(.6),
                          size: 22,
                        ),
                        title: Text("Checkout",
                        ),
                        onTap: (){


                          if(customDrawerController.userToken.isNotEmpty &&
                              customDrawerController.userToken.value!=null && customDrawerController.userToken.value!="null"){

                            Get.to(() => CheckoutPage(), arguments: [
                              {"couponCodes": ""},
                              {"couponAmount": ""},
                              {"couponSellerId": ""},
                            ])?.then((value) => Get.delete<ProductDetailsController>());

                          }else{
                            showLoginWarning();
                          }
                        },
                        //   onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AllCarListScreen())),
                      ),

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
                                Get.to(LogInScreen());
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
                                Get.to(SignUpScreen());
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>OfferRide()));
                              },
                            ),
                          ),

                          // Container(
                          //   margin: EdgeInsets.only(left: 20),
                          //   child: ListTile(
                          //     leading: Icon(Icons.login,
                          //       color: sohojatri_color.withOpacity(.6),
                          //       size: 20,
                          //     ),
                          //     title: Text("Seller Login"),
                          //     onTap: (){
                          //       //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                          //     },
                          //   ),
                          // ),
                          //
                          // Container(
                          //   margin: EdgeInsets.only(left: 20),
                          //   child:   ListTile(
                          //     leading: Icon(Icons.app_registration,
                          //       color: sohojatri_color.withOpacity(.6),
                          //       size: 20,
                          //     ),
                          //     title: Text("Seller Registation"),
                          //     onTap: (){
                          //       //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                          //     },
                          //   ),
                          // ),
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
                                Get.to(RefundPolicyPage());
                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
                              },
                            ),
                          ),




                        ],


                      ),
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

                      ),
                      SizedBox(height: 15,)
                    ],
                  ):
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


          ),)

        ],
      )
    );
  }
  void showLoginWarning( ) {

    Get.defaultDialog(
        contentPadding: EdgeInsets.zero,
        //  title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [

            Stack(
              children: [
                Container(

                    child:   Center(
                      child: Column(
                        children: [

                          Container(

                            margin:EdgeInsets.only(right:00.0,top: 0,left: 00,
                              bottom: 0,
                            ),
                            child:Image.asset(
                              "assets/images/fnf_logo.png",
                              // color: sohojatri_color,
                              // width: 81,
                              height: 40,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child:   Text(
                                "This section is Locked",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Go to login or Sign Up screen \nand try again ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.to(SignUpScreen());

                                //  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));

                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              child: Ink(

                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [sohojatri_color, sohojatri_color],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                child: Container(

                                  height: 40,
                                  alignment: Alignment.center,
                                  child:  Text(
                                    "SIGN UP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PT-Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 0),
                            child: InkWell(
                              onTap: (){
                                Get.back();
                                Get.to(LogInScreen());
                                //   Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                height: 40,
                                alignment: Alignment.center,
                                child:  Text(
                                  "LOG IN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PT-Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: sohojatri_color,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

                ),
                Align(alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),



                    child: InkWell(
                      onTap: (){
                        Get.back();


                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.deepOrangeAccent,
                        size: 22.0,
                      ),
                    ),
                  ),

                ),
              ],
            )

          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
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
                  margin: EdgeInsets.only(left:50),
                  child: ListTile(
                    // leading: Icon(Icons.info_outline,
                    //   color: sohojatri_color.withOpacity(.6),
                    //   size: 20,
                    // ),
                    title: Text(
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

  void removeUserInfo() async {
    try {

      var storage =GetStorage();
      storage.write(pref_user_name, "");
      storage.write(pref_user_token, "");

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
