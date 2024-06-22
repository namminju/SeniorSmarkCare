import 'package:flutter/material.dart';

class SetInfo extends StatefulWidget {
  @override
  _SetInfo createState() => _SetInfo();
}

class _SetInfo extends State<SetInfo> {
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size; //반응형으로 구현하기 위함
    //double width = screenSize.width;
    //double height = screenSize.height; //상대 수치를 이용하기 위함

    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        appBar: AppBar(
          title: const Text('개인 정보 초기 설정'),
        ),
        body: const Column(),
      ),
    );
  }
}
