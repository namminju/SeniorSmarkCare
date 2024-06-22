import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/widgets/NoticeDialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePhoneNum extends StatefulWidget {
  const ChangePhoneNum({super.key});

  @override
  _ChangePhoneNumState createState() => _ChangePhoneNumState();
}

class _ChangePhoneNumState extends State<ChangePhoneNum> {
  late String userName;
  late String userPhone;
  late String userPw;

  @override
  void initState() {
    super.initState();
    fetchNameNPhone();
  }

  Future<void> fetchNameNPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/mypage/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          if (userData != null) {
            setState(() {
              userName = userData['userName']?.toString() ?? '';
              userPhone = userData['userPhone']?.toString() ?? '';
              userPw = userData['password']?.toString() ?? '';
            });
          }
        } else {
          print('Failed to load user data: ${response.statusCode}');
          // Handle failure
        }
      } catch (e) {
        print('Error loading user data: $e');
        // Handle exceptions
      }
    } else {
      print('Token not found');
      // Handle case where token is not available
    }
  }

// class _ChangePhoneNumState extends State<ChangePhoneNum> {
  bool _showPasswordVerification = false;
  bool _isPasswordVerified = false;
  final bool _showChangePhoneForm = false;
  bool _isPhoneVerified = false; // 추가: 전화번호 인증 여부를 저장할 변수
  final TextEditingController _newPhoneNumberController =
      TextEditingController();

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoticeDialog(
          text: '전화번호 변경이\n완료되었습니다.',
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
        appBar: const CustomAppBar(), // CustomAppBar()으로 변경
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.03),
                ),
                const Text(
                  '마이페이지',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: const Text(
                    '[전화번호 변경]',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
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
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '변경 전 전화번호',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            userPhone,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '비밀번호 본인 확인',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              const TextField(
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
                                ),
                                obscureText: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFEB2B2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 1,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPasswordVerification = true;
                                    });
                                    // 여기서 실제 비밀번호 검증 로직을 추가할 수 있습니다.
                                    // 예를 들어, API 호출 등을 통해 검증할 수 있습니다.
                                    _isPasswordVerified = true; // 임시로 확인 상태로 변경
                                  },
                                  child: SizedBox(
                                    width: 68,
                                    height: 24,
                                    child: Center(
                                      child: Text(
                                        _showPasswordVerification
                                            ? '인증 완료'
                                            : '인증하기',
                                        style: const TextStyle(
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
                        if (_isPasswordVerified) ...[
                          const Padding(padding: EdgeInsets.only(top: 30)),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              '전화번호 변경',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: _newPhoneNumberController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF0F0F0),
                                    hintText: '새 전화번호 입력',
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
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

                                            ///입력 받은 번호를 기존 번호에서 수정해야햄
                                          },
                                          activeColor: const Color.fromARGB(
                                              255, 254, 178, 178)),
                                      const Text(
                                        '본인 번호가 맞나요?',
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
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isPhoneVerified
                                    ? const Color.fromARGB(255, 254, 178, 178)
                                    : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 1,
                              ),
                              onPressed: _isPhoneVerified
                                  ? () {
                                      // 여기서 전화번호 변경 로직을 처리할 수 있습니다.
                                      // 예를 들어, API 호출 등을 통해 저장할 수 있습니다.
                                      _showConfirmationDialog();
                                    }
                                  : null,
                              child: const SizedBox(
                                width: 320,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    '저장하기',
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
