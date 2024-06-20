import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/widgets/NoticeDialog.dart';
import 'package:frontend/screen/LoginPage/SignUpSuccess.dart';
import 'package:frontend/Api/RootUrlProvider.dart';

class JwtSignUp extends StatefulWidget {
  @override
  _JwtSignUpState createState() => _JwtSignUpState();
}

class _JwtSignUpState extends State<JwtSignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  bool _showPhoneVerification = false;
  bool _isPhoneVerified = false;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoticeDialog(
          text: '전화번호 변경이\n완료되었습니다.',
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoticeDialog(
          text: '회원가입이 실패하였습니다. 다시 시도해주세요.',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    var url = Uri.parse('${RootUrlProvider.baseURL}/accounts/signup/');

    Future<void> sendData(String userName, String userPhone, String password1,
        String password2) async {
      var body = json.encode({
        'userName': userName,
        'userPhone': userPhone,
        'password1': password1,
        'password2': password2,
      });

      var headers = {
        'Content-Type': 'application/json',
      };
      print("Sending data to URL: $url");
      print("Body: $body");
      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 201) {
        print('회원가입 성공: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignUpSuccess(userName: userName)),
        );
        // 필요한 추가 처리나 페이지 이동 등을 수행
      } else {
        print('회원가입 실패: ${response.statusCode}');
        _showErrorDialog();
        // 실패 처리에 대한 다이얼로그 표시 등을 수행
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.03),
                ),
                Text(
                  '회원가입',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: userNameController, // 컨트롤러 할당
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF0F0F0),
                                  hintText: '성명',
                                ),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 30)),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: userPhoneController, // 컨트롤러 할당
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF0F0F0),
                                  hintText: '전화번호',
                                ),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFEB2B2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 1,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPhoneVerification = true;
                                    });
                                  },
                                  child: Container(
                                    width: 68,
                                    height: 24,
                                    child: Center(
                                      child: Text(
                                        _showPhoneVerification
                                            ? '인증 완료'
                                            : '인증하기',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_showPhoneVerification) ...[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF0F0F0),
                                    hintText: '인증번호 입력',
                                  ),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFEB2B2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 1,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPhoneVerified = true;
                                      });
                                      _showConfirmationDialog();
                                    },
                                    child: Container(
                                      width: 68,
                                      height: 24,
                                      child: Center(
                                        child: Text(
                                          _isPhoneVerified ? '인증 완료' : '인증하기',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (_isPhoneVerified) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  controller: passwordController1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF0F0F0),
                                    hintText: '비밀번호 설정',
                                  ),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: Text(
                              '영어와 숫자로 조합된 비밀번호를 설정해주세요.',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  controller: passwordController2,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF0F0F0),
                                    hintText: '비밀번호 확인',
                                  ),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: Text(
                              '비밀번호 확인을 위해 한 번 더 입력해주세요.',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFEB2B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                            ),
                            onPressed: () {
                              sendData(
                                  userNameController.text,
                                  userPhoneController.text,
                                  passwordController1.text,
                                  passwordController2.text);

                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpSuccess()),
                              );*/
                            },
                            child: Container(
                              width: 320,
                              height: 40,
                              child: Center(
                                child: Text(
                                  '계속하기',
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
                            padding: const EdgeInsets.only(top: 60.0),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
