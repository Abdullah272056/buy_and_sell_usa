import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../api_service/api_service.dart';
import '../../controller/cart_controller/cart_page_controller.dart';
import '../../controller/product_controller/product_details_controller.dart';
import '../../data_base/sqflite/note.dart';
import '../../data_base/sqflite/notes_database.dart';
import '../../static/Colors.dart';
import '../auth/log_in_page.dart';
import '../auth/sign_up_page.dart';
import '../checkout step/checkout_page.dart';
import '../product/product_details.dart';



class RefundPolicyPage extends StatelessWidget {

  String policytext="Nihil exercitationem ea qui temporibus veritatis omnis."
      " Doloremque qui ut labore dignissimos sed. Sit rerum iste aut inventore sit."
      " Dolorem voluptatem dolor quidem aut aut. Aperiam cumque sint rerum placeat voluptates "
      "asperiores odit. Corporis commodi magnam repellendus debitis facere voluptate. "
      "Aut ipsa praesentium numquam fuga numquam. Inventore illum fugiat eum cumque eaque."
      " Et voluptatem et laboriosam facere qui rerum eos. Voluptas non aspernatur autem."
      " Sunt est ut id maxime autem dolores amet. Autem aut ut minima qui. "
      "Aliquid non tempore mollitia consequatur quia et voluptas. Nihil laborum quasi velit "
      "expedita reiciendis inventore. Distinctio temporibus facilis a enim praesentium. "
      "Praesentium perferendis rem odit eos. Numquam architecto nulla modi saepe."
      " Quia omnis iste et numquam est cum et. Temporibus quia doloremque qui consequatur magni. "
      "Labore consequatur voluptatem voluptatem quasi eveniet sit. Sed eveniet repellendus "
      "ipsum quia quidem minima. Quos ipsa quod cum necessitatibus itaque incidunt. "
      "Reiciendis veritatis at mollitia asperiores hic laudantium. Maxime corrupti deserunt labore expedita "
      "fugiat reiciendis cum neque. Ullam voluptas commodi iste perferendis dicta aut. In voluptatibus velit "
      "et illum quo temporibus. Odit cum natus id voluptas laborum. Voluptatum rem ab qui veritatis quia cumque. "
      "Dolores deleniti praesentium sequi autem ut iste. Repellat velit eos dolorem voluptas reiciendis neque. "
      "Et harum est accusamus architecto ut quia fuga. Distinctio dignissimos corrupti consectetur facere. Molestiae "
      "est ut inventore et dolorem eius omnis. Odio et voluptates enim consequatur voluptatem molestiae dolorem alias."
      " Sequi est velit dolorem ad itaque sunt labore. Sunt ipsam omnis sequi itaque. Ipsa molestiae sint aspernatur"
      " maxime illum sequi voluptas. Quia alias sed eum sit sed voluptates omnis. Sed aut blanditiis quia temporibus. "
      "Maiores est voluptatibus molestias optio. Repellat reiciendis consequatur tenetur nobis temporibus. Officia et "
      "quam consectetur quaerat quia maxime et. In et nisi molestias molestias numquam est. Perspiciatis sunt repudiandae "
      "omnis fugit rem voluptates neque. Ab alias consequuntur magni in nesciunt omnis. Explicabo sed voluptas et aperiam"
      " illum nobis velit. Voluptas deleniti ut illo ut. Sit voluptatem et commodi sequi omnis. Itaque amet sapiente"
      " molestiae. Tempore quae hic eum asperiores. Illo non quia sit earum. Sit corrupti sint ratione necessitatibus "
      "cumque et corporis. In et voluptas dicta dolor doloribus ut expedita. Omnis libero dicta cumque harum exercitationem. "
      "Ut animi possimus ea id accusamus neque. Nam architecto non aut mollitia at. Sint quis dolor cumque. Non impedit"
      " qui error quam maxime minima perferendis. Architecto soluta maxime a repellat a libero. Id dolor quo aliquid"
      " temporibus nesciunt repudiandae dicta. Debitis illo temporibus saepe consequatur. Fugiat adipisci illum expedita id "
      "facilis voluptatum. Fugiat sit rem itaque ratione. Et tempore ab nihil error dolore nemo veritatis deleniti. Et ea ab "
      "vel molestiae ad odit. Eos sapiente molestiae sit quod sit. Eum et unde perferendis quibusdam magnam ad nam. Ipsum "
      "aliquid quia minima id. Aut ullam dolores cum quia itaque blanditiis. Est ea tempora voluptatem praesentium ab eos. "
      "Beatae voluptatem illo quae. Occaecati fugiat quo accusantium molestias necessitatibus porro dolorem. Aut molestiae "
      "recusandae repellendus quibusdam. Praesentium fugiat delectus eveniet ipsam soluta. Possimus facilis quia quasi eius "
      "molestias minus voluptatem. Adipisci est omnis facilis repellendus pariatur autem. Ex aut optio voluptatem molestiae ab."
      " Reprehenderit a sint et totam ducimus maxime. Maiores sit distinctio ratione velit omnis voluptas cupiditate. Et laborum "
      "consequatur ut doloribus accusamus molestiae voluptatem. Laudantium officia voluptatem non maiores nam beatae corrupti. "
      "Minus repudiandae est voluptatem cumque quidem blanditiis. Libero voluptatem qui eaque quasi. Alias sit suscipit voluptatem"
      " minus esse. Et nihil "
      "ut animi quis. Et architecto voluptas aut nisi a repudiandae dolorum. Aliquam hic inventore voluptatem in sed.";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:Container(
          decoration: BoxDecoration(
            color:fnf_title_bar_bg_color,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
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
                  Expanded(child: Text(
                    "REFUND POLICY",
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17
                    ),
                  )),


                ],
              ),
              SizedBox(
                height: 7
                // height: 50,
              ),
              Expanded(
                  child:Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: SingleChildScrollView(
                            child:Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text(
                                      "Refund & Return Policy",
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color:fnf_color,
                                          fontSize: 22,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  policytext,
                                  style: TextStyle(
                                      color:fnf_small_text_color,
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            )
                        ))

                      ],
                    )
                  )


              )
            ],
          )

      )
    );



  }



  void showLoginWarning( ) {

    Get.defaultDialog(
        contentPadding: EdgeInsets.zero,

        //  title: '',
        titleStyle: TextStyle(fontSize: 0),
        // backgroundColor: Colors.white.withOpacity(.8),
        content: Wrap(
          children: [

            Stack(
              children: [
                Container(

                    child:   Center(
                      child: Column(
                        children: [

                          Container(

                            margin:EdgeInsets.only(right:00.0,top: 0,left: 00,
                              bottom: 0,
                            ),
                            child:Image.asset(
                              "assets/images/fnf_logo.png",
                              // color: sohojatri_color,
                              // width: 81,
                              height: 40,
                              width: 90,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 20, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child:   Text(
                                "This section is Locked",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            child:  Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Go to login or Sign Up screen \nand try again ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    color: text_color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                Get.to(SignUpScreen());

                                //  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));

                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              child: Ink(

                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [sohojatri_color, sohojatri_color],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                child: Container(

                                  height: 40,
                                  alignment: Alignment.center,
                                  child:  Text(
                                    "SIGN UP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PT-Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 0),
                            child: InkWell(
                              onTap: (){
                                Get.back();
                                Get.to(LogInScreen());
                                //   Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0)
                                ),
                                height: 40,
                                alignment: Alignment.center,
                                child:  Text(
                                  "LOG IN",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PT-Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: sohojatri_color,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )

                ),
                Align(alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),



                    child: InkWell(
                      onTap: (){
                        Get.back();


                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.deepOrangeAccent,
                        size: 22.0,
                      ),
                    ),
                  ),

                ),
              ],
            )

          ],
          // child: VerificationScreen(),
        ),
        barrierDismissible: false,
        radius: 10.0);
  }
  //toast create
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:Colors.amber,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}

