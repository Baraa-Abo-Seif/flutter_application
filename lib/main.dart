import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_application_1/homePage.dart';
void main() {
  Gemini.init(apiKey: 'AIzaSyBkeAaLuUE8mkyDSNdNc6ULcVTqjfcx-ro');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
