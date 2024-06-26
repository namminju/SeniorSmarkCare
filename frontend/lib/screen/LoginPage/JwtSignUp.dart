import 'package:flutter/material.dart';
import 'package:frontend/widgets/CloseDialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/widgets/NoticeDialog.dart';
import 'package:frontend/screen/LoginPage/SignUpSuccess.dart';
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:logging/logging.dart';
import 'package:frontend/widget/AppBar.dart';

class JwtSignUp extends StatefulWidget {
  const JwtSignUp({super.key});

  @override
  _JwtSignUpState createState() => _JwtSignUpState();
}

class _JwtSignUpState extends State<JwtSignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  final bool _showPhoneVerification = false;
  bool _isPhoneVerified = false;

  final Logger _logger = Logger('_JwtSignUpState');

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CloseDialog(
          text: '전화번호 변경이\n완료되었습니다.',
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CloseDialog(
          text: '회원가입에 실패하였습니다. 다시 시도해주세요.',
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
      _logger.info("Sending data to URL: $url");
      _logger.info("Body: $body");
      var response = await http.post(url, body: body, headers: headers);

      if (response.statusCode == 201) {
        _logger.info('회원가입 성공: ${response.body}');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignUpSuccess(userName: userName)),
        );
        // 필요한 추가 처리나 페이지 이동 등을 수행
      } else {
        _logger.warning('회원가입 실패: ${response.statusCode}');
        _showErrorDialog();
        // 실패 처리에 대한 다이얼로그 표시 등을 수행
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.03),
                ),
                const Text(
                  '회원가입',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
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
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF0F0F0),
                                  hintText: '성명',
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: userPhoneController, // 컨트롤러 할당
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF0F0F0),
                                  hintText: '전화번호',
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: _isPhoneVerified,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isPhoneVerified = value ?? false;
                                        });
                                      },
                                      activeColor: const Color.fromARGB(
                                          255, 254, 178, 178),
                                    ),

                                    const Text(
                                      '사용자의 전화번호가 맞나요?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(

                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        if (_isPhoneVerified) ...[
                          Padding(
                            padding: const EdgeInsets.all(2.0),

                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  controller: passwordController1,

                                  decoration: const InputDecoration(

                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF0F0F0),
                                    hintText: '비밀번호 설정',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: const Text(
                              '8자 이상, 영어와 숫자로 조합된 비밀번호를 설정해주세요.',
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

                                  decoration: const InputDecoration(

                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF0F0F0),
                                    hintText: '비밀번호 확인',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: const Text(
                              '비밀번호 확인을 위해 한 번 더 입력해주세요.',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 80.0),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFEB2B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                            ),
                            onPressed: () {
                              if (_isPhoneVerified) {
                                sendData(
                                  userNameController.text,
                                  userPhoneController.text,
                                  passwordController1.text,
                                  passwordController2.text,
                                );
                              }
                            },
                            child: const SizedBox(
                              width: 320,
                              height: 52,
                              child: Center(
                                child: Text(
                                  '계속하기',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 60.0),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 150.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
