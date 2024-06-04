import 'package:flutter/material.dart';
import 'screen/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applsication.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '홀로똑똑',
      home: MainScreen(),
    );
  }
}
