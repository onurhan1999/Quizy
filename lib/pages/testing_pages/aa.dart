import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizlen/services/UserServices.dart';


class ManagementProductView extends StatelessWidget {
  const ManagementProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
    final double itemWidth = size.width / 2;
    UserService userService = UserService();
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,

      home: StreamBuilder<QuerySnapshot>(
          stream: userService.getStatus(),
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





                      return ElevatedButton(
                        onPressed: () {

                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xA1DCD4D3)),
                            elevation: MaterialStateProperty.all(0)),
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "${mypost['aaa']}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                          /*      subtitle:
                                Text("${mypost['Ürünün Fiyatı:']}"),
                              ),
                              Expanded(
                                  child: Image(
                                    image: NetworkImage(
                                        mypost['Ürün Görsel URL Adresi']),
                                  )*/),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
          }),
    );
  }
}