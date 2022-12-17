
import 'dart:convert';
import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnf_buy/static/Colors.dart';



class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() =>
      _HomePageScreenState();
}

class _HomePageScreenState
    extends State<HomePageScreen> {
  TextEditingController? searchController = TextEditingController();

  List<String> categoryList=["Phone","Laptop","Book Book","Fresh Food","Fashion","Toys",
    "Grocery","Jewellery","Software","Car","Shoee","Matrix","Furniture","Building"];

  int _subCategoriesButtonColorStatus=0;

  @override
  @mustCallSuper
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color:fnf_title_bar_bg_color,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
              // height: 50,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: InkWell(

                    onTap: () {
                    },
                    child:  Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child:  Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: InkWell(

                            onTap: () {
                            },
                            child: Image.asset(
                              "assets/images/fnf_logo.png",
                              // width: 25,
                              fit: BoxFit.fill,
                              height: 35,
                            ),
                          ),
                        ),
                      ),
                    )),



                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(

                    onTap: () {
                    },
                    child:  Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  child: InkWell(

                    onTap: () {
                    },
                    child:  Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 25.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 35,
              // height: 30,
            ),


            Expanded(
              child:  SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBottomSectionDesign(),
                  ],
                ),
              )


            ),


          ],
        ),

        /* add child content here */
      ),
    );
  }

  Widget _buildTabButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 10),
      height: 40,
      child: Row(
        children: [
          Expanded(child: ListView.builder(
            itemCount:categoryList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
              if(index==0){
                return  _buildCategoriesTabItem(categoryList[index].toUpperCase(),index,15,0);
              }
              else if(index==categoryList.length-1){
                return  _buildCategoriesTabItem(categoryList[index].toUpperCase(),index,5,15);
              }

              else{
                return  _buildCategoriesTabItem(categoryList[index].toUpperCase(),index,5,0);
              }

              }),)
        ],
      ),
    );
  }


  Widget _buildCategoriesTabItem(var response,int index,double marginLeft,double marginRight) {
    return  InkWell(
      onTap: (){
        setState(() {
          _subCategoriesButtonColorStatus = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
            left:10.0, right: 10.0, bottom: 0, top: 0),
        margin:  EdgeInsets.only(left: marginLeft, right: marginRight),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                response.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 14,
                    fontWeight:_subCategoriesButtonColorStatus== index? FontWeight.w700:FontWeight.w500),
              ),
              Container(height: 7,),
              Container(
                height: 3.5,
              width: 50,
              color: _subCategoriesButtonColorStatus== index?Colors.blue:Colors.transparent,
              // color: Colors.blue,
              )
            ],
          )
        ),
      ),
    );
  }


  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: fnf_color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildBottomSectionDesign() {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(
          color:Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 00, top: 00, right: 00, bottom: 00),
            child: Column(
              children: [
                ///categories tab section
                _buildTabButton(),

                ///slider section
                Container(
                  height: size.height * 0.23,
                  child: Swiper(
                    itemCount: 7,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: (){
                          _showToast(index.toString());
                        },
                        child: _sliderCardDesign(),
                      ) ;


                    },
                    autoplay: true,
                    pagination: const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.white,
                            activeColor: Colors.green)),
                    // control: const SwiperControl(),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(left: 00, top: 00, right: 00, bottom: 00),
                  margin  : const EdgeInsets.only(left: 00, top: 10, right: 00, bottom: 10),
                  height: 190,
                  // color: Colors.lime,
                  child: Center(
                    child: GridView.builder(
                        itemCount:categoryList.length,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 60

                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return  categoriesListItemDesign(response: categoryList[index]);
                          // return _buildRecentlyCourseItemForGrid(_recentlyAddedCourse[index]);
                        }),
                  ),
                ),
                Container(
                  margin:const EdgeInsets.only(right: 20.0,top: 00,left: 20),
                  child:  Flex(direction: Axis.horizontal,
                    children: [

                      Expanded(child: Align(
                        alignment: Alignment.topLeft,
                        child:  Text("Mens Fashion",
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          // textAlign: TextAlign.left,

                        ),
                      ),),
                      Container(
                        margin:  const EdgeInsets.only(left: 10.0, right: 0.0,top: 10),
                        child: InkResponse(
                          onTap: (){

                            //   Navigator.push(context,MaterialPageRoute(builder: (context)=>const RecentlyAddedSeeMoreScreen()));

                          },
                          child: Image.asset(
                            "assets/images/arrow_right.png",
                            color: fnf_small_color,
                            width: 27,
                            height: 27,
                            fit: BoxFit.fill,
                          ),
                        ),

                      )

                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 0),
                    height:270.0,

                    // child: _buildRecentlyAddedCourseItem(),
                    child: ListView.builder(
                      //  shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      //itemCount: offerDataList == null ? 0 : offerDataList.length,
                      itemCount:9,
                      itemBuilder: (context, index) {
                        if(MediaQuery.of(context).size.width<450){

                          return productCardDesign(height: 00, width: MediaQuery.of(context).size.width,
                              imageLink: "https://m.media-amazon.com/images/I/61TrmpaafpL._AC_UL320_.jpg");
                        }

                        else{
                          return productCardDesign(height: 00, width: 420,
                              imageLink: "https://m.media-amazon.com/images/I/61TrmpaafpL._AC_UL320_.jpg");

                        }

                      },
                      scrollDirection: Axis.horizontal,
                    )
                ),

                Container(
                  margin:const EdgeInsets.only(right: 20.0,top: 00,left: 20),
                  child:  Flex(direction: Axis.horizontal,
                    children: [

                      Expanded(child: Align(alignment: Alignment.topLeft,
                        child:  Text("Womens Fashion",
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          // textAlign: TextAlign.left,

                        ),
                      ),),
                      Container(
                        margin:  const EdgeInsets.only(left: 10.0, right: 0.0,top: 10),
                        child: InkResponse(
                          onTap: (){

                            //   Navigator.push(context,MaterialPageRoute(builder: (context)=>const RecentlyAddedSeeMoreScreen()));

                          },
                          child: Image.asset(
                            "assets/images/arrow_right.png",
                            color: fnf_small_color,
                            width: 27,
                            height: 27,
                            fit: BoxFit.fill,
                          ),
                        ),

                      )

                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 0),
                    height:270.0,

                    // child: _buildRecentlyAddedCourseItem(),
                    child: ListView.builder(
                      //  shrinkWrap: true,

                      // physics: const NeverScrollableScrollPhysics(),
                      //itemCount: offerDataList == null ? 0 : offerDataList.length,
                      itemCount:9,
                      itemBuilder: (context, index) {
                        if(MediaQuery.of(context).size.width<450){

                          return productCardDesign(height: 00, width: MediaQuery.of(context).size.width,
                              imageLink: "https://www.glowme.com.bd/image/cachewebp/catalog/Ladies%20Dress%20GM0002-550x550.webp");
                        }

                        else{
                          return productCardDesign(height: 00, width: 420,
                              imageLink: "https://www.glowme.com.bd/image/cachewebp/catalog/Ladies%20Dress%20GM0002-550x550.webp");

                        }

                        // return productCardDesign(height: 00, width: MediaQuery.of(context).size.width,
                        //     imageLink: "https://www.glowme.com.bd/image/cachewebp/catalog/Ladies%20Dress%20GM0002-550x550.webp");
                        //

                      },
                      scrollDirection: Axis.horizontal,
                    )
                ),

                Container(
                  margin:const EdgeInsets.only(right: 20.0,top: 00,left: 20),
                  child:  Flex(direction: Axis.horizontal,
                    children: [

                      Expanded(child: Align(alignment: Alignment.topLeft,
                        child:  Text("Kids Fashion",
                          style: TextStyle(
                              color:text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          // textAlign: TextAlign.left,

                        ),
                      ),),
                      Container(
                        margin:  const EdgeInsets.only(left: 10.0, right: 0.0,top: 10),
                        child: InkResponse(
                          onTap: (){

                            //   Navigator.push(context,MaterialPageRoute(builder: (context)=>const RecentlyAddedSeeMoreScreen()));

                          },
                          child: Image.asset(
                            "assets/images/arrow_right.png",
                            color: fnf_small_color,
                            width: 27,
                            height: 27,
                            fit: BoxFit.fill,
                          ),
                        ),

                      )

                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 0),
                    height:270.0,

                    // child: _buildRecentlyAddedCourseItem(),
                    child: ListView.builder(
                      //  shrinkWrap: true,

                      // physics: const NeverScrollableScrollPhysics(),
                      //itemCount: offerDataList == null ? 0 : offerDataList.length,
                      itemCount:9,
                      itemBuilder: (context, index) {

                        if(MediaQuery.of(context).size.width<450){

                          return productCardDesign(height: 00, width: MediaQuery.of(context).size.width,
                              imageLink: "https://assets0.mirraw.com/images/10166899/White_Pink_Choli_Front_large_m.jpg");
                        }

                        else{
                          return productCardDesign(height: 00, width: 420,
                              imageLink: "https://assets0.mirraw.com/images/10166899/White_Pink_Choli_Front_large_m.jpg");

                        }
                        // return productCardDesign(height: 00, width: MediaQuery.of(context).size.width,
                        //     imageLink: "https://assets0.mirraw.com/images/10166899/White_Pink_Choli_Front_large_m.jpg");
                        //

                      },
                      scrollDirection: Axis.horizontal,
                    )
                ),

              ],
            )));
  }

  Widget productCardDesign({
    required double height,
    required double width,
    required String imageLink
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Container(
          width:width/2 ,
          // height:width/1.3
          padding: EdgeInsets.only(left: 10,right: 10),
          // color: Colors.white,
          child:  Column(
            // alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  // color:Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Stack(
                  children: [
                    AspectRatio(
                        aspectRatio: 1,
                        child:Padding(
                          padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                          // padding: EdgeInsets.all(16),
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.fill,
                            placeholder: 'assets/images/loading.png',
                            image:imageLink,
                            imageErrorBuilder: (context, url, error) =>
                                Image.asset(
                                  'assets/images/loading.png',
                                  fit: BoxFit.fill,
                                ),
                          )
                          // Image.asset(
                          //     imageLink
                          // ),
                        )
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.favorite_outline,
                          color: hint_color,
                        ),

                      ),
                    )
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  Text("Men Grey Classic Regular Fit Formal Shirt",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          softWrap: false,
                          maxLines: 1,

                        ),
                      ),
                      // 12.widthBox,
                      // RatingWidget(rating: widget.product.rating),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          children: [
                            RatingBarIndicator(
                              // rating:response["avg_rating"],
                              rating:double.parse("4.5"),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color:Colors.orange,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              " 8 Review",
                              style: const TextStyle(
                                fontSize: 12,
                                color:hint_color,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  Text("\$ 99.00",
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                          softWrap: false,
                          maxLines: 2,

                        ),
                      ),
                      // 12.widthBox,
                      // RatingWidget(rating: widget.product.rating),
                    ],
                  ),



                ],
              ),






            ],
          ),
        )
      ],
    );
  }

  Widget _sliderCardDesign() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      width: double.infinity,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
            colors: [

              Color(0xFF7A60A5),
              //Color(0xFF82C3DF),
              fnf_color,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF9689CE),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Get the special discount",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "40 %\nOFF",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                // fontSize: 300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.network(
                width: double.infinity,
                // height: double.infinity,
                "https://i.ibb.co/vwB46Yq/shoes.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget categoriesListItemDesign({required var response}){
    return InkResponse(
      onTap: (){

        // Navigator.push(context,MaterialPageRoute(builder: (context)=>
        //     SendMoneyAmountPageScreen(
        //         response["id"].toString(),response["username"].toString()
        //     )));


      },
      child:  Container(
        margin: const EdgeInsets.only(right:00,top: 0,left: 0,bottom: 00),
        // height: 68,
        child: Padding(padding: const EdgeInsets.only(right:00,top: 0,left: 00,bottom: 0),
          child:  Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25.5),
                child: Container(
                    height:50,
                    width: 50,
                    color:hint_color,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/loading.png',
                      image:
                          "https://cdn.vox-cdn.com/thumbor/UMnuubuFGIsw339rSvq3HtaoczQ=/0x0:2048x1280/2000x1333/filters:focal(1024x640:1025x641)/cdn.vox-cdn.com/uploads/chorus_asset/file/22406771/Exbfpl2WgAAQkl8_resized.jpeg",
                      imageErrorBuilder: (context, url, error) =>
                          Image.asset(
                            'assets/images/loading.png',
                            fit: BoxFit.fill,
                          ),
                    )),
              ),

              Container(
                  margin:  const EdgeInsets.only(left: 0, right: 0,bottom: 00,top: 5),
                  child:  Text(
                    response,
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
        ),
      ),
    );
  }


}
