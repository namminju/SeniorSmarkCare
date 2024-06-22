import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/widgets/NoticeDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';
import 'dart:convert';

class ChangeHospitalNum extends StatefulWidget {
  @override
  _ChangeHospitalNumState createState() => _ChangeHospitalNumState();
}

class _ChangeHospitalNumState extends State<ChangeHospitalNum> {
  TextEditingController hospitalCallController = TextEditingController();

  late String hospitalCall = '';

  @override
  void initState() {
    super.initState();
    fetchHospitalCall();
  }

  Future<void> fetchHospitalCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/hospital/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            hospitalCall = userData['hospitalCall']?.toString() ?? '미정';
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

  Future<void> _sendHospitalCall(String hospitalCall) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      var body = json.encode({'hospitalCall': hospitalCall});
      print(headers);
      print(body);

      try {
        var response = await http.patch(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/hospital/'),
          headers: headers,
          body: body,
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          print('send successfully');
          _showConfirmationDialog();
        } else {
          print('Failed ${response.statusCode}');
          _showErrorDialog();
        }
      } catch (e) {
        print('Error: $e');
        _showErrorDialog();
      }
    } else {
      print('Token not found');
    }
  }

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
          text: '전화번호 변경이 실패하였습니다.\n 다시 시도해주세요.',
        );
      },
    );
  }

  bool _isPhoneNumberValid(String phoneNumber) {
    final RegExp phoneExp = RegExp(r'^01[0-9]{8,9}$');
    return phoneExp.hasMatch(phoneNumber);
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
                  '마이페이지',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Text(
                    '[주 병원 전화번호 변경]',
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '변경 전 전화번호',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            '$hospitalCall',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 30)),
                        Padding(padding: const EdgeInsets.only(top: 30)),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '변경하고자 하는 전화번호',
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
                              TextField(
                                controller: hospitalCallController,
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 200.0),
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
                            String phoneNumber = hospitalCallController.text;
                            if (_isPhoneNumberValid(phoneNumber)) {
                              _sendHospitalCall(phoneNumber);
                            } else {
                              _showErrorDialog();
                            }
                          },
                          child: Container(
                            width: 320,
                            height: 40,
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
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
