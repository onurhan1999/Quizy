import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/components/decoration.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/authentication_pages/reset_password_screen.dart';
import 'package:quizlen/pages/authentication_pages/signup_page.dart';
import 'package:quizlen/pages/main_pages/main_bottombar_screen.dart';
import 'package:quizlen/services/AuthenticationService.dart';

import '../../firebase_options.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return MainBottomBarScreen();
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                decoration: DecorationProperties.backgroundDecoration,
                child: Padding(
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
          flex: 50,
          child: Image.asset("assets/images/logo.png"),
        ),
        Expanded(
          flex: 20,
          child: Text(
            "QUIZY",
            style: GoogleFonts.bayon(color: Color(0xff595CFF), fontSize: 48),
          ),
        ),
        const Spacer(
          flex: 15,
        ),
        EmailTextField(),
        const Spacer(
          flex: 5,
        ),
        PasswordTextField(),
        const Spacer(
          flex: 2,
        ),
        ForgotPasswordButton(),
        const Spacer(
          flex: 5,
        ),
        SigninButton(),
        const Spacer(
          flex: 5,
        ),
        DividerWidget(),
        DontHaveAnAccount(context),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }

  Flexible DontHaveAnAccount(BuildContext context) {
    return Flexible(
      flex: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hesabınız yok mu?",
            style: GoogleFonts.inter(color: Colors.white, fontSize: 22),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pushReplacement(PageTransition(
                  child: SignupPage(),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400)));
            },
            child: Text(
              "Kaydolun",
              style: GoogleFonts.inter(
                  color: Color(0xff595CFF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Divider DividerWidget() {
    return Divider(
      height: 30,
      thickness: 1,
      color: Color(0xff595CFF),
    );
  }

  Flexible SigninButton() {
    return Flexible(
      flex: 20,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Color(0xff595CFF)),
        child: MaterialButton(
          onPressed: () async {
            final email = _email.text.trim();
            final password = _password.text.trim();
            _authService.Login(email, password);

            if (await FirebaseAuth.instance.currentUser != null) {
              print("current içi");
              Navigator.of(context).push(PageTransition(
                  child: MainBottomBarScreen(),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 400)));
            } else {
              null;
            }
          },
          child: const Text(
            "Giriş Yap",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Flexible ForgotPasswordButton() {
    return Flexible(
      flex: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {

                Navigator.of(context).pushReplacement(PageTransition(
                    child: ResetPassword(),
                    type: PageTransitionType.rightToLeftWithFade,
                    duration: Duration(milliseconds: 400),
                    reverseDuration: Duration(milliseconds: 400)));


              },
              child: Text(
                "Şifrenizi mi unuttunuz?",
                style: TextStyle(color: Color(0xff595CFF)),
              ))
        ],
      ),
    );
  }

  Flexible PasswordTextField() {
    return Flexible(
      flex: 15,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffE8E8E8),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: TextFormField(
          controller: _password,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: "Şifre giriniz",
            prefixIcon: Icon(Icons.lock),
            suffixIcon: Icon(Icons.remove_red_eye),
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
