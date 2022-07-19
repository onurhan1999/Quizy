import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizlen/models/UserModel.dart';
import 'package:quizlen/services/UserServices.dart';

import '../pages/authentication_pages/login_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserService _userService=UserService();

  Future Login(String mail, String pass) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: mail,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          return Fluttertoast.showToast(
            msg: "Şifre hatalı.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );
        case "user-not-found":
          return Fluttertoast.showToast(
            msg: "Böyle bir kullanıcı bulunamadı.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
            // duration
          );
        case "invalid-email":
          return Fluttertoast.showToast(
            msg: "Email adresi hatalı.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );
        default:
          return "Login failed. Please try again.";
      }
    }

    Fluttertoast.showToast(
      msg: "Giriş Başarılı...", // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      // duration
    );




  }

  Future Logout(BuildContext context) async {
    try {
      print("try içi");
      await _auth.signOut();



    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "Bir sorun oldu. Lütfen tekrar deneyin.", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.BOTTOM, // location
        // duration
      );
    }
    Fluttertoast.showToast(
      msg: "Çıkış Başarılı...", // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      // duration
    );
  }

  Future SignUp(String mail, String pass, String username,BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      final docUser = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      final UserModel user = UserModel(username: username, score: 0);
      final json = user.toJson();
      docUser.set(json);

      Navigator.of(context).push(PageTransition(
          child: LoginPage(),
          type: PageTransitionType.rightToLeftWithFade,
          duration: Duration(milliseconds: 400),
          reverseDuration: Duration(milliseconds: 400)));
      Fluttertoast.showToast(msg: "Kayıt başarılı.");


    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return Fluttertoast.showToast(
            msg: "Bu email adresine kayıtlı bir kullanıcı zaten var.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );
        case "invalid-email":
          return Fluttertoast.showToast(
            msg: "Email adresi hatalı.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );
        default:
          return "Login failed. Please try again.";
      }
    }
  }

  Future ResetPassword(String mail,BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
      Fluttertoast.showToast(msg: "Sıfırlama maili gönderildi.");
      Navigator.of(context).push(PageTransition(
          child: LoginPage(),
          type: PageTransitionType.rightToLeftWithFade,
          duration: Duration(milliseconds: 400),
          reverseDuration: Duration(milliseconds: 400)));




      print("email sent");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return Fluttertoast.showToast(
            msg: "Bu email adresine kayıtlı bir kullanıcı yok.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );
        case "invalid-email":
          return Fluttertoast.showToast(
            msg: "Email adresi hatalı.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );
        default:
          return "Login failed. Please try again.";
      }
    }

  }
}
