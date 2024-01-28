

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../utils/shared_preference.dart';
import 'login_page.dart';

class OnBoarding_Page extends StatefulWidget {
  const OnBoarding_Page({super.key});

  @override
  State<OnBoarding_Page> createState() => _OnBoarding_PageState();
}

class _OnBoarding_PageState extends State<OnBoarding_Page> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: '\nWelcome\n to Caretutors ToDo',
            body:
            'We are here to make your things done correctly.',
            image: build_image('assets/images/check.png'),
            decoration: get_decoration1(),
          ),
          PageViewModel(
            title: 'Never Forget Anything',
            body: 'We are here to take care of your memory.',
            image: build_image('assets/images/false-memory.png'),
            decoration: get_decoration(),
          ),
          PageViewModel(
            title: 'Get All Done In Time',
            body:
            'With Caretutors Todo, you will be 1 step ahead.',
            image: build_image('assets/images/key-to-success.png'),
            decoration: get_decoration(),
          ),
        ],

        next: Icon(Icons.arrow_forward_rounded, color: Color(0xFF00A669),),
        done: Text(
          'Go',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF00A669),
          ),
        ),

        onDone: () {
          goto_login_page(context);
        },

        showSkipButton: true,
        skip: Text('Skip',
          style: TextStyle(
              color: Color(0xFF00A669)
          ),),
        dotsDecorator: get_decorator(),
        onChange: (index) => print('Page $index Selected!'),
        //globalBackgroundColor: Theme.of(context).primaryColor,
        skipOrBackFlex: 0,
        nextFlex: 0,
      ),
    );
  }

  Widget build_image(String s) {
    return Center(child: Image.asset(s));
  }

  PageDecoration get_decoration() {
    return PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
      bodyTextStyle: TextStyle(
        fontSize: 20,
      ),
      bodyPadding: EdgeInsets.all(10.0).copyWith(bottom: 0),
      imagePadding: EdgeInsets.only(top: 50, left: 50, right: 50),
      pageColor: Colors.white,
      //contentMargin: EdgeInsets.only(top: 30),
      imageFlex: 2,
    );
  }

  PageDecoration get_decoration1() {
    return PageDecoration(
      titleTextStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        wordSpacing: 5,
        letterSpacing: 3,
      ),
      bodyTextStyle: const TextStyle(
        fontSize: 20,
      ),
      bodyPadding: const EdgeInsets.all(10.0).copyWith(bottom: 0),
      imagePadding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      pageColor: Colors.white,
      //contentMargin: EdgeInsets.only(top: 30),
      imageFlex: 1,
    );
  }

  void goto_login_page(BuildContext context) async {
    await Shared_Prefference_Class.init();
    await Shared_Prefference_Class.set_OnBoarding_Status(true);
    Get.offAll(const Login_Page());
  }

  DotsDecorator get_decorator() {
    return DotsDecorator(
      color: Color(0xFFBDBDBD),
      activeColor: Color(0xFF00A669),
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

}
