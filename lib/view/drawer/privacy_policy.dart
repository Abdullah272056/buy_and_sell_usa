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



class PrivacyPolicyPage extends StatelessWidget {

  String policytext="Harum in itaque soluta. Cumque quos recusandae qui beatae quis saepe. Ut quasi fugiat voluptatem aut autem facere est. Ut sed natus sit beatae commodi consequuntur est ea. Aut reprehenderit sed minus enim asperiores corrupti ullam hic. Minus laboriosam iste et eveniet aut rerum asperiores. Voluptatibus aliquam aut quasi. Ut vel quibusdam dolorem deleniti. Ratione est minus quibusdam maiores vero. Aut omnis animi est neque tempore. Sit ad porro sint est tempore necessitatibus harum adipisci. Sed natus vel commodi aut modi fugit quis. Et blanditiis dicta voluptatem fugit. Omnis earum earum dolor inventore. Dolorem nulla beatae aut. Rerum architecto quos corrupti mollitia vero enim et. Hic accusamus sit quos eius exercitationem. Est doloremque natus omnis est voluptas est rem. Molestiae sapiente cupiditate suscipit quisquam autem. Ab sint est eum enim. Soluta consectetur culpa ex minima inventore ducimus. Ipsum nesciunt sapiente maiores enim. Ex fuga mollitia beatae suscipit non vitae aliquam tempore. Reiciendis velit unde quis sunt et consequatur omnis. Ut culpa doloribus error fugiat quis et labore qui. Temporibus optio nisi pariatur deserunt enim. Et recusandae voluptatem iure in et. Placeat provident architecto amet adipisci. Nostrum voluptatem ea et. Voluptatem qui atque voluptates aut iste ipsa vitae. Rerum expedita autem et sequi consequatur repudiandae et. Maiores vero ut repudiandae. Voluptates labore molestiae officia nisi. Maiores totam impedit aut odit sequi. Itaque quasi qui non vero praesentium quia. Aut odit eaque molestiae. Deleniti hic facilis rem labore id adipisci nemo. Tempore nulla vitae et cum dolore quis consectetur. Ut qui in provident vel. Alias commodi recusandae quibusdam sit cupiditate adipisci porro. Est non pariatur enim voluptatem dolor vero vel. Accusantium officiis asperiores autem mollitia. Est optio quae corporis corporis rerum est aliquam. Temporibus debitis est velit dolore. Ex unde quasi ullam ea voluptatem voluptas ut. Ut laudantium dicta asperiores eos eos laudantium. Est aperiam placeat sed libero quia qui sunt et. Delectus magnam quo dicta quis quos atque. Sapiente tenetur accusamus aperiam quam. Reprehenderit voluptatem nostrum ex quia sunt. Et maiores praesentium molestiae doloribus vel quia. Odio quasi eveniet in sed aut eos aut distinctio. Et in aut quia. Quaerat in velit sed eos facere. Et tenetur delectus ipsa recusandae quis in. Animi atque est ex qui laboriosam. Quaerat accusamus vero non quidem aliquam vel mollitia. Ut aut est voluptatem temporibus velit animi. Aperiam pariatur mollitia velit eveniet in necessitatibus harum non. Quos doloribus commodi quis minima. Provident ullam quo et voluptatem quos quia nihil. Sit doloribus libero cupiditate. Laborum velit nihil perferendis ea. Vel nam aliquid laboriosam et porro sit perferendis perferendis. Sint temporibus minus odit tempora beatae sequi. Quasi sit saepe iste sed et voluptatum. Libero quia quidem quisquam inventore et. Commodi occaecati perspiciatis debitis ex minima. Eveniet quas minima ex. Minus error eum harum unde commodi. Beatae ex placeat et dicta assumenda ratione. Unde accusantium recusandae est quidem at. Numquam aut recusandae labore non corrupti molestiae. Praesentium debitis doloremque consequuntur quo. Voluptate quasi omnis cum aut. Architecto suscipit atque consectetur vero. Placeat alias eligendi ut voluptatum voluptatem repellat velit quas. Eligendi eveniet ad et dolores. Dolorem praesentium nobis nisi assumenda autem neque ut eligendi. Corrupti aut qui sunt. Voluptatum explicabo mollitia ut a dolor. Laudantium provident iusto rem. Voluptas sit et quis omnis quae placeat. Qui dolorem officia corrupti laborum quae repellendus numquam ut. Sint voluptates assumenda recusandae ut voluptas. Accusamus cumque praesentium amet voluptas rerum saepe. Et dolorem quam tempora esse iure rerum aliquid. Sit aliquid recusandae in sint voluptas enim expedita. Eius incidunt minima illo dolorem. Neque qui error est rerum. Aut commodi perspiciatis perspiciatis aut ab eius provident. Ut ab eaque veniam at quas velit cupiditate. In voluptatibus nihil eum illo omnis culpa ducimus vel. Quibusdam quam quam nesciunt voluptatem. Enim nulla sint vel vero. Quidem soluta cupiditate quo. Qui in a distinctio sunt fugiat quo velit. Fugiat nemo beatae qui eius quisquam aut ducimus. Commodi et totam cum commodi. Quibusdam beatae ut provident cum labore. Quidem placeat distinctio incidunt quae eligendi molestias. Accusamus autem et animi qui. Deleniti laborum illum beatae temporibus aperiam commodi. Rerum adipisci quae amet voluptatibus. Aperiam reprehenderit blanditiis rerum distinctio. Eos sequi itaque minus maiores. Amet excepturi enim quis praesentium error consequatur. Sequi iste aliquid perspiciatis et. Officiis consequatur aperiam voluptas quam et voluptate ratione. Ab ipsum voluptate ut eius voluptas omnis odio aliquam. Iste quisquam et quis. Sapiente quaerat ex quia id sit blanditiis impedit pariatur. Ut dolorem enim ipsa nostrum et in ut. Est magnam beatae iusto provident. Ea aliquid aperiam animi provident recusandae. Doloremque error dolorem deserunt debitis est officiis. Velit magni enim aut voluptas. Nihil aut aspernatur minima magni. Vero eos est non eveniet earum saepe nisi. Culpa in incidunt ad non ut fuga qui. Ut et cum neque voluptatem quis. Perspiciatis omnis et sint quia commodi.";

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
                    "PRIVACY POLICY",
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
                    padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 20),
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
                                      "Privacy Policy",
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

