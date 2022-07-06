import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/components/reusable_widgets.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/constants/text_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/services/UserServices.dart';

void main() => runApp(LeaderboardScreen());

class LeaderboardScreen extends StatefulWidget {
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  UserService _userService = UserService();
  List<Object> names = [];
  List<Object> scores = [];
  List<Object> username = [];

  @override
  void initState() {

    // TODO: implement initState
    getList();
    super.initState();


  }

  Future getList() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('Score', descending: true)
        .get();

    setState(() {
      names = List.from(data.docs.map((doc) => doc['UserName']));
      scores = List.from(data.docs.map((doc) => doc['Score']));
      username = List.from(data.docs.map((doc) => doc.id));


    });
  }

  @override
  Widget build(BuildContext context) {



    return FutureBuilder<QuerySnapshot>(
        future: _userService.sortScore(),
        builder: (context, snapshot) {
          /* if (snapshot.connectionState != ConnectionState.done) {
            return
              Container(
                  decoration: DecorationProperties.leaderBoardContainerDecoration,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    strokeWidth: 10,
                  ));

          }*/
          return !snapshot.hasData
              ? Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    strokeWidth: 10,
                  ))
              : Container(
                  decoration:
                      DecorationProperties.leaderBoardContainerDecoration,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: buildAppBar(),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [FirstPlayer(names, scores)],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SecondPlayer(names, scores),
                              ThirdPlayer(names, scores)
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length - 4,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot mypost =
                                      snapshot.data!.docs[index + 3];

                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                              child: Row(
                                                children: [
                                                  Spacer(
                                                    flex: 4,
                                                  ),
                                                  Text(
                                                    "${mypost['UserName']}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "${mypost['Score']}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    '#${(index + 4).toString()}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  ),
                                                  Spacer(
                                                    flex: 2,
                                                  )
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                              width: context.dynamicWidth(0.9),
                                              height: 70,
                                              decoration: BoxDecoration(
                                                color: const Color(0xff000000)
                                                    .withOpacity(0.26),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40)),
                                              )),
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: ReusableWidgets.getImageAsset(
                                                "avatar.png"),
                                            radius: 40,
                                          ),
                                        ],
                                        alignment: Alignment.centerLeft,
                                      )
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                          child: Row(
                                            children:  [
                                              Spacer(
                                                flex: 4,
                                              ),
                                              Text(
                                                names[username.indexOf(FirebaseAuth.instance.currentUser!.uid)].toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                              Spacer(),
                                              Text(
                                                scores[username.indexOf(FirebaseAuth.instance.currentUser!.uid)].toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                              Spacer(),
                                              Text(
                                                '#'+(username.indexOf(FirebaseAuth.instance.currentUser!.uid)+1).toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                              Spacer(
                                                flex: 2,
                                              )
                                            ],
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                          ),
                                          width: context.dynamicWidth(0.9),
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff000000)
                                                .withOpacity(0.26),

                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                          )),
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: ReusableWidgets.getImageAsset(
                                            "avatar.png"),
                                        radius: 40,
                                      ),
                                    ],
                                    alignment: Alignment.centerLeft,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                );
        });
  }
}

FirstPlayer(names, scores) {
  return Expanded(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ReusableWidgets.getImageAsset("avatar.png"),
            radius: 35,
          ),
        ),
        Text(
          names[0].toString(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          scores[0].toString(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    ),
  );
}

Column ThirdPlayer(names, scores) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: ReusableWidgets.getImageAsset("avatar.png"),
          radius: 35,
        ),
      ),
      Text(
        names[2].toString(),
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      Text(
        scores[2].toString(),
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ],
  );
}

Column SecondPlayer(names, scores) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: ReusableWidgets.getImageAsset("avatar.png"),
          radius: 35,
        ),
      ),
      Text(
        names[1].toString(),
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      Text(
        scores[1].toString(),
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ],
  );
}

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const Text(
      '',
    ),
  );
}
