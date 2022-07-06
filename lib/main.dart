
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizlen/pages/authentication_pages/login_page.dart';
import 'package:quizlen/pages/authentication_pages/signup_page.dart';
import 'package:quizlen/pages/main_pages/after_game_screen.dart';
import 'package:quizlen/pages/main_pages/categories_screen.dart';
import 'package:quizlen/pages/main_pages/edit_profile_screen.dart';
import 'package:quizlen/pages/main_pages/leaderboard_screen.dart';
import 'package:quizlen/pages/main_pages/main_bottombar_screen.dart';
import 'package:quizlen/pages/main_pages/quiz_screen.dart';
import 'package:quizlen/pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
      home: SplashScreen(),

    );
  }
}
