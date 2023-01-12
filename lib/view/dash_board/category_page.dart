import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api_service/api_service.dart';
import '../../controller/dash_board_controller/caregories_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../static/Colors.dart';
import '../product/product_list.dart';

class CategoryPage extends StatelessWidget{
  final categoriesPageController = Get.put(CategoriesPageController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Scaffold(
        body:Container(
            decoration: BoxDecoration(
              color:fnf_title_bar_bg_color,
            ),
            child: Column(
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

                Expanded(child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20,right: 20,top: 10),

                    child:Obx(()=>GridView.builder(
                        itemCount:categoriesPageController.categoriesDataList.length,
                        // itemCount:allProductListPageController.filterProductList.length,
                        // shrinkWrap: true,
                        // physics: const ClampingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 7.0,
                            mainAxisSpacing: 7.0,
                             mainAxisExtent: 200
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return categoriesListItemDesign(response: categoriesPageController.categoriesDataList[index]);
                        }))


                )),


              ],
            )

        )
    );
  }




  Widget categoriesListItemDesign({required var response}){
    return InkResponse(
      onTap: (){
        Get.to(() => ProductListPage(), arguments: [
          {"categoriesId": response["id"].toString()},
          {"subCategoriesId": ""},
          {"searchValue": ""}

        ])?.then((value) => Get.delete<ProductDetailsController>());
      },
      child:  Column(
        children: [
          Expanded(child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // height:100,
              //  width: 100,
                color:hint_color,
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/loading.png',
                  image:BASE_URL_API_IMAGE_CATEGORIES+response["category_image"].toString(),

                  // "https://cdn.vox-cdn.com/thumbor/UMnuubuFGIsw339rSvq3HtaoczQ=/0x0:2048x1280/2000x1333/filters:focal(1024x640:1025x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/22406771/Exbfpl2WgAAQkl8_resized.jpeg",
                  imageErrorBuilder: (context, url, error) =>
                      Image.asset(
                        fit: BoxFit.fill,
                        'assets/images/loading.png',
                       // fit: BoxFit.fitWidth,
                      ),
                )),
          ),),

          Container(
              margin:  const EdgeInsets.only(left: 0, right: 0,bottom: 10,top: 5),
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


}

