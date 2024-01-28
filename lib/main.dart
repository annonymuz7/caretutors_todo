import 'package:caretutors_todo/pages/home.dart';
import 'package:caretutors_todo/pages/login_page.dart';
import 'package:caretutors_todo/pages/onBoarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async{

  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  static bool? is_first_time;
  static bool? is_logged_in;
  static String? Role;

  Future<int?> _loadWidget() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    is_first_time = preferences.getBool('OnBS_Status');
    is_logged_in = preferences.getBool('Login_Status');
    Role = preferences.getString('Role');

    if (is_logged_in == true)
      return 2;
    else if (is_first_time == true)
      return 1;
    else
      return 0;
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Caretutors ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          textSelectionTheme:
          const TextSelectionThemeData(selectionColor: Colors.white)),
      //onGenerateRoute: Router(routerDelegate: null,).generateRoute,
      home: FutureBuilder(
        future: _loadWidget(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == 0) {
              print(snapshot.data.toString() + '----- Null/First Time Loading ------');
              return const OnBoarding_Page();
            }

            else if (snapshot.data == 1) {
              print(snapshot.data.toString() + '------- Not Null/Not Logged In ------');
              return Login_Page();
            }

            else {
              print(snapshot.data.toString() + '------- Not Null/Already Logged In ------');

              //return Home_Page();
              //return Registration_Page();
              return Home();


            }
          }
          return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        },
      ),

    );
  }


}
