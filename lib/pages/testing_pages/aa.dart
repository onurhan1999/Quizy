import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizlen/services/QuizService.dart';
import 'package:quizlen/services/UserServices.dart';

import '../../constants/color_constants.dart';


class ManagementProductView extends StatelessWidget {
  String title='';
  
  ManagementProductView({
    Key? key,
    required this.title,
  }) :super(key: key);
  QuizService quizService=QuizService();
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 200) /2;
    final double itemWidth = size.width /3;
    UserService userService = UserService();
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,

      home: StreamBuilder<QuerySnapshot>(
          stream: quizService.getQuizes(title),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const CircularProgressIndicator()
                : Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding:  const EdgeInsets.all(8),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 355,
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mypost = snapshot.data!.docs[index];
                      print(snapshot.data!.docs.length);





                     return Card(
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
                                    title: Text("${mypost['title']}"),
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
                                        onPressed: () {},
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
                    }),
              ),
            );
          }),
    );
  }
}