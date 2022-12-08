import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'home_page1.dart';

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
                    Get.to(HomePage22());
                    // _showToast("");
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

