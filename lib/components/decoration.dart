import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizlen/components/reusable_widgets.dart';

import '../constants/color_constants.dart';

class DecorationProperties{

  static BoxDecoration backgroundDecoration = BoxDecoration(
  color: Color(0xff14154F)
  );

  static BoxDecoration quizBackgroundDecoration = BoxDecoration(
      image: DecorationImage(
          image: ReusableWidgets.getAssetImage("quiz_background.png"),
          fit: BoxFit.fill));

  static BoxDecoration editProfileBackgroundDecoration = BoxDecoration(
    color: Colors.transparent,
      image: DecorationImage(
          image: ReusableWidgets.getAssetImage("edit_profile_bg.png"),
          fit: BoxFit.fill));

  static BoxDecoration mainScreenBackgroundDecoration = BoxDecoration(
      color: Colors.transparent,
      image: DecorationImage(
          image: ReusableWidgets.getAssetImage("main_bg.png"),
          fit: BoxFit.fill));


  static BoxDecoration questionBackgroundDecoration = BoxDecoration(
      image: DecorationImage(
          image: ReusableWidgets.getAssetImage("question_background.png"),
          fit: BoxFit.fill));


  static BoxDecoration leaderBoardContainerDecoration=const BoxDecoration(
  color: Color(0xff1E2059),
  );

  static BoxDecoration quizScreenContainerDecoration= BoxDecoration(
  gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [ColorConstants.mainPurple, ColorConstants.deepPurple],
  ));
}