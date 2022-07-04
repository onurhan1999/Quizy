import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/constants/text_constants.dart';
import 'package:quizlen/extension/context_extension.dart';

import '../../constants/color_constants.dart';

void main() => runApp(QuizScreenCopy());

class QuizScreenCopy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuizScreenMain(),
    );
  }
}

class QuizScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationProperties.quizScreenContainerDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: context.dynamicWidth(1),
                height: context.dynamicHeight(0.3),
                color: Colors.grey,
                child: Text(" Arjantin bayrağındaki mavi kısım gökyüzünde ki beyaz bulutları temsil eder. Ortadaki güneş ise Arjantin’in bitmeyen enerjisini simgeler",style :TextConstants.quizTextStyle),
              ),
              SizedBox(
                height: context.dynamicHeight(0.06),
              ),
              OptionA(),
              OptionB(),
              OptionC(),
              OptionD(),
              const SizedBox(height: 30),
              ContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Card ContinueButton(BuildContext context) {
    return Card(
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: InkWell(
        onTap: () {
          final snackBar = SnackBar(
            backgroundColor: Colors.deepPurple,
            duration: const Duration(minutes: 5),
            content: const Text(
                'Yay! A SnackBar!asf\n asfasfasfasfasfasfasfaasfasfasdfasdasdddddddddddddddddddddddddasfasfasfasfasfasfasfasfasfasfasf'),
            action: SnackBarAction(
              textColor: Colors.amber,
              label: 'Tamam',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [Center(child: Text("DEVAM",style: TextConstants.quizTextStyle,))],
          ),
        ),
      ),
      elevation: 5,
    );
  }

  Expanded OptionD() {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children:  [Text("D-) DENEME",style: TextConstants.quizTextStyle,)],
              ),
            ),
          ),
        ),
        elevation: 5,
      ),
    );
  }

  Expanded OptionC() {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children:  [Text("C-) DENEME",style: TextConstants.quizTextStyle)],
              ),
            ),
          ),
        ),
        elevation: 5,
      ),
    );
  }

  Expanded OptionB() {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children:  [Text("B-) DENEME",style: TextConstants.quizTextStyle)],
              ),
            ),
          ),
        ),
        elevation: 5,
      ),
    );
  }

  Expanded OptionA() {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children:  [Text("A-) DENEME",style: TextConstants.quizTextStyle)],
              ),
            ),
          ),
        ),
        elevation: 5,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,

      centerTitle: true,
      title:  Text('Tarih Test 1',style: TextConstants.whiteAppBarTextStyle(context),),
    );
  }
}
