import 'package:cloud_firestore/cloud_firestore.dart';

 getQuizes(String girilen) {

    var ref=FirebaseFirestore.instance.collection('quizes').where("category", isEqualTo: girilen).snapshots();
    ref;
    
    
  }