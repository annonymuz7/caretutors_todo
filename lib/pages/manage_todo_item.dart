

import 'package:caretutors_todo/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Manage_Todo_Items extends StatefulWidget {

  String title, description;
  int position_status;


  Manage_Todo_Items(this.title, this.description, this.position_status);

  @override
  State<Manage_Todo_Items> createState() => _Manage_Todo_ItemsState();
}

class _Manage_Todo_ItemsState extends State<Manage_Todo_Items> {

  final _controller01 = ValueNotifier<bool>(false);

  late TextEditingController title;
  late TextEditingController description;

  bool _enabled = false;
  bool _themeDark = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController(text: widget.title);
    description = TextEditingController(text: widget.description);
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

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
          bottomNavigationBar: Navbar(),
          body: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(height: height*0.02,),

                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: height * 0.04,
                        width: width * 0.1,
                        //color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.arrow_back_sharp, size: height * 0.045,),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        width: width*0.8,
                        child: Row(
                          children: [
                            Text("Manage ", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Colors.black),),
                            Text("ToDo", style: TextStyle(fontSize: width*0.8*0.10, fontWeight: FontWeight.bold, color: Color(0xFF00A669),),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: height*0.07,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Center(
                        child: Container(
                          width: width * 0.15,  // Adjust the width to set the size of the round container
                          height: height * 0.06,  // Adjust the height to set the size of the round container
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.brown,  // Set your preferred background color
                          ),
                          child: InkWell(
                            onTap: () {
                              show_edit_dialog(context);
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,  // Set your preferred icon color
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: Container(
                          width: width * 0.15,  // Adjust the width to set the size of the round container
                          height: height * 0.06,  // Adjust the height to set the size of the round container
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,  // Set your preferred background color
                          ),
                          child: InkWell(
                            onTap: () {
                              show_delete_dialog(context);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,  // Set your preferred icon color
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                ),


                Container(
                  height: height * 0.05,
                  width: width * 1,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Center(
                          child: Text('Title :',
                            style: TextStyle(
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.w800
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: height * 0.1,
                  width: width * 1,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Expanded(
                      child: Text(widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: height * 0.03
                      ),),
                    ),
                  ),
                ),

                SizedBox(height: height*0.01,),

                Container(
                  height: height * 0.05,
                  width: width * 1,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Center(
                          child: Text('Description :',
                            style: TextStyle(
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w800
                            ),),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  height: height * 0.35,
                  width: width * 1,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Expanded(
                        child: Text(widget.description,
                          style: TextStyle(
                              fontSize: height * 0.03
                          ),),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height*0.03,),

                Container(
                  height: height * 0.08,
                  width: width * 1,
                  //color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        height: height * 0.08,
                        width: width * 0.4,
                        //color: Colors.white,
                        child: Column(
                          children: [

                            Text('Task Complete ?'),
                            ToggleSwitch(
                              customWidths: [90.0, 50.0],
                              cornerRadius: 20.0,
                              activeBgColors: [[Color(0xFF00A669)], [Colors.redAccent]],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              initialLabelIndex: widget.position_status,
                              labels: ['YES', ''],
                              icons: [null, FontAwesomeIcons.times],
                              onToggle: (index) {
                                print('switched to: $index');
                              },
                            ),

                          ],
                        ),
                      ),

                      Container(
                        height: height * 0.08,
                        width: width * 0.5,
                        decoration: BoxDecoration(
                          color:  Color(0xFF00A669), // Green color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            show_save_dialog(context);
                          },
                          child: Text("Save ToDo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.03,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.02,),

                    ],
                  )
                ),





              ],
            ),
          ),
        ),
    );
  }
  Future<void> show_edit_dialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Todo'),
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


  Future<void> show_delete_dialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and perform the action

                print('Yes Clicked!!');
                Navigator.of(context).pop();

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




  Future<void> show_save_dialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want update?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog and perform the action

                print('Yes Clicked!!');
                Navigator.of(context).pop();

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





}
