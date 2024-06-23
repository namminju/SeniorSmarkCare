import 'package:flutter/material.dart';
import 'package:frontend/screen/MealPage/MealTime.dart';
import 'package:frontend/screen/MealPage/MealRecommend.dart';

import 'package:frontend/screen/ExercisePage/ExercisePage.dart';
import 'package:frontend/screen/ExercisePage/ExerciseTime.dart';
import 'package:frontend/screen/StartPage/SetInfo.dart';

import 'package:frontend/widget/AppBar.dart';

import 'package:frontend/screen/MedicalPage/MedicalHistory.dart';
import 'package:frontend/screen/MyPage/Mypage.dart';
import 'package:frontend/screen/LoginPage/Login.dart';
import 'package:frontend/screen/SymptomPage/SymptomHistory.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/Api/RootUrlProvider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String username = '';
  final Logger _logger = Logger('_MainScreenState');

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> header = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      _logger.info('token: $token');
      _logger.info('$header');
      try {
        var response = await http.get(
            Uri.parse('${RootUrlProvider.baseURL}/accounts/mypage/'),
            headers: header);

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          _logger.info('$userData');
          setState(() {
            username = userData['userName']; // 수정: 사용자 이름 업데이트
          });
        } else {
          _logger.severe('Failed to load user data: ${response.statusCode}');
          // 실패 처리 로직 추가
        }
      } catch (e) {
        _logger.severe('Error loading user data: $e');
        // 예외 처리 로직 추가
      }
    } else {
      _logger.warning('Token not found');
      // 토큰 없음 처리 로직 추가
    }
    await prefs.setString('username', username);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Mypage(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'images/mainPageImg/grandma.png',
                        width: width * 0.1,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Mypage(),
                          ),
                        );
                      },
                      child: Text(
                        username.isNotEmpty ? '$username님' : '사용자 이름 없음',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.02),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(160, 160),
                    backgroundColor: const Color(0xFFFFCC66),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SymptomHistory()),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: width * 0.024)),
                      Image.asset(
                        'images/mainPageImg/healthIcon.png',
                        height: width * 0.16,
                      ),
                      const Text(
                        '건강',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(160, 160),
                    backgroundColor: const Color(0xFF8ED973),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    //
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(20),
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: const Color(0XFFF0F0F0),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Center(
                                    child: Text(
                                      '               운동',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('X'),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey[600]),
                              ListTile(
                                title: const Center(
                                  child: Text('운동 시간 설정',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400)),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ExerciseTime()),
                                  );
                                },
                              ),
                              Divider(color: Colors.grey[400]),
                              ListTile(
                                title: const Center(
                                  child: Text('운동 보기',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400)),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Exercisepage()),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }, //
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: width * 0.024)),
                      Image.asset(
                        'images/mainPageImg/exerciseIcon.png',
                        height: width * 0.16,
                      ),
                      const Text(
                        '운동',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(160, 160),
                    backgroundColor: const Color(0xFFFF9966),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    //
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(20),
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: const Color(0XFFF0F0F0),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '               식사',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('X'),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey[600]),
                              ListTile(
                                title: const Center(
                                  child: Text('식사 시간 알림',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400)),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MealTime()),
                                  );
                                },
                              ),
                              Divider(color: Colors.grey[400]),
                              ListTile(
                                title: const Center(
                                  child: Text('식단 추천',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400)),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MealRecommend()),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: width * 0.024)),
                    Image.asset(
                      'images/mainPageImg/mealIcon.png',
                      height: width * 0.16,
                    ),
                    const Text(
                      '식사',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(160, 160),
                    backgroundColor: const Color(0xFFA1DCFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedicalHistory()),
                    );
                  },
                  child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: width * 0.024)),
                    Image.asset(
                      'images/mainPageImg/medicalIcon.png',
                      height: width * 0.16,
                    ),
                    const Text(
                      '진료',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.02),
            ),
            /* */
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(160, 40),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text(
                '로그인 화면으로',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.05),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: width * 0.17,
                        height: width * 0.17,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 170, 170, 170),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Image.asset(
                              'images/mainPageImg/callIcon.png',
                              width: width * 0.08,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '상담전화',
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetInfo()),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * 0.17,
                          height: width * 0.17,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 170, 170, 170),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Image.asset(
                                'images/mainPageImg/qnaIcon.png',
                                width: width * 0.07,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '문의하기',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.02),
            ),
          ],
        ),
      ),
    );
  }
}
