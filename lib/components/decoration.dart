import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizlen/components/reusable_widgets.dart';

class DecorationProperties{

  static BoxDecoration backgroundDecoration = BoxDecoration(
  image: DecorationImage(
  image: ReusableWidgets.getAssetImage("background.png"),
  fit: BoxFit.fill));




}