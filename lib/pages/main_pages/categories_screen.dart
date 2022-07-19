import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/components/decoration.dart';
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
  bool listViewColorController = true;

  void initState() {
    categoryController.text = "Kültür";
    categoryColors = Color(0xff5F2F2C);
    super.initState();
  }

  Color kulturColor = Color(0xff5F2F2C);
  Color cevreColor = Color(0xffF0F0F0);
  Color insanColor = Color(0xffF0F0F0);
  Color enerjiColor = Color(0xffF0F0F0);
  Color suColor = Color(0xffF0F0F0);


  int iconListener=0;

  late final String title;
  late final String description;
  bool isSolved = false;

  UserService userService = UserService();

  TextEditingController categoryController = TextEditingController();
  late Color categoryColors;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
                      style: TextConstants.leaderboardAppBarTextStyle(context)),
                  Container(
                    color: Color(0xff14154F),
                    height: 71,
                    child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  categoryController.text = "Kültür";
                                  iconListener=0;
                                  categoryColors=Color(0xff7A4A47);
                                  cleanIconColors();
                                  kulturColor = Color(0xff7A4A47);
                                });
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Icon(
                                FontAwesomeIcons.earthAmericas,
                                size: 50,
                                color: kulturColor,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                iconListener=1;

                                categoryController.text = "Çevre";
                                categoryColors=Color(0xff4CC082);
                                cleanIconColors();
                                cevreColor = Color(0xff4CC082);
                              });
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Icon(
                              FontAwesomeIcons.seedling,
                              size: 50,
                              color: cevreColor,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                iconListener=2;

                                categoryController.text = "İnsan Hakları";
                                categoryColors = Color(0xffFF5454);
                                cleanIconColors();
                                insanColor = Color(0xffFF5454);
                              });
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Icon(
                              FontAwesomeIcons.dove,
                              size: 50,
                              color: insanColor,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                iconListener=3;

                                categoryController.text = "Enerji";
                                categoryColors = Color(0xffFFB14E);

                                cleanIconColors();
                                enerjiColor = Color(0xffFFB14E);
                              });
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Icon(
                              FontAwesomeIcons.boltLightning,
                              size: 50,
                              color: enerjiColor,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                iconListener=4;

                                categoryController.text = "Su";
                                categoryColors = Color(0xff68D0FF);
                                cleanIconColors();
                                suColor = Color(0xff68D0FF);
                              });
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: Icon(
                              FontAwesomeIcons.droplet,
                              size: 50,
                              color: suColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    indicatorColor: Colors.white,
                    tabs: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Çözülmedi',
                          style: TextStyle(letterSpacing: 1),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Text('Çözüldü', style: TextStyle(letterSpacing: 1)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            decoration: DecorationProperties.categoriesBackgroundDecoration,
            child: TabBarView(
              children: [
                ShowUnsolvedFutureBuilder(),
                ShowSolvedFutureBuilder()
              ],
            ),
          ),
        ));
  }


  FutureBuilder<QuerySnapshot<Object?>> ShowUnsolvedFutureBuilder() {
    return FutureBuilder<QuerySnapshot>(
        future: userService.showUnSolved(categoryController.text),
        builder: (context, snapshot) {
          isSolved = false;

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
                        print("deneme" + snapshot.data!.docs.length.toString());

                        return Card(

                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(25.0),
                          ),

                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),

                            decoration: BoxDecoration(
                              color: categoryColors,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            height: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  "${mypost['title']}",
                                  style: GoogleFonts.openSans(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Spacer(
                                  flex: 5,
                                ),
                                IconButton(
                                  iconSize: 60,
                                  icon: Icon(
                                    Icons.play_circle,
                                    size: 60,
                                    color: Colors.white,
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
                                              iconListener:iconListener,
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
                                ),
                                Spacer(),
                              ],
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
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(25.0),
                          ),

                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                              color: categoryColors,

                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            height: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  "${mypost['title']}",
                                  style: GoogleFonts.openSans(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Spacer(
                                  flex: 5,
                                ),
                                IconButton(
                                  iconSize: 60,
                                  icon: Icon(
                                    Icons.play_circle,
                                    size: 60,
                                    color: Colors.white,
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
                                              iconListener: iconListener,
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
                                ),
                                Spacer(),
                              ],
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

  void cleanIconColors() {
    kulturColor = Color(0xffF0F0F0);
    cevreColor = Color(0xffF0F0F0);
    insanColor = Color(0xffF0F0F0);
    enerjiColor = Color(0xffF0F0F0);
    suColor = Color(0xffF0F0F0);
  }
}
