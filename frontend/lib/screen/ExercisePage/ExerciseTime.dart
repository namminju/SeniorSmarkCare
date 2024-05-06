import 'package:flutter/material.dart';

class ExerciseTime extends StatefulWidget {
  @override
  _ExerciseTime createState() => _ExerciseTime();
}

class _ExerciseTime extends State<ExerciseTime> {
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size; //반응형으로 구현하기 위함
    //double width = screenSize.width;
    //double height = screenSize.height; //상대 수치를 이용하기 위함

    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        appBar: AppBar(
          title: Text('운동 시간 알림'),
        ),
        body: Column(),
      ),
    );
  }
}
