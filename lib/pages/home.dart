

import 'package:caretutors_todo/widgets/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:super_banners/super_banners.dart';

import '../constants/strings.dart';
import '../utils/common_methods.dart';
import '../utils/shared_preference.dart';
import 'login_page.dart';
import 'manage_todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  final DatabaseReference _database = FirebaseDatabase(
      databaseURL: Strings.database_url
  ).reference();
  bool is_picture_loaded = false;
  String? image_link;
  String? area;
  String schedule = 'Loading..';
  bool is_loaded = true;
  bool is_loaded_pic = true;
  bool is_todo_list_empty = true;

  late TextEditingController title;
  late TextEditingController description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_schedule();
    title = TextEditingController();
    description = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    description.dispose();
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: Navbar(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF00A669),
            onPressed: () {
              // Add your action here
              print('Floating Action Button Pressed');
              showConfirmationDialog(context);
            },
            child: Icon(Icons.add, color: Colors.white,),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: size.height*0.05,),
                  Container(
                    width: size.width*0.9,

                    //First Line of the page
                    child: Row(
                      children: [
                        Container(
                          width: size.width*0.9*0.6,
                          child: RichText(
                              text: TextSpan(
                                style:  DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Dashboard',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Set the color for "Welcome"
                                      fontSize: size.width*0.09,
                                      decoration: TextDecoration.none,


                                    ),
                                  ),
                                  TextSpan(
                                    text: '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF00A669), // Set the color for "Back"
                                      fontSize: size.width*0.08,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),

                        SizedBox(width: size.width*0.9*0.15,),

                        InkWell(
                            onTap: (){

                            },
                            child: Container(
                              width: size.width*0.9*0.25,
                              child: Image.asset('assets/images/muslim.png'),
                            ),
                          ),



                      ],
                    ),
                  ),

                  SizedBox(height: size.height*0.05,),

                  is_todo_list_empty ? Container(
                    height: size.height * 0.67,
                    width: size.width * 1,
                    //color: Colors.green,
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                          child: GestureDetector(
                            onTap: (){

                              Get.to(Manage_Todo_Items(

                                'dfdfdfdf',
                                'tttttttttttt',
                                1

                              ));
                            },
                            child: Container(

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Container(
                                    width: size.width * 0.7,
                                    height: size.height * 0.1,
                                    //color: Colors.green,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text('Frist Title',
                                              style: TextStyle(
                                                fontSize: size.height * 0.03,
                                                fontWeight: FontWeight.w600
                                              ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text('Second Titlessdddddddddsssssssssssssssssss',
                                                style: TextStyle(
                                                    fontSize: size.height * 0.02,
                                                    fontWeight: FontWeight.w400
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                  CornerBanner(
                                    bannerPosition: CornerBannerPosition.topRight,
                                    bannerColor: (false) ? Colors.redAccent : Color(0xFF00A669),
                                    elevation: 5,
                                    child: Center(
                                      child: Text('Complete',
                                        style: TextStyle(
                                            color: Colors.white
                                        ),),
                                    ),
                                  ),

                                ],
                              ),



                              // child: ListTile(
                              //   title: Text('sssas'),
                              //   subtitle: Text('ttt'),
                              //   trailing: CornerBanner(
                              //     bannerPosition: CornerBannerPosition.topRight,
                              //     bannerColor: (true) ? Colors.redAccent : Colors.blueAccent,
                              //     elevation: 5,
                              //     child: Text('incomplete',
                              //       style: TextStyle(
                              //           color: Colors.white
                              //       ),),
                              //   ),
                              //   // Add any additional widgets or customization here
                              // ),




                            ),
                          ),
                        );
                      },
                    ),
                  )
                  :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(height: size.height * 0.1,),

                      Center(
                          child: Image.asset('assets/images/empty-box.png',
                        height: size.height* 0.3,
                      )),

                      SizedBox(height: size.height * 0.05,),

                      Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Text('You have not created any todo yet!',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.height * 0.02
                            ),),

                        ),
                      ),


                    ],
                  ),



                ],
              ),
            ),
          ),
        )

    );
  }

  void goto_login_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_Login_Status(false);
    Get.offAll(const Login_Page());
  }


  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Todo'),
          content: get_content(),
          actions: <Widget>[

            TextButton(
              onPressed: () {
                // Close the dialog
                print('No Clicked!!');
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),

            TextButton(
              onPressed: () {
                // Close the dialog and perform the action

                print('Yes Clicked!!');
                Navigator.of(context).pop();

              },
              child: Text('Yes'),
            ),

          ],
        );
      },
    );
  }


  void get_schedule() {

    _database.child('Schedule/${area}/${Common_Methods().get_current_day()}/').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(Common_Methods().get_uid());
      if(data != null) {
        setState(() {
          is_loaded = false;
          schedule = data.toString();
        });
        print(data.toString());
      }
      else {
        print('else:   ');
        print(data.toString());
      }

    });
  }

  Widget get_content() {

    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.4,
      width: size.width * 1,
      child: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: size.width * 0.8,
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: "Enter Title of Todo",
                  prefixIcon: Icon(Icons.add_box_sharp, color: Color(0xFF00A669),),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00A669)), // Border color when focused
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height * 0.02,
            ),

            Container(
              width: size.width * 0.8,
              height: size.height * 0.27,
              //color: Colors.green,
              child: Expanded(
                child: TextField(
                  maxLines: 6,
                  controller: description,
                  decoration: const InputDecoration(hintText: "Enter The Description",
                    //prefixIcon: Icon(Icons.description, color: Color(0xFF00A669),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF00A669)), // Border color when focused
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }

}
