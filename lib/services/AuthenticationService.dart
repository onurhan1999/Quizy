import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlen/models/UserModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future Login(String mail, String pass) async {
    await _auth.signInWithEmailAndPassword(
      email: mail,
      password: pass,
    );
  }

  Future Logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }


  Future SignUp(String mail, String pass, String username) async {
    try {
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
