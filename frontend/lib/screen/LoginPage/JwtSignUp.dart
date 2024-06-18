import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart'; // 예시에 맞춰 변경
import 'package:frontend/widgets/NoticeDialog.dart'; // 예시에 맞춰 변경
import 'package:frontend/screen/LoginPage/SignUpSuccess.dart';

class JwtSignUp extends StatefulWidget {
  @override
  _JwtSignUpState createState() => _JwtSignUpState();
}

class _JwtSignUpState extends State<JwtSignUp> {
  bool _showPasswordVerification = false;
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
          text: '전화번호 변경이 실패하였습니다. 다시 시도해주세요.',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(), // CustomAppBar()으로 변경
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
                              elevation: 4, // 그림자 높이 조정
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpSuccess()),
                              );
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
