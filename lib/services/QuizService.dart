

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getQuestions(String docid) async{
    return await _firestore.collection('quizes').doc(docid).collection('questions').get();
  }
   getQuizes(String girilen) {

    var ref=FirebaseFirestore.instance.collection('quizes').where("category", isEqualTo: girilen).snapshots();
    ref;
    
    
  }








}