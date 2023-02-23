import 'package:flutter/material.dart';
import 'package:fnf_buy/view/common/toast.dart';
import 'package:fnf_buy/view/dash_board/sub_category_page.dart';
import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../controller/dash_board_controller/caregories_page_controller.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../controller/dash_board_controller/sub_caregories_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../static/Colors.dart';
import '../product/product_list.dart';
import '../shimer/product_shimmir.dart';
import 'dash_board_page.dart';

class CategoryPage extends StatelessWidget{
  final categoriesPageController = Get.put(CategoriesPageController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async {

          Get.deleteAll();
          Get.offAll(DashBoardPageScreen())?.then((value) => Get.delete<DashBoardPageController>());
         return true;

        },
        child: Scaffold(
            body:Container(
                decoration: BoxDecoration(
                  color:fnf_title_bar_bg_color,
                ),
                child: Obx(() => Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                      // height: 50,
                    ),

                    Flex(direction: Axis.horizontal,
                      children: [
                        SizedBox(width: 30,),

                        SizedBox(width: 5,),
                        Expanded(child: Text(
                          "All Categories",
                          style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17
                          ),
                        )),


                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
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
        ),
      );

  }

  Widget categoriesListItemDesign({required var response}){
    return InkResponse(
      onTap: (){
        Get.to(() => SubCategoryPage(), arguments: [
          {"categoriesId": response["id"].toString()},
          {"categoriesName": response["category_name"].toString()},
          {"categoriesImage": ""}

        ])?.then((value) => Get.delete<SubCategoriesPageController>());
        // Get.to(() => ProductListPage(), arguments: [
        //   {"categoriesId": response["id"].toString()},
        //   {"subCategoriesId": ""},
        //   {"searchValue": ""}
        //
        // ])?.then((value) => Get.delete<ProductDetailsController>());
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
                  image:BASE_URL_API_IMAGE_CATEGORIES+response["category_image"].toString(),
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
                response["category_name"].toString(),
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


  void goToPrevious(){
    Get.to( DashBoardPageScreen());
  }


}

