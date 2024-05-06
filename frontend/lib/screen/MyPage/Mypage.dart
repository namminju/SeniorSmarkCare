import 'package:flutter/material.dart';

class Mypage extends StatefulWidget {
  @override
  _Mypage createState() => _Mypage();
}

class _Mypage extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size; //반응형으로 구현하기 위함
    //double width = screenSize.width;
    //double height = screenSize.height; //상대 수치를 이용하기 위함

    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        appBar: AppBar(
          title: Text('마이페이지'),
        ),
        body: Column(),
      ),
    );
  }
}
