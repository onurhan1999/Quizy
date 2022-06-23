import 'package:flutter/material.dart';
import 'package:quizlen/extension/context_extension.dart';

import '../../constants/color_constants.dart';

void main() => runApp( QuizScreen());

class QuizScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SnackBar Demo',
      home: Scaffold(

        body:  QuizScreenMain(),
      ),
    );
  }
}

class QuizScreenMain extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorConstants.mainPurple, ColorConstants.deepPurple],
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
          centerTitle: true,
          title: const Text('Tarih Test 1'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: context.dynamicWidth(1),
                height: context.dynamicHeight(0.3),
                color: Colors.grey,
              ),
              SizedBox(
                height: context.dynamicHeight(0.06),
              ),
              Card(
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
                        children: const [Text("A-) DENEME")],
                      ),
                    ),
                  ),
                ),
                elevation: 5,
              ),
              Card(
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
                        children: const [Text("A-) DENEME")],
                      ),
                    ),
                  ),
                ),
                elevation: 5,
              ),
              Card(
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
                        children: const [Text("A-) DENEME")],
                      ),
                    ),
                  ),
                ),
                elevation: 5,
              ),
              Card(
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
                        children: const [Text("D-) DENEME")],
                      ),
                    ),
                  ),
                ),
                elevation: 5,
              ),
              const SizedBox(height: 30),
              Card(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: InkWell(
                  onTap: () {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.deepPurple,
                      duration: const Duration(minutes: 5),

                      content: const Text('Yay! A SnackBar!asf\n asfasfasfasfasfasfasfaasfasfasdfasdasdddddddddddddddddddddddddasfasfasfasfasfasfasfasfasfasfasf'),
                      action: SnackBarAction(
                        textColor: Colors.amber,
                        label: 'Tamam',
                        onPressed: () {
                          // Some code to undo the change.
                        },
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
                      children: const [Center(child: Text("DEVAM"))],
                    ),
                  ),
                ),
                elevation: 5,
              ),

            ],
          ),
        ),
      ),
    );
  }
}