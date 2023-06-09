
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/dash_board_controller/dash_board_page_controller.dart';
import '../../data_base/share_pref/sharePreferenceDataSaveName.dart';
import '../../static/Colors.dart';
import '../cart/cart_page_for_dash_board.dart';
import '../drawer/custom_drawer.dart';
import '../order/vendor/vendor_order_page.dart';
import '../profile_section/profile_section_page.dart';
import 'More_page.dart';

import '../cart/cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';

class DashBoardPageScreen extends StatelessWidget {

  // int selectedTabIndex;
  //  Widget selectedPage;
  // DashBoardPageScreen(this.selectedTabIndex, this.selectedPage);

  final dashBoardPageController = Get.put(DashBoardPageController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetStorage().read(pref_user_type).toString()=="vendor"?
      Scaffold(
      body: Column(
        children: [
          Expanded(child:  VendorOrderPage(),),
        ],
      ),
    ):
    Scaffold(

      body: Obx(() =>dashBoardPageController.selectedPage[0]),

      bottomNavigationBar:Obx(() =>  BottomNavigationBar(
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
            dashBoardPageController.updateSelectedPage([CartPageForDashBoard()]);
            // selectedPage= CartPage( );
            return;
          }

          if(index==4){
            dashBoardPageController.updateSelectedPage([MorePage()]);
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
