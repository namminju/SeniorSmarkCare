import 'package:flutter/material.dart';
import 'package:frontend/screen/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '홀로똑똑',
      home: MainScreen(),
    );
  }
}
