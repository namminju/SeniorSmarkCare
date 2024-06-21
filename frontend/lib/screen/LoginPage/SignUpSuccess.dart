import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/LoginPage/Login.dart';

class SignUpSuccess extends StatefulWidget {
  final String userName;

  SignUpSuccess({required this.userName});

  @override
  _SignUpSuccessState createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<SignUpSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/mainIcon.png',
                  width: 220,
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    '${widget.userName}님,\n홀로똑똑 회원가입에\n성공하셨습니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 100), // 버튼 위에 간격 추가
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFEB2B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    // 버튼이 클릭되었을 때 처리할 로직 추가
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Container(
                    width: 320,
                    height: 50,
                    child: Center(
                      child: Text(
                        '로그인하러 가기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15), // 추가 간격
              ],
            ),
          ),
        ),
      ),
    );
  }
}
