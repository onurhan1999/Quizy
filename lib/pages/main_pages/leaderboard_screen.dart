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
  List<Object> avatar = [];


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
      avatar=List.from(data.docs.map((doc) => doc['Avatar']));

    });
  }

  @override
  Widget build(BuildContext context) {



    return FutureBuilder<QuerySnapshot>(
        future: _userService.sortScore(),
        builder: (context, snapshot) {

          print("names kaç tane");
          print(names.length);
          print("avatar kaç tane");
          print(avatar.length);


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
                    appBar: buildAppBar(context),
                    body: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [FirstPlayer(names, scores,avatar)],
                                ),
                                Positioned(
                                  top: 100,
                                  left: .0,
                                  right: .0,

                                  child: Row(
                                    children: [
                                      Spacer(),
                                      SecondPlayer(names, scores,avatar),
                                      Spacer(flex: 2,),
                                      ThirdPlayer(names, scores,avatar),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length - 4,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot mypost =
                                    snapshot.data!.docs[index + 3];

                                return Column(
                                  children: [
                                    Container(
                                      width: context.contextWidth(),
                                      height: 68,
                                      color: Color(0xff14154F),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              '#${(index + 4).toString()}',
                                              style: TextConstants
                                                  .leaderboardUserTextStyleGreen(
                                                      context),
                                            ),
                                            Spacer(),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Image.network("${mypost['Avatar']}"),
                                              radius: 25,
                                            ),
                                            Spacer(),
                                            Text("${mypost['UserName']}",
                                                style: TextConstants
                                                    .leaderboardUserTextStyleWhite(
                                                        context)),
                                            Spacer(
                                              flex: 10,
                                            ),
                                            Align(
                                              alignment:
                                                  Alignment.centerRight,
                                              child: Text(
                                                "${mypost['Score']}",
                                                style: TextConstants
                                                    .leaderboardUserTextStyleWhite(
                                                        context),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          Container(
                            width: context.contextWidth(),
                            height: 68,
                            color: Color(0xff14154F),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20),
                              child: Row(
                                children: [
                                  Text(
                                    '#' +
                                        (username.indexOf(FirebaseAuth
                                                    .instance
                                                    .currentUser!
                                                    .uid) +
                                                1)
                                            .toString(),
                                    style: TextConstants
                                        .leaderboardUserTextStyleGreen(
                                            context),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.network(avatar[username.indexOf(FirebaseAuth
                                        .instance.currentUser!.uid)]
                                        .toString(),),
                                    radius: 25,
                                  ),
                                  Spacer(),
                                  Text(
                                      names[username.indexOf(FirebaseAuth
                                              .instance.currentUser!.uid)]
                                          .toString(),
                                      style: GoogleFonts.openSans(color: Color(0xffE8E8E8),fontWeight: FontWeight.w700,fontSize: 20),

                                  ),
                                  Spacer(
                                    flex: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      scores[username.indexOf(FirebaseAuth
                                              .instance.currentUser!.uid)]
                                          .toString(),
                                      style: TextConstants
                                          .leaderboardUserTextStyleWhite(
                                              context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}


Expanded FirstPlayer(names, scores,avatar) {

  return Expanded(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Color(0xffFFCC4D),
                child: Image.network(avatar[0])
              ),
            ),
            Positioned(
                top: .0,
                left: .0,
                right: .0,
                child: Center(
                    child: CircleAvatar(
                        backgroundColor: Color(0xffFFCC4D),
                        radius: 19,
                        child: CircleAvatar(
                          radius: 15,
                          child: Text(
                            "1",
                            style: GoogleFonts.openSans(
                                fontSize: 20,
                                color: Color(0xffF99D26),
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Color(0xffFDE256),
                        ))))
          ],
        ),
        Text(
          names[0].toString(),
          style: GoogleFonts.openSans(
              color: Color(0xffE8E8E8),
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
        Text(
          scores[0].toString(),
          style: GoogleFonts.openSans(color: Color(0xffE8E8E8),fontWeight: FontWeight.w700,fontSize: 20),

        ),
      ],
    ),
  );
}

Column ThirdPlayer(names, scores,avatar) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xff8B5731),
              child: CircleAvatar(
                radius: 33,
                  backgroundColor: Colors.transparent,
                  child: Image.network(avatar[2]))
            ),
          ),
          Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Center(
                  child: CircleAvatar(
                      radius: 19,
                      backgroundColor: Color(0xff8B5731),
                      child: CircleAvatar(
                        radius: 15,
                        child: Text(
                          "3",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Color(0xff8B5731),
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color(0xffBF7540),
                      ))))
        ],
      ),
      Text(
        names[2].toString(),
        style: GoogleFonts.openSans(color: Color(0xffE8E8E8),fontWeight: FontWeight.w700,fontSize: 20),

      ),
      Text(
        scores[2].toString(),
        style: GoogleFonts.openSans(color: Color(0xffE8E8E8),fontWeight: FontWeight.w700,fontSize: 20),

      ),
    ],
  );
}

Column SecondPlayer(names, scores,avatar) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xffCED5E0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                  radius: 33,
                  child: Image.network(avatar[1]))
            ),
          ),
          Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Center(
                  child: CircleAvatar(
                      backgroundColor: Color(0xffCED5E0),
                      radius: 19,
                      child: CircleAvatar(
                        radius: 15,
                        child: Text(
                          "2",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: Color(0xffB3BAC3),
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color(0xffEFF1F4),
                      ))))
        ],
      ),
      Text(
        names[1].toString(),
        style: GoogleFonts.openSans(color: Color(0xffE8E8E8),fontWeight: FontWeight.w700,fontSize: 20),

      ),
      Text(
        scores[1].toString(),
        style: GoogleFonts.openSans(color: Color(0xffE8E8E8),fontWeight: FontWeight.w700,fontSize: 20),

      ),
    ],
  );
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    bottom: PreferredSize(
        child: Container(
          color: Color(0xff595CFF),
          height: 2.0,
        ),
        preferredSize: Size.fromHeight(4.0)),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      'Liderlik',
      style: TextConstants.leaderboardAppBarTextStyle(context),
    ),
  );
}
