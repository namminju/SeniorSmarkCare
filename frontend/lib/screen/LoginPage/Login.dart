import 'package:flutter/material.dart';
import 'package:frontend/screen/MainScreen.dart';
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:frontend/screen/LoginPage/JwtSignUp.dart';
import 'package:frontend/widgets/CloseDialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String token = '';
  final Logger _logger = Logger('_LoginState');

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    _logger.info('토큰 저장 완료: $token');
  }

  Future<void> sendData(String userName, String password) async {
    var url = Uri.parse('${RootUrlProvider.baseURL}/accounts/login/');
    var body = json.encode({
      'userName': userName,
      'password': password,
    });

    var headers = {
      'Content-Type': 'application/json',
    };
    _logger.info("Sending data to URL: $url");
    _logger.info("Body: $body");

    try {
      var response = await http.post(url, body: body, headers: headers);
      if (response.statusCode == 201 || response.statusCode == 200) {
        // 로그인 성공 시 토큰 저장
        var responseData = json.decode(response.body);
        var token = responseData['token'];
        await saveToken(token);

        // MainScreen으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        _logger.warning('로그인 실패: ${response.statusCode}');

        setState(() {
          _showErrorDialog();
        });
      }
    } catch (e) {
      _logger.severe('오류 발생: $e');
      // 예외 처리 로직 추가
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CloseDialog(
          text: "로그인에 실패했습니다.\n다시 시도해주세요.", // Change dialog text as needed
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;
    //double width = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/mainIcon.png',
                  width: 220,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    hintText: '아이디',
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,

                  obscureText: true,
                  decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    hintText: '비밀번호',
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20), // 버튼 위에 간격 추가
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEB2B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    sendData(
                      userNameController.text,
                      passwordController.text,
                    );
                  },
                  child: const SizedBox(
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '계정이 없으신가요?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                    ),
                    GestureDetector(
                      onTap: () {
                        // 회원가입하기 기능을 수행하는 로직 추가
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JwtSignUp()),
                        );
                      },
                      child: const Text(
                        '회원가입하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
