import 'package:flutter/material.dart';
import 'package:fnf_buy/view/dash_board/wish_list_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api_service/api_service.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/dash_board_controller/caregories_page_controller.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/dash_board_controller/sub_caregories_page_controller.dart';
import '../../controller/dash_board_controller/wish_list_page_controller.dart';
import '../../controller/product_controller/all_product_list_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../static/Colors.dart';
import '../cart/cart_page.dart';
import '../product/product_list.dart';
import '../profile_section/profile_section_page.dart';
import '../shimer/product_shimmir.dart';
import 'dash_board_page.dart';

class SubCategoryPage extends StatelessWidget{

  final categoriesPageController = Get.put(SubCategoriesPageController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
        body:Container(
            decoration: BoxDecoration(
              color:fnf_title_bar_bg_color,
            ),
            child: Obx(() => Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                  // height: 50,
                ),

                Flex(direction: Axis.horizontal,
                  children: [
                    SizedBox(width: 5,),
                    IconButton(
                      iconSize: 20,
                      icon:Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(width: 5,),
                    Expanded(child: Obx(()=>Text(
                      categoriesPageController.categoryName.value,
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                      ),
                    ))),


                    Container(
                      margin: EdgeInsets.only(top: 0,right: 10),
                      child: InkWell(
                          onTap: (){
                            Get.deleteAll();
                            Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());
                          },
                          child: Icon(
                            Icons.home,
                            size: 25,
                            color: Colors.white,
                          )
                      ),
                    ),
                    SizedBox(width: 10,),


                    // Container(
                    //   margin: EdgeInsets.only(top: 0,right: 10),
                    //   child: InkWell(
                    //       onTap: (){
                    //         if(categoriesPageController.userToken.isNotEmpty &&
                    //             categoriesPageController.userToken.value!=null){
                    //           categoriesPageController.addWishList(
                    //               token: categoriesPageController.userToken.toString(),
                    //               productId: categoriesPageController.productId.toString());
                    //
                    //         }else{
                    //           showLoginWarning();
                    //         }
                    //       },
                    //       child: Icon(
                    //
                    //         Icons.favorite_border,
                    //         size: 25,
                    //         color: Colors.red,
                    //       )
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: InkWell(

                        onTap: () {
                          if(categoriesPageController.userToken.isNotEmpty &&
                              categoriesPageController.userToken.value!="null"&&
                              categoriesPageController.userToken.value!=null){
                            // _showToast(homeController.userToken.toString());
                            //  _showToast("add favourite");
                            Get.to(WishListPage())?.then((value) => Get.delete<WishListPageController>());
                          }else{
                            showLoginWarning();
                          }

                        },
                        child:  Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    InkWell(
                      onTap: (){

                        Get.to(CartPage())?.then((value) => Get.delete<CartPageController>());
                      },
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(width: 25,),


                  ],
                ),

                SizedBox(
                  height: 5,
                  // height: 50,
                ),

                if(categoriesPageController.categoriesShimmerStatus==1)...{
                  Expanded(child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 20,right: 20,top: 00),

                      child:GridView.builder(
                          itemCount:18,
                          // itemCount:allProductListPageController.filterProductList.length,
                          // shrinkWrap: true,
                          // physics: const ClampingScrollPhysics(),
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.size.width>550?4:3,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 10.0,
                              mainAxisExtent: Get.size.width>550?220: 150
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return categoriesListItemDesignShimmer();
                          })


                  )),
                }
                else...{
                  Expanded(child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 20,right: 20,top: 00),

                      child:Obx(()=>GridView.builder(
                          itemCount:categoriesPageController.categoriesDataList.length,
                          // itemCount:allProductListPageController.filterProductList.length,
                          // shrinkWrap: true,
                          // physics: const ClampingScrollPhysics(),
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.size.width>550?4:3,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 7.0,
                              mainAxisExtent:Get.size.width>550?220: 150
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return categoriesListItemDesign(response: categoriesPageController.categoriesDataList[index]);
                          }))


                  )),
                }

              ],
            ))

        )
    );
  }

  Widget categoriesListItemDesign({required var response}){
    return InkResponse(
      onTap: (){
        Get.to(() => ProductListPage(), arguments: [
          {"categoriesId": categoriesPageController.categoryId.value},
          {"subCategoriesId": response["id"].toString()},
          {"searchValue": ""}

        ])?.then((value) => Get.delete<AllProductListPageController>());
      },
      child:  Column(
        children: [

          Expanded(child:
            ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // height:100,
              //  width: 100,
                color:hint_color,
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  placeholder: 'assets/images/loading.png',
                  image:BASE_URL_API_IMAGE_SUB_CATEGORIES+response["photo"].toString(),
                  // "https://cdn.vox-cdn.com/thumbor/UMnuubuFGIsw339rSvq3HtaoczQ=/0x0:2048x1280/2000x1333/filters:focal(1024x640:1025x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/22406771/Exbfpl2WgAAQkl8_resized.jpeg",
                  imageErrorBuilder: (context, url, error) =>
                      Image.asset(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        fit: BoxFit.fill,
                        'assets/images/loading.png',
                       // fit: BoxFit.fitWidth,
                      ),
                )),
          ),
          ),

          Container(
              margin:  const EdgeInsets.only(left: 0, right: 0,bottom: 10,top: 8),
              child:  Text(
                response["name"].toString(),
                textAlign: TextAlign.center,
                maxLines: 2,
                style:  TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              )
          ),

        ],
      ),
    );
  }

  Widget categoriesListItemDesignShimmer(){
    return Column(
      children: [

        Expanded(child:
          ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            // height:100,
            //  width: 100,
              color:hint_color,
              child: buildRectangleShimmer(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  marginLeft: 0,
                  marginTop: 0,
                  marginRight: 0,
                  marginBottom: 0

                 ),

          ),
        ),
        ),

        Container(
            margin:  const EdgeInsets.only(left: 0, right: 0,bottom: 10,top: 8),
            child: buildRectangleShimmer(
                height: 20,
                width: double.maxFinite,
                marginLeft: 0,
                marginTop: 0,
                marginRight: 0,
                marginBottom: 0

            ),
        ),

      ],
    );
  }

}

