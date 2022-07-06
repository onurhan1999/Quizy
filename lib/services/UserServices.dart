import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addSolved(String girilen) async{

    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    if (quizler.contains(int.parse(girilen)) == false){
      docRef.update(
          {
            'cozulenTestler': FieldValue.arrayUnion([int.parse(girilen)])
          }
      );
    }
  }

  Future updateScore(String girilen) async{

    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    docRef.update(
        {
          'Score': FieldValue.increment(int.parse(girilen))
        }
    );
  }



  Future<QuerySnapshot> showUnSolved() async{

    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    // print("bura"+ quizler.isEmpty.toString());
    if(quizler.isEmpty){
      return await _firestore.collection("quizes").get();
    }else{
      return await _firestore.collection("quizes").where("q_id", whereNotIn: quizler).get();
    }
  }


  Future<QuerySnapshot> showSolved() async{
    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    // print("bura"+ quizler.isEmpty.toString());
    if(quizler.isEmpty){
      // -------------------------------------- BURADA NE DÖNDÜRECEĞİMİZİ SONRA BELİRLERİZ -----------------------------------------------------------
      return await _firestore.collection("quizes").where("q_id", whereIn: [0]).get();
    }else{
      return await _firestore.collection("quizes").where("q_id", whereIn: quizler).get();
    }
  }
  ///////////////////////////// FİREBASETE DESCENDING ORDER OLMADIĞI İÇİN SAYFA İÇERİSİNDE TERS BASTIR  ------------------------------------------
  Future<QuerySnapshot> sortScore() async{
    return await _firestore.collection('users').orderBy('Score',descending: true).limit(6).get();
  }

  Future <List> getTopThree() async {
    List a=[];
    a.add(_firestore.collection('users').orderBy('Score',descending: true).get().toString());
    return a;
  }

  Future<List<String>> getCurrentUser() async{
    List<String> userInfo=[];
    var doc=await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    userInfo.add(doc['UserName'].toString());
    userInfo.add(doc['Score'].toString());
    return userInfo;
  }
}