
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../controller/dash_board_page_controller.dart';
import '../../static/Colors.dart';
import '../dash_board/More_page.dart';
import '../dash_board/account_page.dart';
import '../dash_board/cart_page.dart';
import '../dash_board/category_page.dart';
import '../dash_board/home_page.dart';
import '../dash_board/profile_section/profile_section_page.dart';
import 'custom_drawer.dart';



class DashBoardPageScreen extends StatelessWidget {

  // int selectedTabIndex;
  //  Widget selectedPage;
  // DashBoardPageScreen(this.selectedTabIndex, this.selectedPage);

  final dashBoardPageController = Get.put(DashBoardPageController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container(


        child: Obx(() =>dashBoardPageController.selectedPage[0]),

      ),

      bottomNavigationBar: Obx(() =>  BottomNavigationBar(
          selectedItemColor: bottom_nav_item_selected_color,
          unselectedItemColor: bottom_nav_item_unselected_color,
          currentIndex: dashBoardPageController.selectedTabIndex.value,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (int index){
            dashBoardPageController.selectedTabIndex(index);
            if(index==0){
              dashBoardPageController.updateSelectedPage([HomePageScreen()]);
              // selectedPage(HomePage( ));
              return;
            }

            if(index==1){
              dashBoardPageController.updateSelectedPage([CategoryPage()]);
              //  selectedPage(HomePage( ));
              // selectedPage= ShopPage( );


              return;
            }

            if(index==2){
              dashBoardPageController.updateSelectedPage([ProfileSectionPage()]);
              // selectedPage= AccountPage( );
              return;
            }

            if(index==3){
              dashBoardPageController.updateSelectedPage([CartPage()]);
              // selectedPage= CartPage( );
              return;
            }

            if(index==4){
              dashBoardPageController.updateSelectedPage([CustomDrawer()]);
              // selectedPage= SearchPage( );
              return;
            }


          },
          items: [
            _bottomNavigationBarItem(iconData: Icons.home, levelText: 'Home'),
            _bottomNavigationBarItem(iconData: Icons.grid_view, levelText: 'Category'),
            _bottomNavigationBarItem(iconData: Icons.person, levelText: 'Account'),
            _bottomNavigationBarItem(iconData: Icons.add_shopping_cart, levelText: 'Cart'),
            _bottomNavigationBarItem(iconData: Icons.read_more, levelText: 'More'),


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
