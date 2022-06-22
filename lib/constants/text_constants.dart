import 'dart:ui';

import 'package:flutter/material.dart';

class TextConstants{
  static TextConstants instance=TextConstants._init();
  TextConstants._init();

  static getButtonTextTheme(BuildContext context){
    return Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white);
  }


}