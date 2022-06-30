import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizlen/extension/context_extension.dart';

import '../../constants/color_constants.dart';
import '../../services/QuizService.dart';

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
  
  QuizService quizService = QuizService();
  String? quizId;
  QuizScreenMain({this.quizId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorConstants.mainPurple, ColorConstants.deepPurple],
          ))
          ,
      child: FutureBuilder<QuerySnapshot>(
          future: quizService.getQuestions(quizId!),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const CircularProgressIndicator()
                :
            Scaffold(
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
                child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index){
                  DocumentSnapshot mypost = snapshot.data!.docs[0];
                return Column(
                  children: [
                    Container(
                      width: context.dynamicWidth(1),
                      height: context.dynamicHeight(0.3),
                      color: Colors.grey,
                      child: Row(
                        children: [Text("${mypost['question']}")],
                      ),
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
                              children: [Text("${mypost['answers'][0]}")],
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
                              children: [Text("${mypost['answers'][1]}")],
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
                              children: [Text("${mypost['answers'][2]}")],
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
                              children: [Text("${mypost['answers'][3]}")],
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

                            content: const Text(
                                'Yay! A SnackBar!asf\n asfasfasfasfasfasfasfasfasfasfasfasfasfasfasfasfasfasf'),
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
                );
                },
            ),
              ),
            );
          }),
      );
    
  }
}