//Author said mmevela
import 'package:flutter/material.dart';
import 'package:hossana/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of Hossana Application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child:Login(),
        )
      )
    );
  }
}
//Author said mmevela
