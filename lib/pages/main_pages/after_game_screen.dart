import 'package:flutter/material.dart';

void main() => runApp(AfterGame());

class AfterGame extends StatefulWidget {
  @override
  State<AfterGame> createState() => _AfterGameState();
}

class _AfterGameState extends State<AfterGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(

        body: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
