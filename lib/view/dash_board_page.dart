

import 'package:flutter/material.dart';
import 'package:fnf_buy/view/account_page.dart';
import 'package:fnf_buy/view/cart_page.dart';
import 'package:fnf_buy/view/home_page.dart';
import 'package:fnf_buy/view/search_page.dart';
import 'package:fnf_buy/view/shop_page.dart';

import 'package:get/get.dart';
import '../controller/dash_board_page_controller.dart';
import '../static/Colors.dart';

class DashBoardPageScreen extends StatelessWidget {

  // int selectedTabIndex;
  //  Widget selectedPage;
  //
  //
  // DashBoardPageScreen(this.selectedTabIndex, this.selectedPage);

  final dashBoardPageController = Get.put(DashBoardPageController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: SafeArea(

          child:Container(
           child: Obx(() =>dashBoardPageController.selectedPage[0]),

          )

        //
        //   child:  Obx(() =>
        //     IndexedStack(
        //       index:dashBoardPageController.selectedTabIndex.value,
        //       children: [
        //         HomePage(),
        //         ShopPage(),
        //         AccountPage(),
        //         CartPage(),
        //         SearchPage(),
        //       ],
        // )
        // ),



      ),

      bottomNavigationBar: Obx(() =>  BottomNavigationBar(
          selectedItemColor: bottom_nav_item_selected_color,
          unselectedItemColor: bottom_nav_item_unselected_color,
          currentIndex: dashBoardPageController.selectedTabIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index){
            dashBoardPageController.selectedTabIndex(index);
            if(index==0){
              dashBoardPageController.updateSelectedPage([HomePage()]);
              // selectedPage(HomePage( ));
              return;
            }

            if(index==1){
              dashBoardPageController.updateSelectedPage([ShopPage()]);
              //  selectedPage(HomePage( ));
              // selectedPage= ShopPage( );
              return;
            }

            if(index==2){
              dashBoardPageController.updateSelectedPage([AccountPage()]);
              // selectedPage= AccountPage( );
              return;
            }

            if(index==3){
              dashBoardPageController.updateSelectedPage([CartPage()]);
              // selectedPage= CartPage( );
              return;
            }

            if(index==4){
              dashBoardPageController.updateSelectedPage([SearchPage()]);
              // selectedPage= SearchPage( );
              return;
            }


          },
          items: [
            _bottomNavigationBarItem(iconData: Icons.home, levelText: 'Home'),
            _bottomNavigationBarItem(iconData: Icons.menu, levelText: 'Shop'),
            _bottomNavigationBarItem(iconData: Icons.person, levelText: 'Account'),
            _bottomNavigationBarItem(iconData: Icons.add_shopping_cart, levelText: 'Cart'),
            _bottomNavigationBarItem(iconData: Icons.search, levelText: 'Search'),


          ],
        ),),

    );
  }



_bottomNavigationBarItem({required IconData iconData,required String levelText}){

    return BottomNavigationBarItem(

        icon: Icon(iconData),
        // icon: Icon(Icons.icon),
        label: levelText

        // items:
    );
}

}
