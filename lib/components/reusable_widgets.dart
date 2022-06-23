import 'dart:ui';

import 'package:flutter/material.dart';

class ReusableWidgets{

  static getImageAsset(String imageSrc){
    return Image.asset("assets/images/"+imageSrc);
  }
  static getAssetImage(String imageSrc){
    return AssetImage("assets/images/"+imageSrc);
  }

}