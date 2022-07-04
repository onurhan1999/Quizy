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

  late final String title;
  late final String description;
  UserService userService = UserService();

  TextEditingController categoryController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    categoryController.text="Tarih";
    return FutureBuilder<QuerySnapshot>(
        future: userService.showSolved(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ?  Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              child: const CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.purple,
                strokeWidth: 10,
              )
          )
              :  Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("Kategoriler",
                  style: TextConstants.whiteAppBarTextStyle(context)),
            ),
            backgroundColor: Colors.deepPurple,
            body: Container(
              decoration: BoxDecoration(color: ColorConstants.mainPurple),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      color: Colors.deepPurpleAccent,
                      height: 74,
                      child: ListView(
                        padding: const EdgeInsets.all(8.0),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                categoryController.text="Tarih";
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Column(
                                children: [
                                  Image.asset("assets/images/tarih.png"),
                                ],
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                categoryController.text="Doğa";
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoryController.text,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
                    ),
                  ),
                  //Listview içerisindeki kategoriyle birlikte gelecek oyunlar

                  Expanded(

                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {

                        DocumentSnapshot mypost = snapshot.data!.docs[index];
                        print(snapshot.data!.docs.length);

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
                            decoration:  BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                            ),
                            height: 120,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding:  EdgeInsets.all(10),
                                      child: Image.asset("assets/images/logo.png"),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${mypost['category']}"),
                                      Text("TEST ADI"),

                                    ],
                                  ),
                                  TextButton(
                                    child:  Text("OYNA  ",style: Theme.of(context).textTheme.headline5,),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          PageTransition(
                                              child: QuizScreen(
                                                quizTitle: '${mypost['title']}',
                                                quizId: "${mypost['q_id']}",),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              duration: Duration(
                                                  milliseconds: 400),
                                              reverseDuration: Duration(
                                                  milliseconds: 400)));
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

                ],
              ),
            ),
          );
        });
  }
}