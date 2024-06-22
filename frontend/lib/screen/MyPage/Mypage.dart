import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:frontend/screen/MyPage/ChangeAddress.dart';
import 'package:frontend/screen/MyPage/ChangeBodyInfo.dart';
import 'package:frontend/screen/MyPage/ChangePhoneNum.dart';
import 'package:frontend/screen/MyPage/ChangeGuardianPhoneNum.dart';

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  late String userName = '';
  late String userPhone = '';
  late String userBirth = '';
  late String userGender = '';
  late String guardPhone = '';
  late String height = '';
  late String weight = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
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
          setState(() {
            userName = userData['userName']?.toString() ?? '';
            userPhone = userData['userPhone']?.toString() ?? '';
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
            userBirth = userData['userBirth']?.toString() ?? '미정';
            userGender = userData['userGender']?.toString() ?? '미정';
            guardPhone = userData['guardPhone']?.toString() ?? '미정';
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('마이페이지'),
        ),
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
                    '* 변경 버튼이 없는 정보는 바꿀 수 없습니다.',
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
                        buildInfoRow('성명', userName),
                        buildInfoRow('생년월일', userBirth),
                        buildInfoRow('알고 있는 지병', '당뇨, 고혈압', hasButton: true,
                            onPressed: () {
                          /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangeChronicIll()),
                              );*/
                        }),
                        buildInfoRow(
                          '거주지',
                          '서울특별시 노원구\n 라이프신동아파트 116동 901호',
                          hasButton: true,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeAddress()),
                            );
                          },
                          textStyle: TextStyle(
                            fontSize: 13, // 원하는 크기로 조정
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        buildInfoRow('신체 정보',
                            '${height.isNotEmpty ? '$height cm' : '미정'} ${weight.isNotEmpty ? '/ $weight kg' : '/ 미정'}',
                            hasButton: true, onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeBodyInfo()),
                          );
                        }),
                        buildInfoRow('성별', userGender),
                        buildInfoRow('전화번호', userPhone, hasButton: true,
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePhoneNum()),
                          );
                        }),
                        buildInfoRow('보호자 전화번호', guardPhone, hasButton: true,
                            onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeGuardianPhoneNum()),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(36.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value,
      {bool hasButton = false, VoidCallback? onPressed, TextStyle? textStyle}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: textStyle ??
                      TextStyle(
                        // 기존 스타일에 textStyle을 적용하거나 기본 스타일 사용
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (hasButton)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFEB2B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 1,
                    ),
                    onPressed: onPressed,
                    child: Container(
                      width: 68,
                      height: 24,
                      child: Center(
                        child: Text(
                          '변경',
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
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
