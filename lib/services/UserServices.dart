import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizlen/models/QuizModel.dart';
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
    print(quizler.elementAt(1));
    print("a");
    print(quizler);
    for(int i=0;i<20;i++){
      if(quizler.contains(i)==true){
        DocumentSnapshot doc1 = await FirebaseFirestore.instance.collection('quizes').doc(i.toString()).get();
        //QuizModel quizModel = QuizModel(aab: doc1['aaa']);
        //print(quizModel.aab);
      }
    }
  }
  Future TestGoster() async{
    DocumentSnapshot doc1 = await FirebaseFirestore.instance.collection('quizes').doc('7').get();
    return doc1;
  }

  Stream<QuerySnapshot> getStatus() {
    var ref = FirebaseFirestore.instance.collection("quizes").snapshots();

    return ref;
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