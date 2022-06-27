import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlen/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future TestCozuldu(String girilen) async{

    DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    if (quizler.contains(int.parse(girilen)) == false){
      docRef.update(
      {
        'cozulenTestler': FieldValue.arrayUnion([int.parse(girilen)])
      }
      );
    }
    CozulenTestler();
  }

  Future CozulenTestler() async{
    DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    print("a");
    print(quizler.elementAt(1));
    print("a");
    print(quizler);
    for(int i=0;i<20;i++){
      if(quizler.contains(i)==false){
        print(i);
      }
    }
    }
  }



/*
DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    if (quizler.contains(int.parse(girilen)) == true){
      docRef.update(
      {
       'cozulenTestler': FieldValue.arrayRemove([int.parse(girilen)])
      }
      );
    }else{
      docRef.update(
          {
            'cozulenTestler': FieldValue.arrayUnion([int.parse(girilen)])
          }
      );
    }
 */