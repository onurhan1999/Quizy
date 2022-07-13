import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/constants/text_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/main_pages/quiz_screen.dart';

import '../../services/UserServices.dart';

void main() => runApp(const CategoriesPage());

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  void initState() {
    categoryController.text = "Tarih";
    super.initState();
  }

  late final String title;
  late final String description;
  bool isSolved = false;

  UserService userService = UserService();

  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Container(
          decoration: BoxDecoration(color: Colors.red),
          child: Container(
            color: Colors.deepPurple,
            height: 50,
            child: Scaffold(
              backgroundColor: Color(0xff14154F),
              appBar: PreferredSize(
                preferredSize: Size(200, 150),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  flexibleSpace: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(categoryController.text,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.white)),
                      Container(
                        color: Color(0xff14154F),
                        height: 71,
                        child: ListView(
                          padding: const EdgeInsets.all(8.0),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    categoryController.text = "Tarih";
                                  });
                                },
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                child: Image.asset("assets/images/tarih.png"),
                              ),
                            ),
                            CircleAvatar(
                              radius: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    categoryController.text = "Doğa";
                                  });
                                },
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                child: Image.asset("assets/images/tarih.png"),
                              ),
                            ),
                            CircleAvatar(
                              radius: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    categoryController.text = "Çevre";
                                  });
                                },
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                child: Image.asset("assets/images/tarih.png"),
                              ),
                            ),
                            CircleAvatar(
                              radius: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                child: Image.asset("assets/images/tarih.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TabBar(


                        tabs: [
                          Container(

                            padding: EdgeInsets.all(8.0),
                            child: Text('Çözülmemiş'),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Çözülmüş'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                decoration: BoxDecoration(color:Colors.blue),
                child: TabBarView(
                  children: [
                    ShowUnsolvedFutureBuilder(),
                    ShowSolvedFutureBuilder()
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  FutureBuilder<QuerySnapshot<Object?>> ShowUnsolvedFutureBuilder() {
    return FutureBuilder<QuerySnapshot>(
        future: userService.showUnSolved(categoryController.text),
        builder: (context, snapshot) {
          isSolved = false;
          print("isSolved=" + isSolved.toString());

          return !snapshot.hasData
              ? Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    strokeWidth: 10,
                  ))
              : Column(children: [
                  //Listview içerisindeki kategoriyle birlikte gelecek oyunlar

                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot mypost = snapshot.data!.docs[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorConstants.mainOrange,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          shadowColor: ColorConstants.mainOrange,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                            ),
                            height: 120,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:
                                          Image.asset("assets/images/logo.png"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${mypost['category']}"),
                                      Text("${mypost['title']}"),
                                    ],
                                  ),
                                  TextButton(
                                    child: Text(
                                      "OYNA  ",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(PageTransition(
                                              child: QuizScreen(
                                                quizTitle: '${mypost['title']}',
                                                quizId: "${mypost['q_id']}",
                                                isSolved: isSolved,
                                                quizCategory:
                                                    "${mypost['category']}",
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              reverseDuration:
                                                  Duration(milliseconds: 400)))
                                          .then((value) => setState(() {}));

                                      print("navigeden sonra");
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          elevation: 8,
                          margin: const EdgeInsets.all(10),
                        );
                      },
                    ),
                  ),
                ]);
        });
  }

  FutureBuilder<QuerySnapshot<Object?>> ShowSolvedFutureBuilder() {
    return FutureBuilder<QuerySnapshot>(
        future: userService.showSolved(categoryController.text),
        builder: (context, snapshot) {
          isSolved = true;
          print("isSolved=" + isSolved.toString());

          return !snapshot.hasData
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    strokeWidth: 10,
                  ))
              : Column(children: [
                  //Listview içerisindeki kategoriyle birlikte gelecek oyunlar

                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot mypost = snapshot.data!.docs[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorConstants.mainOrange,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          shadowColor: ColorConstants.mainOrange,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                            ),
                            height: 120,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child:
                                          Image.asset("assets/images/logo.png"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${mypost['category']}"),
                                      Text("${mypost['title']}"),
                                    ],
                                  ),
                                  TextButton(
                                    child: Text(
                                      "OYNA  ",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacement(PageTransition(
                                              child: QuizScreen(
                                                quizTitle: '${mypost['title']}',
                                                quizId: "${mypost['q_id']}",
                                                isSolved: isSolved,
                                                quizCategory:
                                                    "${mypost['category']}",
                                              ),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              reverseDuration:
                                                  Duration(milliseconds: 400)))
                                          .then((value) => setState(() {}));

                                      print("navigeden sonra");
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          elevation: 8,
                          margin: const EdgeInsets.all(10),
                        );
                      },
                    ),
                  ),
                ]);
        });
  }
}
