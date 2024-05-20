import 'package:flutter/material.dart';

class JwtSignUp extends StatefulWidget {
  @override
  _JwtSignUp createState() => _JwtSignUp();
}

class _JwtSignUp extends State<JwtSignUp> {
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size; //반응형으로 구현하기 위함
    //double width = screenSize.width;
    //double height = screenSize.height; //상대 수치를 이용하기 위함

    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
        ),
        body: Column(),
      ),
    );
  }
}
