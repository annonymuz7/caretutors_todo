
import 'package:caretutors_todo/pages/home.dart';
import 'package:caretutors_todo/utils/common_methods.dart';
import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constants/strings.dart';
import '../pages/login_page.dart';
import '../repository/db_manager.dart';
import '../utils/shared_preference.dart';


class Navbar extends StatelessWidget {

  //GlobalKey<ScaffoldState>? openDrawer;
  Navbar({super.key});

  final DatabaseReference database = FirebaseDatabase(databaseURL: Strings.database_url).reference();

  late  List<Map<String, dynamic>> result;
  var dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;

    return ConvexAppBar(
      height: height * 0.07,
      backgroundColor: Color(0xFF00A669),
      style: TabStyle.react,
      items: const [
        TabItem(icon: Icons.logout, title: 'Logout'),
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.sync, title: 'Sync'),
      ],
      initialActiveIndex: 1,
      onTap: (int i) {
        print('click index=$i');

        if (i == 0) showConfirmationDialog(context);
        //openDrawer!.currentState!.openDrawer();
        else if (i == 1) {
          print(i);
          //Get.offAll(Home());
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Home()),
              ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
          );
        }
        else {
          show_sync_dialog(context);
        }
      },
    );
  }


  Future<void> show_sync_dialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:   Text('Confirmation'),
          content: Text('Sync your data Online!'),
          actions: <Widget>[

            TextButton(
              onPressed: () {
                // Close the dialog
                print('No Clicked!!');
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),

            TextButton(
              onPressed: () async{
                // Close the dialog and perform the action

                print('Yes Clicked!!');
                Navigator.of(context).pop();

                // result = await dbHelper.getData();
                // print(result);
                show_loading_window(context);

                saveUserData_databse().then((value) {
                  Navigator.of(context).pop();
                });



              },
              child: Text('Proceed'),
            ),

          ],
        );
      },
    );
  }

  Future<void> saveUserData_databse() async {
    try {

      result = await dbHelper.getData();
      String p = database.push().key.toString();
      await database.child('ToDo_List').child(Common_Methods().get_uid()).set(result).then((value) {
        print('Data Inserted Succesfully!');
      });
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  Future<void> show_loading_window(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Uploading data'),
          content: Text('You are almost there, please wait.'),
          actions: <Widget>[
            SizedBox(height: 10,),
            Center(
                child: ColorfulCircularProgressIndicator(
                  colors: [Color(0xFF00A669)],
                  strokeWidth: 5,
                  indicatorHeight: 40,
                  indicatorWidth: 40,
                )),
          ],
        );
      },
    );
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and perform the action
                print('Yes Clicked!!');
                Navigator.of(context).pop();
                goto_login_page(context);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog
                print('No Clicked!!');
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }


  void goto_login_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_Login_Status(false);
    Get.offAll(Login_Page());
  }




}


