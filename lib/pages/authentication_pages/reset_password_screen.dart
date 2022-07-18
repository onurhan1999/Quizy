import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/authentication_pages/login_page.dart';
import 'package:quizlen/services/AuthenticationService.dart';
import '../../firebase_options.dart';
import '../main_pages/main_bottombar_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late final TextEditingController _email;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null)
            return LoginPage();
          else {
            return Container(
              decoration: DecorationProperties.backgroundDecoration,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(context.dynamicHeight(0.05)),
                  child: ColumnWidget(context),
                ),
              ),
            );
          }
        });
  }

  Column ColumnWidget(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 10,
        ),
        Expanded(
          flex: 30,
          child: Image.asset("assets/images/logo.png"),
        ),
        Expanded(
          flex: 20,
          child: Text(
            "QUIZY",
            style: GoogleFonts.bayon(color: Color(0xff595CFF), fontSize: 48),
          ),
        ),

        EmailTextField(),
        const Spacer(
          flex: 5,
        ),
        ResetPasswordButton(),
        const Spacer(
          flex: 5,
        ),
        const Divider(
          thickness: 1,
          height: 30,
          color: Color(0xff595CFF),
        ),
        DoYouHaveAccountButton(context)
      ],
    );
  }

  Row DoYouHaveAccountButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hesabınız var mı?",
          style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(PageTransition(
                  child: LoginPage(),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400)));
            },
            child: Text(
              "Giriş Yapın",
              style: GoogleFonts.inter(
                  color: Color(0xff595CFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }


  Flexible ResetPasswordButton() {
    return Flexible(
      flex: 15,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Color(0xff595CFF)),
        child: MaterialButton(
          onPressed: () async {

              final email = _email.text.trim();

              _authService.ResetPassword(email);
              Fluttertoast.showToast(msg: "Şifre sıfırlama maili gönderildi.");

              Navigator.of(context).push(PageTransition(
                  child: LoginPage(),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400)));

          },
          child: const Text(
            "Şifre Sıfırla ",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Flexible EmailTextField() {
    return Flexible(
      flex: 15,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffE8E8E8),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: TextFormField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "E-mail giriniz",
              prefixIcon: const Icon(Icons.email)),
        ),
      ),
    );
  }
}
