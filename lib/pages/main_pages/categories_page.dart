
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/pages/main_pages/quiz_screen.dart';


void main() => runApp(const CategoriesPage());

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String quizId='';
  String? qId='';
   String title='Geo';
   List<String>? xd=[];
    List<Object> ll=[];
    List<Object> llT=[];
    StreamController<List> _streamController=StreamController();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    
    getList(title);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(

        backgroundColor: Colors.deepPurple,
        body: Padding(
          padding: EdgeInsets.only(top: context.dynamicHeight(0.06)),
          child: Container(

            decoration: BoxDecoration(color: ColorConstants.mainPurple),
            child: Column(
              children: [
                Container(
                  color: Colors.deepPurple,

                  height: 74,
                  child: ListView(

                    padding: const EdgeInsets.all(8.0),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45,
                        child: ElevatedButton(
                          onPressed: () {
                      
                            getList('Climate');
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Column(
                            children: [
                              Image.asset("assets/images/tarih.png"),
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        
                        radius: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            title='Geo';
                            getList(title);
                            
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Image.asset("assets/images/tarih.png"),
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Image.asset("assets/images/tarih.png"),
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        child: ElevatedButton(
                          onPressed: () {
                           
                            
                            
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Image.asset("assets/images/tarih.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$title",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                //Listview içerisindeki kategoriyle birlikte gelecek oyunlar
                
                StreamBuilder<List>(
                  stream: _streamController.stream,
                  builder: (context,snapshot) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:ll.length,
                      itemBuilder: (context,index){
                        
                        return  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    shadowColor: ColorConstants.mainOrange,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                      height: 120,
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("assets/images/logo.png"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                   Expanded(
                                    flex: 5,
                                    child: ListTile(
                                      title: Text(ll[index].toString()),
                                      subtitle: Text(
                                          "Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey Buraya da bir şey"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        
                                        TextButton(
                                          child: const Text("OYNA  "),
                                          onPressed: () {

                                            quizId=llT[index].toString();
                                            print(quizId);
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => QuizScreenMain(quizId:quizId),
                                              ));
                                          },
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            flex: 8,
                          ),
                        ],
                      ),
                    ),
                    elevation: 8,
                    margin: const EdgeInsets.all(10),
              );
                      },);
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
  Future getList(girilen) async{
      var data= await FirebaseFirestore.instance.collection('quizes').where("category", isEqualTo: girilen).get();

      setState(() {
        ll=List.from(data.docs.map((doc) => doc['title']));
        llT=List.from(data.docs.map((doc) => doc.id.toString()));
        _streamController.add(ll);
      });
    }
    Future quesitonsHere(girilen) async{
      DocumentReference docRef = FirebaseFirestore.instance.collection('quizes').doc(girilen);
    QuerySnapshot doc = await docRef.collection('questions').get();
    

      setState(() {
        xd=List.from(doc.docs.map((doc) => doc['question']));
      });
    }


}
