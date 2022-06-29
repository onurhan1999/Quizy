import 'package:flutter/material.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/components/reusable_widgets.dart';
import 'package:quizlen/extension/context_extension.dart';

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
          body: Column(
mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Expanded(child: ReusableWidgets.getImageAsset("logo.png")),
                Container(
                  color: Colors.red,
                  width: context.dynamicWidth(0.8),
                  height: context.dynamicHeight(0.1),
                  child: Text("OYNA"),
                ),
              Spacer()
            ],
          ),
        ),
    );
  }
}
