import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/components/reusable_widgets.dart';
import 'package:quizlen/constants/text_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/main_pages/categories_screen.dart';

import '../../constants/color_constants.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationProperties.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.dynamicHeight(0.1),
              horizontal: context.dynamicWidth(0.1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              LogoImage(),
              Spacer(
                flex: 8,
              ),
              PlayButton(context),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded PlayButton(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(25),
            color: ColorConstants.mainOrange),
        child: MaterialButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
                child: CategoriesPage(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: Duration(milliseconds: 400),
                reverseDuration: Duration(milliseconds: 400)));
          },
          child:
              Text("OYNA", style: TextConstants.playButtonTextStyles(context)),
        ),
      ),
    );
  }

  Expanded LogoImage() {
    return Expanded(flex: 8, child: ReusableWidgets.getImageAsset("logo.png"));
  }
}
