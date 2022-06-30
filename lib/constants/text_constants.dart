import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextConstants{
  static TextConstants instance=TextConstants._init();
  TextConstants._init();

  static getButtonTextTheme(BuildContext context){
    return Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white);
  }


  static TextStyle quizTextStyle = GoogleFonts.fredoka().copyWith(fontSize: 18);
  static favCategoryTextStyle(BuildContext context){
    return Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xff5E5F5E));
  }

  static greyAppBarTextStyle(BuildContext context){
    return   GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headline4,color: Color(0xff5E5F5E),fontWeight: FontWeight.w600);
  }

  static whiteAppBarTextStyle(BuildContext context){
    return  GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headline4,color: Colors.white,fontWeight: FontWeight.w600);
  }


  static playButtonTextStyles(BuildContext context){
    return GoogleFonts.acme(textStyle: Theme.of(context).textTheme.headline2,color: Colors.white).copyWith(color: Colors.white,shadows: [
      Shadow(
          color: Colors.black.withOpacity(0.3),
          offset: const Offset(6, 6),
          blurRadius: 15),
    ],fontWeight: FontWeight.bold);
  }



}