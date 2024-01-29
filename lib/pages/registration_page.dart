

import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/strings.dart';
import 'login_page.dart';

class Registration_Page extends StatefulWidget {
  const Registration_Page({super.key});

  @override
  State<Registration_Page> createState() => _Registration_PageState();
}

class _Registration_PageState extends State<Registration_Page> {


  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController mobile;
  bool ischecked = false;
  bool is_clicked = true;
  String uid = '';
  String? downloadURL;
  //File? pickedImageFile;
  bool _isPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference database = FirebaseDatabase(databaseURL: Strings.database_url).reference();

  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    mobile = TextEditingController();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    password.dispose();
    mobile.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                SizedBox(height: size.height*0.05,),

                Container(
                  width: size.width*0.8,
                  child: RichText(
                      text: TextSpan(
                        style:  DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Lets make your',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Set the color for "Welcome"
                              fontSize: size.width*0.08,
                              decoration: TextDecoration.none,

                            ),
                          ),
                        ],
                      )
                  ),
                ),

                Container(
                  width: size.width*0.8,
                  child: RichText(
                      text: TextSpan(
                        style:  DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'account  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00A669),  // Set the color for "Welcome"
                              fontSize: size.width*0.08,
                              decoration: TextDecoration.none,
                            ),
                          ),

                        ],
                      )
                  ),
                ),

                SizedBox(height: size.height*0.05,),


                Container(
                  width: size.width * 0.8,

                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: "Name",
                      prefixIcon: Icon(Icons.person, color: Color(0xFF00A669),),
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



                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width * 0.8,

                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: "Email",
                      prefixIcon: Icon(Icons.email, color: Color(0xFF00A669),),
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

                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: password,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(hintText: "Password",
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF00A669),),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
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

                SizedBox(height: size.height*0.03,),

                Container(
                  width: size.width * 0.8,
                  child: TextField(
                    controller: mobile,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: "Mobile Number",
                      prefixIcon: Icon(Icons.phone, color: Color(0xFF00A669),),
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

                SizedBox(height: size.height*0.02,),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    width: size.width*0.9,
                    child: Row(
                      children: [
                        Checkbox(
                          value: ischecked,
                          onChanged: (bool? value) {
                            setState(() {
                              ischecked = value ?? false;
                            });
                          },
                          activeColor: Color(0xFF00A669),
                        ),

                        Text("I agreed with the terms and conditions"),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: size.height*0.02,),

                Container(
                  width: size.width*0.8,
                  decoration: BoxDecoration(
                    color: ischecked ? Color(0xFF00A669) : Colors.black38, // Green color
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                      onPressed: ischecked ? () {

                        showConfirmationDialog(context);

                        setState(() {
                          is_clicked = !is_clicked;
                        });

                        print(name.text);
                        print(email.text);
                        print(password.text);
                        print(mobile.text);

                        create_user(email.text, password.text).then((value) {

                          if (value != null) {
                            print("User created: ${value.uid}");

                            setState(() {
                              uid = value.uid;
                            });

                              saveUserData_databse(uid, name.text, email.text, password.text, mobile.text).then((value) {

                                Navigator.of(context).pop();
                                Get.snackbar('Welcome!', 'User Registered Successfully!!');
                                Get.offAll(const Login_Page());
                                setState(() {
                                  is_clicked = !is_clicked;
                                });

                              }).onError((error, stackTrace) {
                                Navigator.of(context).pop();
                                Get.snackbar('Registered Failed!', 'Please provide accurate information!');
                              });



                          }
                          else {
                            Navigator.of(context).pop();
                            print("Error creating user");
                            setState(() {
                              is_clicked = !is_clicked;
                            });
                          }

                        }).onError((error, stackTrace) {
                          Navigator.of(context).pop();
                          Get.snackbar('Registered Failed!', 'Please provide accurate information!');
                        });


                      } : null,
                      child: Text("Join Us",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width*0.8*0.06
                        ),
                      )
                  ),
                ),
                SizedBox(height: size.height*0.05,),

                Container(
                  width: size.width*0.8,
                  child: Center(child: Text("Already have an account?",
                    style: TextStyle(
                        fontSize: size.height * 0.02
                    ),),),
                ),

                SizedBox(height: size.height*0.02,),

                Container(
                  width: size.width*0.8,
                  child: Center(
                    child: GestureDetector(
                      onTap: (){
                        Get.offAll(Login_Page());
                      },
                      child: Text("Sign in",
                        style: TextStyle(
                            color: Color(0xFF00A669),
                            fontWeight: FontWeight.w700,
                            fontSize: size.height * 0.02
                        ),),
                    ),
                  ),
                ),


                SizedBox(height: size.height*0.03,),

              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<User?> create_user(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user?.updateProfile(displayName: 'User');
      return result.user;
    } catch (e) {
      print("Error creating user: $e");
      return null;
    }
  }


  Future<void> saveUserData_databse(String uid,
      String name,
      String email,
      String password,
      String mobile

      ) async {
    try {
      await database.child('Users').child(uid).set({
        'U_ID': uid,
        'Name': name,
        'Email': email,
        'Password': password,
        'Mobile': mobile,
        // Add more fields as needed
      });
    } catch (e) {
      print("Error saving user data: $e");
    }
  }


  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Registering'),
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


}
