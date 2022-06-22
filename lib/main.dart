import 'package:flutter/material.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/pages/authentication/login_page.dart';
import 'package:quizlen/pages/authentication/signup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.mainPurple,

        body: const SignupPage(),
      ),
    );
  }
}
