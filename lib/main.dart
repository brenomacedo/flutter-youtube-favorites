import 'package:flutter/material.dart';
import 'package:youtube_favorites/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube favorites',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

