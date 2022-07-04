import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizlen/constants/color_constants.dart';
import 'package:quizlen/extension/context_extension.dart';
import 'package:quizlen/services/QuizService.dart';

import '../../constants/text_constants.dart';

void main() => runApp(QuizScreen(quizId: '', quizTitle: '',));

class QuizScreen extends StatefulWidget {
  final String quizTitle;
  final String quizId;
  const QuizScreen({Key? key,required this.quizTitle,required this.quizId}) : super(key: key);


  @override
  State<QuizScreen> createState() => _QuizScreenState();
}





class _QuizScreenState extends State<QuizScreen> {
  Color answerController= Colors.white;
  Color wrongController=Colors.white;

  void colorChange(String answer) {

    //firebasede bir answer olucak şıktaki texti buraya yollayıp kontrol sağlanması gerekiyor

    setState(() {
      wrongController=Colors.red;
      answerController=Colors.green;
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });
  }

  QuizService quizService = QuizService();
  int indexs=0;

  @override
  Widget build(BuildContext context) {




    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ColorConstants.mainPurple, ColorConstants.deepPurple],
            )),
        child: FutureBuilder<QuerySnapshot>(
            future: quizService.getQuestions(widget.quizId),
            builder: (context, snapshot) {

              print("quizid");
              print(widget.quizId);

              return !snapshot.hasData
                  ? const CircularProgressIndicator()
                  :
                Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                  centerTitle: true,
                  title:  Text(widget.quizTitle,style:TextConstants.whiteAppBarTextStyle(context)),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index){
                      print("itembuilder içinde index");
                      print(indexs);
                      DocumentSnapshot mypost = snapshot.data!.docs[indexs];
                      print("popup");
                      print(mypost['pop_up']);


                      deneme(){
                        if(mypost['pop_up']=="aaaaaaaaaa"){
                          print("if içinde");

                          return Colors.red;

                        }

                      }

                      return Column(
                        children: [
                          Container(
                            width: context.dynamicWidth(1),
                            height: context.dynamicHeight(0.3),
                            color: Colors.grey,
                            child: Row(
                              children: [Text("${mypost['question']}",style :TextConstants.quizTextStyle)],
                            ),
                          ),
                          SizedBox(
                            height: context.dynamicHeight(0.06),
                          ),
                          Card(
                            color: wrongController,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                print("ontap");

                                colorChange(mypost['answers'][0]);
                              },
                              child: SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Row(
                                    children: [Text("A-)  "+"${mypost['answers'][0]}",style :TextConstants.quizTextStyle)],
                                  ),
                                ),
                              ),
                            ),
                            elevation: 5,
                          ),
                          Card(
                            color: answerController,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Row(
                                    children: [Text("B-)  "+"${mypost['answers'][1]}",style :TextConstants.quizTextStyle)],
                                  ),
                                ),
                              ),
                            ),
                            elevation: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Row(
                                    children: [Text("C-)  "+"${mypost['answers'][2]}",style :TextConstants.quizTextStyle)],
                                  ),
                                ),
                              ),
                            ),
                            elevation: 5,
                          ),
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                deneme();


                              },
                              child: SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Row(
                                    children: [Text("D-)  "+"${mypost['answers'][3]}",style :TextConstants.quizTextStyle)],
                                  ),
                                ),
                              ),
                            ),
                            elevation: 5,
                          ),
                          const SizedBox(height: 30),
                          Card(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  print("length");
                                  print(snapshot.data!.docs.length);

                                  print("indexs");
                                  print(indexs);

                                  if(indexs<snapshot.data!.docs.length-1)
                                    {
                                      indexs+=1;
                                      print(indexs);
                                    }else{
                                    print("test bitti");


                                  }

                                });





                                final snackBar = SnackBar(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                                  elevation: 6,
                                  backgroundColor: Colors.deepPurple,
                                  duration: const Duration(minutes: 5),
                                  behavior: SnackBarBehavior.fixed,
                                  content:  Text(
                                      "${mypost['pop_up']}"),
                                  action: SnackBarAction(
                                    textColor: Colors.amber,
                                    label: 'Tamam',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              },
                              child: SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [Center(child: Text("DEVAM"))],
                                ),
                              ),
                            ),
                            elevation: 5,
                          ),

                        ],
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }



}