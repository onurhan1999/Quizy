import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/main_pages/after_game_screen.dart';
import 'package:quizlen/services/QuizService.dart';
import 'package:quizlen/services/UserServices.dart';

import '../../constants/text_constants.dart';

void main() => runApp(QuizScreen(
      quizId: '',
      quizTitle: '',
      isSolved: true,
    ));

class QuizScreen extends StatefulWidget {
  final String quizTitle;
  final String quizId;
  final bool isSolved;

  const QuizScreen({
    Key? key,
    required this.quizTitle,
    required this.quizId,
    required this.isSolved,
  }) : super(key: key);

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

  bool optionColorController =
      true; //şıklara tıklandığında renk değiştirecek fakat devam butonuna bastıktan sonra renk değiştirmeyecek

  int score = 0;

  UserService _userService = UserService();

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

  bool isBigScreen() {
    if (context.contextHeight() > 700) {
      return true;
    } else {
      return false;
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
    print(context.contextHeight());
    print(context.contextWidth());

    return Container(
      decoration: DecorationProperties.quizBackgroundDecoration,
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                        shrinkWrap: false,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mypost = snapshot.data!.docs[indexs];
                          correctAnswerTextController.text = mypost['answer'];
                          optionControllerA.text = mypost['answers'][0];
                          optionControllerB.text = mypost['answers'][1];
                          optionControllerC.text = mypost['answers'][2];
                          optionControllerD.text = mypost['answers'][3];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: context.dynamicWidth(1),
                                  height: context.dynamicHeight(0.35),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    decoration: DecorationProperties
                                        .questionBackgroundDecoration,
                                    child: Padding(
                                      padding: const EdgeInsets.all(40.0),
                                      child: Text("${mypost['question']}",
                                          style: TextConstants.quizTextStyle),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: isBigScreen() ? 10 : 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Card(
                                      color: colorControllerA,
                                      shape:Border(left: BorderSide(color: Colors.red, width: 8)),
                                      child: InkWell(
                                        onTap: () {
                                          optionColorController
                                              ? setState(() {
                                                  cleanOptionColors();

                                                  colorControllerA =
                                                      ColorConstants.mainOrange;
                                                })
                                              : null;

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
                                          height: isBigScreen() ? 50 : 40,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "A-)  " +
                                                        "${mypost['answers'][0]}",
                                                    style: TextConstants
                                                        .quizTextStyle)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: isBigScreen() ? 10 : 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Card(
                                      color: colorControllerB,
                                      shape: Border(left: BorderSide(color: Colors.red, width: 8)),
                                      child: InkWell(
                                        onTap: () {
                                          optionColorController
                                              ? setState(() {
                                                  cleanOptionColors();

                                                  colorControllerB =
                                                      ColorConstants.mainOrange;
                                                })
                                              : null;

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
                                          height: isBigScreen() ? 50 : 40,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "B-)  " +
                                                        "${mypost['answers'][1]}",
                                                    style: TextConstants
                                                        .quizTextStyle)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: isBigScreen() ? 10 : 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Card(
                                      color: colorControllerC,
                                      shape: Border(
                                          left: BorderSide(
                                              color: Colors.red, width: 8)),
                                      child: InkWell(
                                        onTap: () {
                                          optionColorController
                                              ? setState(() {
                                                  print(optionColorController);
                                                  cleanOptionColors();
                                                  colorControllerC =
                                                      ColorConstants.mainOrange;
                                                })
                                              : null;

                                          answerTextController.text =
                                              mypost['answers'][2];
                                          optionControllerC.text =
                                              mypost['answers'][2];
                                          optionController.text = "C";

                                          buttonVisibilitiyState
                                              ? setState(() {
                                                  continueButtonState = true;
                                                  buttonVisibilitiyState =
                                                      false;
                                                })
                                              : null;
                                        },
                                        child: SizedBox(
                                          height: isBigScreen() ? 50 : 40,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "C-)  " +
                                                        "${mypost['answers'][2]}",
                                                    style: TextConstants
                                                        .quizTextStyle)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: isBigScreen() ? 10 : 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Card(
                                      color: colorControllerD,
                                      shape: Border(
                                          left: BorderSide(
                                              color: Colors.red, width: 8)),
                                      child: InkWell(
                                        onTap: () {
                                          optionColorController
                                              ? setState(() {
                                                  cleanOptionColors();

                                                  colorControllerD =
                                                      ColorConstants.mainOrange;
                                                })
                                              : null;

                                          answerTextController.text =
                                              mypost['answers'][3];
                                          optionControllerD.text =
                                              mypost['answers'][3];
                                          optionController.text = "D";
                                          buttonVisibilitiyState
                                              ? setState(() {
                                                  continueButtonState = true;
                                                  buttonVisibilitiyState =
                                                      false;
                                                })
                                              : null;
                                        },
                                        child: SizedBox(
                                          height: isBigScreen() ? 50 : 40,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "D-)  " +
                                                        "${mypost['answers'][3]}",
                                                    style: TextConstants
                                                        .quizTextStyle)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      elevation: 5,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: isBigScreen()
                                        ? context.dynamicHeight(0.055)
                                        : context.dynamicHeight(0.020)),
                                continueButtonState
                                    ? Card(
                                        color: ColorConstants.mainOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            optionColorController = false;

                                            continueButtonState = false;
                                            answerControl(
                                                answerTextController.text);

                                            showModalBottomSheet<void>(
                                              backgroundColor:
                                                  Colors.transparent,
                                              isScrollControlled: false,
                                              isDismissible: false,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: ColorConstants
                                                          .deepPurple,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20))),
                                                  height: 200,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                              "${mypost['pop_up']}"),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 15),
                                                            child: InkWell(
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .lightGreen,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30)),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 200,
                                                                  height: 50,
                                                                  child: Text(
                                                                    'ANLADIM',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline5
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold),
                                                                  )),
                                                              onTap: () {
                                                                setState(() {
                                                                  optionColorController =
                                                                      true;

                                                                  if (indexs <
                                                                      snapshot
                                                                              .data!
                                                                              .docs
                                                                              .length -
                                                                          1) {
                                                                    indexs += 1;
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  } else {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();

                                                                    print(
                                                                        "test bitti");

                                                                    _userService
                                                                        .addSolved(
                                                                            widget.quizId);

                                                                    if (widget
                                                                        .isSolved) {
                                                                      null;
                                                                    } else {
                                                                      _userService
                                                                          .updateScore(
                                                                              score.toString());
                                                                    }

                                                                    Navigator.of(
                                                                            context)
                                                                        .pushReplacement(PageTransition(
                                                                            child: AfterGameScreen(
                                                                              score: score,
                                                                            ),
                                                                            type: PageTransitionType.rightToLeftWithFade,
                                                                            duration: Duration(milliseconds: 400),
                                                                            reverseDuration: Duration(milliseconds: 400)))
                                                                        .then((value) => setState(() => {}));
                                                                  }

                                                                  correctAnswerControl();
                                                                  cleanOptionColors();
                                                                  buttonVisibilitiyState =
                                                                      true;
                                                                });
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 60,
                                            child: Center(child: Text("DEVAM")),
                                          ),
                                        ),
                                        elevation: 5,
                                      )
                                    : Text(''),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
          }),
    );
  }

  void cleanOptionColors() {
    colorControllerA = Colors.white;
    colorControllerB = Colors.white;
    colorControllerC = Colors.white;
    colorControllerD = Colors.white;
  }
}
