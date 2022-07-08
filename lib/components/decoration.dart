import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizlen/components/reusable_widgets.dart';

import '../constants/color_constants.dart';

class DecorationProperties{

  static BoxDecoration backgroundDecoration = BoxDecoration(
  image: DecorationImage(
  image: ReusableWidgets.getAssetImage("background.png"),
  fit: BoxFit.fill));

  static BoxDecoration quizBackgroundDecoration = BoxDecoration(
      image: DecorationImage(
          image: ReusableWidgets.getAssetImage("quiz_background.png"),
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