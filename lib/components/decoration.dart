import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizlen/components/reusable_widgets.dart';

import '../constants/color_constants.dart';

class DecorationProperties{

  static BoxDecoration backgroundDecoration = BoxDecoration(
  image: DecorationImage(
  image: ReusableWidgets.getAssetImage("background.png"),
  fit: BoxFit.fill));

  static BoxDecoration leaderBoardContainerDecoration=const BoxDecoration(
  gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xffFF5ED2), Color(0xff5263FF)],
  ),
  );

  static BoxDecoration quizScreenContainerDecoration= BoxDecoration(
  gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [ColorConstants.mainPurple, ColorConstants.deepPurple],
  ));
}