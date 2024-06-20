import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/MainScreen.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:frontend/screen/LoginPage/JwtSignUp.dart';
import 'package:frontend/screen/LoginPage/FindPasswd.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  // TextEditingController userPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String token = '';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    // String baseUrl = Provider.of<RootUrlProvider>(context).rootUrl;
    String baseUrl = 'http://127.0.0.1:8000';

    Future<void> saveToken(String token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('토큰 저장 완료: $token');
    }

    Future<void> sendData(String userName, String password) async {
      var url = Uri.parse(baseUrl + "/accounts/login/");
      var body = json.encode({
        'userName': userName,
        'password': password,
      });

      var headers = {
        'Content-Type': 'application/json',
      };
      print("Sending data to URL: $url");
      print("Body: $body");

      try {
        var response = await http.post(url, body: body, headers: headers);
        if (response.statusCode == 201) {
          // 로그인 성공 시 토큰 저장
          var responseData = json.decode(response.body);
          var token = responseData['token'];
          await saveToken(token);

          // MainScreen으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        } else {
          print('로그인 실패: ${response.statusCode}');
          // 실패 처리 로직 추가
        }
      } catch (e) {
        print('오류 발생: $e');
        // 예외 처리 로직 추가
      }
    }

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
                TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    hintText: '아이디',
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    hintText: '비밀번호',
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20), // 버튼 위에 간격 추가
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
                    sendData(
                      userNameController.text,
                      passwordController.text,
                    );
                  },
                  child: Container(
                    width: 320,
                    height: 50,
                    child: Center(
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '또는',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 254, 229, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    // 버튼이 클릭되었을 때 처리할 로직 추가
                  },
                  child: Container(
                    width: 320,
                    height: 50,
                    child: Center(
                      child: Text(
                        '카카오 로그인',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '계정이 없으신가요?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    GestureDetector(
                      onTap: () {
                        // 회원가입하기 기능을 수행하는 로직 추가
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JwtSignUp()),
                        );
                      },
                      child: Text(
                        '회원가입하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                GestureDetector(
                  onTap: () {
                    // 비밀번호 찾기 기능을 수행하는 로직 추가
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FindPasswd()),
                    );
                  },
                  child: Text(
                    '비밀번호 찾기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
