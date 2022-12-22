import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_page/product_list.dart';



class CartPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 100,
                child:  InkWell(
                  child: Text("click1"),
                  onTap: (){

                    // Get.to(ProductListPage());
                    Get.to(() => ProductListPage(), arguments: [
                      {"categoriesId": '1'},
                      {"subCategoriesId": '7'}
                    ]);

                  },

                ),
              ),

              Text(
                  "Cart page1"
              )
            ],
          )


      ),
    );
  }
}

