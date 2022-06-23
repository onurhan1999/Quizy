import 'package:flutter/material.dart';

import 'package:quizlen/pages/splash/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SplashScreen(),
      ),
    );
  }
}
