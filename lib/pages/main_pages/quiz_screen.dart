import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/main_pages/after_game_screen.dart';
import 'package:quizlen/services/QuizService.dart';
import 'package:quizlen/services/UserServices.dart';

import '../../constants/text_constants.dart';

void main() => runApp(QuizScreen(
      quizId: '',
      quizTitle: '',
    ));

class QuizScreen extends StatefulWidget {
  final String quizTitle;
  final String quizId;
  const QuizScreen({Key? key, required this.quizTitle, required this.quizId})
      : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Color colorControllerA = Colors.white;
  Color colorControllerB = Colors.white;
  Color colorControllerC = Colors.white;
  Color colorControllerD = Colors.white;
  TextEditingController answerTextController = TextEditingController();
  TextEditingController optionController = TextEditingController();
  TextEditingController correctAnswerTextController = TextEditingController();
  TextEditingController optionControllerA = TextEditingController();
  TextEditingController optionControllerB = TextEditingController();
  TextEditingController optionControllerC = TextEditingController();
  TextEditingController optionControllerD = TextEditingController();
  bool continueButtonState = false;
  bool buttonVisibilitiyState = true;
  int score = 0;

  UserService _userService=UserService();

  void correctAnswerControl() {
    if (correctAnswerTextController.text == optionControllerA.text) {
      colorControllerA = Colors.green;
    } else if (correctAnswerTextController.text == optionControllerB.text) {
      colorControllerB = Colors.green;
    } else if (correctAnswerTextController.text == optionControllerC.text) {
      colorControllerC = Colors.green;
    } else if (correctAnswerTextController.text == optionControllerD.text) {
      colorControllerD = Colors.green;
    }
  }

  void answerControl(String answer) {
    //firebasede bir answer olucak şıktaki texti buraya yollayıp kontrol sağlanması gerekiyor

    //if içerisindeki tırnaklı yere firebaseden gelecek cevap fieldını koymak gerek
    if (correctAnswerTextController.text == answer) {
      switch (optionController.text) {
        case "A":
          {
            setState(() {
              colorControllerA = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;

        case "B":
          {
            setState(() {
              colorControllerB = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;

        case "C":
          {
            setState(() {
              colorControllerC = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;
        case "D":
          {
            setState(() {
              colorControllerD = Colors.green;
              score += 10;
              print("skor=" + score.toString());
            });
          }
          break;
        default:
          {}
          break;
      }
    } else {
      switch (optionController.text) {
        case "A":
          {
            setState(() {
              colorControllerA = Colors.red;
            });
          }
          break;

        case "B":
          {
            setState(() {
              colorControllerB = Colors.red;
            });
          }
          break;

        case "C":
          {
            setState(() {
              colorControllerC = Colors.red;
            });
          }
          break;
        case "D":
          {
            setState(() {
              colorControllerD = Colors.red;
            });
          }
          break;
        default:
          {}
          break;
      }
      correctAnswerControl();
    }
    setState(() {});
  }

  QuizService quizService = QuizService();
  int indexs = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ColorConstants.mainPurple, ColorConstants.deepPurple],
        )),
        child: FutureBuilder<QuerySnapshot>(
            future: quizService.getQuestions(widget.quizId),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const CircularProgressIndicator()
                  : Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        title: Text(widget.quizTitle,
                            style: TextConstants.whiteAppBarTextStyle(context)),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            DocumentSnapshot mypost = snapshot.data!.docs[indexs];
                            correctAnswerTextController.text = mypost['answer'];
                            optionControllerA.text = mypost['answers'][0];
                            optionControllerB.text = mypost['answers'][1];
                            optionControllerC.text = mypost['answers'][2];
                            optionControllerD.text = mypost['answers'][3];

                            return Column(
                              children: [
                                Container(
                                  width: context.dynamicWidth(1),
                                  height: context.dynamicHeight(0.3),
                                  color: Colors.grey,
                                  child: Row(
                                    children: [
                                      Text("${mypost['question']}",
                                          style: TextConstants.quizTextStyle)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: context.dynamicHeight(0.06),
                                ),
                                Card(
                                  color: colorControllerA,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      answerTextController.text =
                                          mypost['answers'][0];
                                      optionController.text = "A";

                                      buttonVisibilitiyState
                                          ? setState(() {
                                              continueButtonState = true;
                                              buttonVisibilitiyState = false;
                                            })
                                          : null;
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Text(
                                                "A-)  " +
                                                    "${mypost['answers'][0]}",
                                                style:
                                                    TextConstants.quizTextStyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  elevation: 5,
                                ),
                                Card(
                                  color: colorControllerB,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      answerTextController.text =
                                          mypost['answers'][1];
                                      optionControllerB.text =
                                          mypost['answers'][1];
                                      optionController.text = "B";
                                      buttonVisibilitiyState
                                          ? setState(() {
                                              continueButtonState = true;
                                              buttonVisibilitiyState = false;
                                            })
                                          : null;
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Text(
                                                "B-)  " +
                                                    "${mypost['answers'][1]}",
                                                style:
                                                    TextConstants.quizTextStyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  elevation: 5,
                                ),
                                Card(
                                  color: colorControllerC,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      answerTextController.text =
                                          mypost['answers'][2];
                                      optionControllerC.text =
                                          mypost['answers'][2];
                                      optionController.text = "C";
                                      buttonVisibilitiyState
                                          ? setState(() {
                                              continueButtonState = true;
                                              buttonVisibilitiyState = false;
                                            })
                                          : null;
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Text(
                                                "C-)  " +
                                                    "${mypost['answers'][2]}",
                                                style:
                                                    TextConstants.quizTextStyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  elevation: 5,
                                ),
                                Card(
                                  color: colorControllerD,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      answerTextController.text =
                                          mypost['answers'][3];
                                      optionControllerD.text =
                                          mypost['answers'][3];
                                      optionController.text = "D";
                                      buttonVisibilitiyState
                                          ? setState(() {
                                              continueButtonState = true;
                                              buttonVisibilitiyState = false;
                                            })
                                          : null;
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Text(
                                                "D-)  " +
                                                    "${mypost['answers'][3]}",
                                                style:
                                                    TextConstants.quizTextStyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  elevation: 5,
                                ),
                                const SizedBox(height: 30),
                                continueButtonState
                                    ? Card(
                                        color: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(35.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            continueButtonState = false;
                                            answerControl(
                                                answerTextController.text);

                                            final snackBar = SnackBar(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10))),
                                              elevation: 6,
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              duration:
                                                  const Duration(minutes: 5),
                                              behavior: SnackBarBehavior.fixed,
                                              content:
                                                  Text("${mypost['pop_up']}"),
                                              action: SnackBarAction(
                                                textColor: Colors.amber,
                                                label: 'Tamam',
                                                onPressed: () {
                                                  setState(() {
                                                    /* print("length");
                                  print(snapshot.data!.docs.length);

                                  print("indexs");
                                  print(indexs);*/

                                                    if (indexs <
                                                        snapshot.data!.docs
                                                                .length -
                                                            1) {
                                                      indexs += 1;
                                                    } else {
                                                      print("test bitti");


                                                      _userService.addSolved(widget.quizId);
                                                      _userService.updateScore(score.toString());





                                                     Navigator.of(context).
                                                      push(PageTransition(
                                                          child:
                                                              AfterGameScreen(score: score,),
                                                          type: PageTransitionType
                                                              .rightToLeftWithFade,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  400),
                                                          reverseDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      400))).then((value) => setState(() => {}));



                                                    }


                                                    correctAnswerControl();
                                                    cleanOptionColors();
                                                    buttonVisibilitiyState =
                                                        true;
                                                  });
                                                },
                                              ),
                                            );

                                            // Find the ScaffoldMessenger in the widget tree
                                            // and use it to show a SnackBar.
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          child: SizedBox(
                                            height: 60,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Center(child: Text("DEVAM"))
                                              ],
                                            ),
                                          ),
                                        ),
                                        elevation: 5,
                                      )
                                    : Text(''),
                              ],
                            );
                          },
                        ),
                      ),
                    );
            }),
      ),
    );
  }

  void cleanOptionColors() {
    colorControllerA = Colors.white;
    colorControllerB = Colors.white;
    colorControllerC = Colors.white;
    colorControllerD = Colors.white;
  }
}
