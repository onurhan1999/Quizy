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
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return Fluttertoast.showToast(
            msg: "E-Mail veya şifre hatalı.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
          );

        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return Fluttertoast.showToast(
            msg: "Böyle bir kullanıcı bulunamadı.", // message
            toastLength: Toast.LENGTH_SHORT, // length
            gravity: ToastGravity.BOTTOM, // location
            // duration
          );
        case "ERROR_INVALID_EMAIL":
          return "Email address is invalid.";
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
      print(e);
    }
  }

  Future SignUp(String mail, String pass, String username) async {
    try {
      _userService.changeAvatars("https://firebasestorage.googleapis.com/v0/b/cookcaquiz.appspot.com/o/1.png?alt=media&token=abcd8ce4-6227-4454-99b2-a3590b95246a");

      await _auth.createUserWithEmailAndPassword(email: mail, password: pass);
      final docUser = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      final UserModel user = UserModel(username: username, score: 0);
      final json = user.toJson();
      docUser.set(json);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future ResetPassword(String mail) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
      print("email sent");
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
