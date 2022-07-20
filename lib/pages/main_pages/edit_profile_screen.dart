import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/constants/text_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/authentication_pages/login_page.dart';
import 'package:quizlen/services/AuthenticationService.dart';
import 'package:quizlen/services/UserServices.dart';

import '../../components/decoration.dart';
import '../../components/reusable_widgets.dart';
import '../../constants/color_constants.dart';

void main() => runApp(EditProfileScreen());

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();

  String imgurl =
      "https://firebasestorage.googleapis.com/v0/b/cookcaquiz.appspot.com/o/d%2F0.png?alt=media&token=a8107e6c-9687-4e00-9755-2fa608b1926f";

  void initState() {
    print("init leader");
    // TODO: implement initState
    getList();
    getFavourite();
    super.initState();
  }

  List<Object> userRank = [];

  Future getList() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('Score', descending: true)
        .get();

    setState(() {
      userRank = List.from(data.docs.map((doc) => doc.id));
      print(userRank.indexOf(FirebaseAuth.instance.currentUser!.uid) + 1);
    });
  }

  AuthService _authService = AuthService();
  UserService _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DecorationProperties.editProfileBackgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: FutureBuilder<List<String>>(
            future: _userService.getCurrentUser(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: Colors.purple,
                        strokeWidth: 10,
                      ))
                  : Container(
                      child: Center(
                          child: Column(
                        children: [
                          CircleAvatarWidget(context, snapshot.data![2]),
                          nickNameText(context, snapshot.data![0]),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: context.dynamicHeight(0.03)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff060718).withOpacity(0.8),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: context.dynamicWidth(0.1),
                                      right: context.dynamicWidth(0.1),
                                      top: context.dynamicHeight(0.03)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TabTexts(
                                          context,
                                          snapshot.data![1],
                                          (userRank.indexOf(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid) +
                                                  1)
                                              .toString()),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: context.dynamicHeight(0.05),
                                            bottom: 30),
                                        child: Column(
                                          children: [
                                            ChooseAvatar(context),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ChangePassword(context),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        height: 5,
                                        thickness: 2,
                                        color: Colors.white,
                                      ),
                                      SignOut(context),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                    );
            }),
      ),
    );
  }

  Row SignOut(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Çıkış Yap",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
        IconButton(
            color: Colors.white,
            iconSize: 35,
            onPressed: () {
              _authService.Logout(context);
            },
            icon: Icon(Icons.exit_to_app))
      ],
    );
  }

  InkWell ChangePassword(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Şifre Değiştir",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          )
        ],
      ),
      onTap: () {
        _authService.ResetPasswordOnApp(
                FirebaseAuth.instance.currentUser!.email.toString(),context);
      },
    );
  }

  InkWell ChooseAvatar(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          isScrollControlled: false,
          isDismissible: false,
          enableDrag: false,
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                  color: Color(0XFF0E0F37),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              height: 700,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: FutureBuilder<List<String>>(
                        future: _userService.getAvatars(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? const CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Colors.purple,
                                  strokeWidth: 10,
                                )
                              : GridView.builder(
                                  itemCount: snapshot.data?.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      child: Image.network(
                                          snapshot.data!.elementAt(index)),
                                      onTap: () {
                                        setState(() {
                                          _userService.changeAvatars(
                                              snapshot.data!.elementAt(index));
                                          Navigator.pop(context);
                                        });
                                      },
                                    );
                                  });
                        }),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Avatar Seç",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Row TabTexts(BuildContext context, puan, userRank) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Favori",
              style: TextConstants.favCategoryTextStyle(context),
            ),
            Text(
              "Kategori",
              style: TextConstants.favCategoryTextStyle(context),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Image.network(imgurl),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Toplam",
              style: TextConstants.favCategoryTextStyle(context),
            ),
            Text(
              "Puan",
              style: TextConstants.favCategoryTextStyle(context),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xffF36AFF),
              child: Text(
                puan,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Color(0xff0E0F37)),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Başarı",
              style: TextConstants.favCategoryTextStyle(context),
            ),
            Text(
              "Sırası",
              style: TextConstants.favCategoryTextStyle(context),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xff6E72FD),
              child: Text(
                userRank,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Color(0xff0E0F37)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Text nickNameText(BuildContext context, name) {
    return Text(
      name,
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(color: Color(0xff4EBD2F)),
    );
  }

  Expanded CircleAvatarWidget(BuildContext context, avatar) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: context.dynamicHeight(0.05)),
        child: CircleAvatar(
          backgroundColor: Color(0xffFFCC4D),
          radius: 80,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.network(avatar),
            radius: 45,
          ),
        ),
      ),
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
      backgroundColor: Color(0xff14154F),
      elevation: 0,
      title: Text(
        'Profil',
        style: TextConstants.leaderboardAppBarTextStyle(context),
      ),
    );
  }

  Future getFavourite() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List dataListAsInt = doc['favourite'];
    List favourite = doc['favourite'];
    dataListAsInt.sort((a, b) => b.compareTo(a));
    int fav = favourite.indexOf(dataListAsInt.elementAt(0));
    final storageRef =
        FirebaseStorage.instanceFor(bucket: "gs://cookcaquiz.appspot.com")
            .ref();
    final imageUrl = await storageRef.child("d/${fav}.png").getDownloadURL();
    setState(() {
      print("deneme");
      print(imageUrl.toString());
      print("deneme");
      imgurl = imageUrl.toString();
      print("deneme");
      print(imgurl);
      print("deneme");
    });
  }
}
