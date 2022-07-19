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
      avatar = List.from(data.docs.map((doc) => doc['Avatar']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: _userService.sortScore(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Container(
                  color: Color(0xff14154F),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.purple,
                    strokeWidth: 10,
                  ))
              : Container(
                  decoration:
                      DecorationProperties.leaderboardBackgroundDecoration,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: buildAppBar(context),
                    body: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FirstPlayer(names, scores, avatar)
                                  ],
                                ),
                                Positioned(
                                  top: 100,
                                  left: .0,
                                  right: .0,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      SecondPlayer(names, scores, avatar),
                                      Spacer(
                                        flex: 2,
                                      ),
                                      ThirdPlayer(names, scores, avatar),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFBC52C6),
                                        const Color(0xFF595CFF),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(0.0, 1.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              width: context.contextWidth(),
                              height: 68,
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    '#' +
                                        (username.indexOf(FirebaseAuth.instance
                                                    .currentUser!.uid) +
                                                1)
                                            .toString(),
                                    style: TextConstants
                                        .leaderboardUserTextStyleGreen(context),
                                  ),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Color(0xffA6BAFC),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Image.network(
                                        avatar[username.indexOf(FirebaseAuth
                                                .instance.currentUser!.uid)]
                                            .toString(),
                                      ),
                                      radius: 21,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Güncel Skor",
                                    style: GoogleFonts.openSans(
                                        color: Color(0xffE8E8E8),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                  Spacer(
                                    flex: 5,
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
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            flex: 3,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length - 3,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot mypost =
                                    snapshot.data!.docs[index + 3];

                                return Column(
                                  children: [
                                    Container(
                                      width: context.contextWidth(),
                                      height: 68,
                                      color: Color(0xff060718).withOpacity(0.8),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '#${(index + 4).toString()}',
                                                  style: TextConstants
                                                      .leaderboardUserTextStyleGreen(
                                                          context),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                CircleAvatar(
                                                  radius: 27,
                                                  backgroundColor:
                                                      Color(0xffA6BAFC),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Image.network(
                                                        "${mypost['Avatar']}"),
                                                    radius: 21,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text("${mypost['UserName']}",
                                                    style: TextConstants
                                                        .leaderboardUserTextStyleWhite(
                                                            context)),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
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
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}

Expanded FirstPlayer(names, scores, avatar) {
  return Expanded(
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 68,
                backgroundColor: Color(0xffFFE54D),
                child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Color(0xff86A0FA),
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        child: Image.network(avatar[0]))),
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
          style: GoogleFonts.openSans(
              color: Color(0xffE8E8E8),
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
      ],
    ),
  );
}

Column ThirdPlayer(names, scores, avatar) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xff8B5731),
              child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xffF5A6FC),
                  child: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.transparent,
                      child: Image.network(avatar[2]))),
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
        style: GoogleFonts.openSans(
            color: Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
      Text(
        scores[2].toString(),
        style: GoogleFonts.openSans(
            color: Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
    ],
  );
}

Column SecondPlayer(names, scores, avatar) {
  return Column(
    children: [
      Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xffCED5E0),
              child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xff26CE55),
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 33,
                      child: Image.network(avatar[1]))),
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
        style: GoogleFonts.openSans(
            color: Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
      Text(
        scores[1].toString(),
        style: GoogleFonts.openSans(
            color: Color(0xffE8E8E8),
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
    ],
  );
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    bottom: PreferredSize(
        child: Container(
          color: Color(0xff595CFF),
          height: 2.0,
        ),
        preferredSize: Size.fromHeight(4.0)),
    centerTitle: true,
    backgroundColor: Color(0xff14154F),
    elevation: 0,
    title: Text(
      'Liderlik',
      style: TextConstants.leaderboardAppBarTextStyle(context),
    ),
  );
}
