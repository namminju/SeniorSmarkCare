import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/widgets/NoticeDialog.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';

class ChangeBodyInfo extends StatefulWidget {
  @override
  _ChangeBodyInfo createState() => _ChangeBodyInfo();
}

class _ChangeBodyInfo extends State<ChangeBodyInfo> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  late String userBirth = '';
  late String userGender = '';
  late String guardPhone = '';
  late String height = '';
  late String weight = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
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
            userBirth = userData['userBirth']?.toString() ?? '0001-01-01';
            userGender = userData['userGender']?.toString() ?? '';
            guardPhone = userData['guardPhone']?.toString() ?? '0100000000';
            height = userData['height']?.toString() ?? '0';
            weight = userData['weight']?.toString() ?? '0';

            // 값이 모두 0이면 미정으로 설정
            if (height == '0' && weight == '0') {
              height = '';
              weight = '';
            } else {
              // 하나만 값이 있는 경우 빈 문자열로 초기화
              if (height != '0' && weight == '0') {
                weight = '';
              } else if (height == '0' && weight != '0') {
                height = '';
              }
            }
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

  Future<void> _sendHospitalCall(String height, String weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      var body = json.encode({
        "userBirth": userBirth,
        "userGender": userGender,
        "guardPhone": guardPhone,
        "height": int.parse(height),
        "weight": int.parse(weight)
      });
      print(headers);
      print(body);
      try {
        var response = await http.patch(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/addinfo/'),
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
          text: '키/몸무게 변경이\n완료되었습니다.',
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoticeDialog(
          text: '키/몸무게 변경이 실패하였습니다.\n 다시 시도해주세요.',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형으로 구현하기 위함
    double width = screenSize.width;


    void showConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NoticeDialog(
            text: '신체 정보 변경이\n 완료되었습니다.', // 매개변수로 텍스트 전달
          );
        },
      );
    }

    // void _showErrorDialog() {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return NoticeDialog(
    //         text: '신체 정보 변경이 실패하였습니다. 다시 시도해주세요.', // 매개변수로 텍스트 전달
    //       );
    //     },
    //   );
    // }

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
                  '마이페이지',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: const Text(
                    '[신체정보 변경]',
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
                            '신장',
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

                                controller: heightController,
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF0F0F0),
                                  labelText: '',
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text(
                                  'cm',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '몸무게',
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
                                controller: weightController,
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF0F0F0),
                                  labelText: '',
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 12.0),
                                child: Text(
                                  'kg',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 120.0),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFEB2B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 4, // 그림자 높이 조정
                          ),

                          onPressed: () {
                            _sendHospitalCall(
                                heightController.text, weightController.text);
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
                        const Padding(
                          padding: EdgeInsets.only(top: 80.0),
                        ),
                      ],
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
