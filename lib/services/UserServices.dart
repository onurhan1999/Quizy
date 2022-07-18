import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future updatefav(String girilen) async{

    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List favs = doc['favourite'];
    favs[int.parse(girilen)]=favs[int.parse(girilen)]+1;
    docRef.update({
      "favourite": favs
    });
  }
  Future updateScore(String girilen) async{

    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    docRef.update(
        {
          'Score': FieldValue.increment(int.parse(girilen))
        }
    );
  }



  Future<QuerySnapshot> showUnSolved(String category) async{

    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    print("bura"+ quizler.length.toString());
    if(quizler.isEmpty){
      return await _firestore.collection("quizes").where("category", isEqualTo: category).get();
    }else{
      return await _firestore.collection("quizes").where("q_id", whereNotIn: quizler).where("category", isEqualTo: category).get();
    }
  }


  Future<QuerySnapshot> showSolved(String category) async{
    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    DocumentSnapshot doc = await docRef.get();
    List quizler = doc['cozulenTestler'];
    // print("bura"+ quizler.isEmpty.toString());
    if(quizler.isEmpty){
      // -------------------------------------- BURADA NE DÖNDÜRECEĞİMİZİ SONRA BELİRLERİZ -----------------------------------------------------------
      return await _firestore.collection("quizes").where("q_id", whereIn: [-1]).where("category", isEqualTo: category).get();
    }else{
      return await _firestore.collection("quizes").where("q_id", whereIn: quizler).where("category", isEqualTo: category).get();
    }
  }
  ///////////////////////////// FİREBASETE DESCENDING ORDER OLMADIĞI İÇİN SAYFA İÇERİSİNDE TERS BASTIR  ------------------------------------------
  Future<QuerySnapshot> sortScore() async{
    return await _firestore.collection('users').orderBy('Score',descending: true).get();
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
    userInfo.add(doc['Avatar'].toString());
    return userInfo;
  }


 /* Future<List<String>> getAvatars() async{


    List<String> avatars=[];

    final storageRef = FirebaseStorage.instanceFor(bucket: "gs://cookcaquiz.appspot.com").ref();
    final listResult = await storageRef.listAll();

      listResult.items.forEach((Reference ref) async {

      await ref.getDownloadURL().then((value) {
        String val = value.toString();


        avatars.add(val);

        print("avatar.length");
        print(avatars.length);


      }
      );

    });
    //await Future.delayed(const Duration(milliseconds: 500));
    print("userservice avatar.length");
    print(avatars.length);
    return avatars;
  }*/

  Future<List<String>> getAvatars() async{


    List<String> avatar=[];

    final storageRef = FirebaseStorage.instanceFor(bucket: "gs://cookcaquiz.appspot.com").ref();
    final listResult = await storageRef.listAll();


    final avatars=Future.wait(listResult.items.map((ref) => ref.getDownloadURL()).toList());


    //await Future.delayed(const Duration(milliseconds: 500));

    return avatars;
  }






  void changeAvatars(url) async {
    DocumentReference docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
    docRef.update(
        {
          'Avatar':url
        }
    );

  }



}