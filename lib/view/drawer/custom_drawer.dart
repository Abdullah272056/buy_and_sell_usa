
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../controller/drawer_controller/custom_drawer_controller.dart';
import '../../static/Colors.dart';
import '../auth/log_in_page.dart';
import '../auth/sign_up_page.dart';
import '../cart/cart_page.dart';
import '../product/product_list.dart';


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

                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: ListTile(
                              leading: Icon(Icons.login,
                                color: sohojatri_color.withOpacity(.6),
                                size: 20,
                              ),
                              title: Text("Seller Login"),
                              onTap: (){
                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
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
                                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchiveRideScreen()));
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
