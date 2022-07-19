import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextConstants{
  static TextConstants instance=TextConstants._init();
  TextConstants._init();

  static getButtonTextTheme(BuildContext context){
    return Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white);
  }


  static popupTextTheme(BuildContext context){
    return GoogleFonts.inter(fontSize: 15,color: Color(0xff26CE55),fontWeight: FontWeight.w500);
  }


  static TextStyle quizTextStyle = GoogleFonts.inter().copyWith(fontSize: 18);
  static TextStyle quizTextStyleAnswers = GoogleFonts.inter().copyWith(fontSize: 12);

  static favCategoryTextStyle(BuildContext context){
    return Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xff4EBD2F));
  }

  static greyAppBarTextStyle(BuildContext context){
    return   GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headline4,color: Color(0xff5E5F5E),fontWeight: FontWeight.w600);
  }

  static whiteAppBarTextStyle(BuildContext context){
    return  GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headline4,color: Colors.white,fontWeight: FontWeight.w600);
  }

  static leaderboardAppBarTextStyle(BuildContext context){
    return  GoogleFonts.montserrat(textStyle: Theme.of(context).textTheme.headline4,color: Color(0xff595CFF),fontWeight: FontWeight.w600);
  }


  static leaderboardUserTextStyleGreen(BuildContext context){
    return  GoogleFonts.inter(fontSize: 25,color: Color(0xff4CC082));
  }
  static leaderboardUserTextStyleWhite(BuildContext context){
    return  GoogleFonts.inter(fontSize: 25,color: Color(0xffE8E8E8));
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