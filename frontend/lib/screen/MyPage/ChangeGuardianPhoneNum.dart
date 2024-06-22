import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart'; // Update to correct path
import 'package:frontend/widgets/NoticeDialog.dart'; // Update to correct path
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/Api/RootUrlProvider.dart';

class ChangeGuardianPhoneNum extends StatefulWidget {
  const ChangeGuardianPhoneNum({super.key});

  @override
  _ChangeGuardianPhoneNumState createState() => _ChangeGuardianPhoneNumState();
}

class _ChangeGuardianPhoneNumState extends State<ChangeGuardianPhoneNum> {
  bool _isPhoneVerified = false;
  final TextEditingController _newPhoneNumberController =
      TextEditingController();

  late String guardPhone = '';

  @override
  void initState() {
    super.initState();
    fetchGuardPhone(); // Fetch initial user data on widget initialization
  }

  Future<void> fetchGuardPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/addinfo/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            guardPhone = userData['guardPhone']?.toString() ?? '미정';
          });
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

  Future<void> changeGuardPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String newPhoneNumber = _newPhoneNumberController.text;

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token",
        "Content-Type": "application/json"
      };

      try {
        var response = await http.put(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/addinfo/'),
          headers: headers,
          body: jsonEncode({
            'guardPhone': newPhoneNumber,
          }),
        );

        if (response.statusCode == 200) {
          // Successful update
          _showConfirmationDialog();
          fetchGuardPhone(); // Fetch updated user data after successful update
        } else {
          // Handle error scenario
          _showErrorDialog();
          print('Failed to update guardPhone: ${response.statusCode}');
        }
      } catch (e) {
        // Exception occurred during API call
        print('Error: $e');
        _showErrorDialog();
      }
    } else {
      print('Token not found');
      // Handle case where token is not available
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoticeDialog(
          text: '전화번호 변경이\n완료되었습니다.',
        );
      },
    );
    print(guardPhone);
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoticeDialog(
          text: '전화번호 변경이 실패하였습니다. 다시 시도해주세요.',
        );
      },
    );
    print(guardPhone);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(), // Replace with your custom app bar widget
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
                    '[보호자 전화번호 변경]',
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
                            '현재 보호자 전화번호',
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
                            guardPhone,
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
                            '보호자 확인 및 전화번호 변경',
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
                                      '변경하려는 번호가 보호자의 전화번호가 맞나요? ',
                                      style: TextStyle(
                                        fontSize: 13,
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
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextField(
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
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 254, 178, 178),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () {
                            changeGuardPhoneNumber();
                          },
                          child: const SizedBox(
                            width: 320,
                            height: 52,
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
