import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/components/reusable_widgets.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/pages/authentication_pages/login_page.dart';
import 'package:quizlen/pages/authentication_pages/signup_page.dart';
import 'package:quizlen/pages/main_pages/after_game_screen.dart';
import 'package:quizlen/pages/main_pages/edit_profile_screen.dart';
import 'package:quizlen/pages/main_pages/leaderboard_screen.dart';

import 'package:quizlen/pages/main_pages/quiz_screen.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: ReusableWidgets.getImageAsset("logo.png"),
            nextScreen: LoginPage(),
            splashIconSize: 250,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.leftToRightWithFade,
            backgroundColor: Color(0xff1E2059)));
  }
}

