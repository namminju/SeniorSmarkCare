import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';

import 'package:frontend/screen/MealPage/MealTime.dart';
import 'package:frontend/screen/SymtomPage/SymtomHistory.dart';
import 'package:frontend/screen/MedicalPage/MedicalHistory.dart';

import 'package:frontend/screen/ExercisePage/ExercisePage.dart';
import 'package:frontend/screen/MyPage/Mypage.dart';
import 'package:frontend/screen/LoginPage/Login.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBar(
                title: const Text('홀로똑똑'),
                backgroundColor: Colors.transparent,
                leading: Container(), // 앱 바 좌측에 있는 버튼 지우는 효과 -> 뒤로 가기 같은 거
              ),
              Image.asset(
                'images/mainIcon.png',
                width: width * 0.2,
              ),
            ],
          ),
        ),

        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(

                child: Row(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Image.asset(
                  'images/mainPageImg/grandma.png',
                  width: width * 0.1,
                ),
                const Padding(padding: EdgeInsets.all(5)),
                InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mypage()),
                );
              },
                child: const Text(
                  '김박사 님',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                ),
              ],
            )),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // 버튼 스타일 지정
                      minimumSize: const Size(160, 160), // 최소 크기 설정
                      backgroundColor: const Color(0xFFFFCC66), // 배경색 지정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      // SymtomHistory 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SymtomHistory()),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'images/mainPageImg/healthIcon.png',
                          width: width * 0.15,
                        ),
                        const Text(
                          '건강',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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

                    // "운동" 버튼이 눌렸을 때 할 일 추가


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Exercisepage()),
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'images/mainPageImg/exerciseIcon.png',
                        width: width * 0.15,
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
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      // 버튼 스타일 지정
                      minimumSize: const Size(160, 160), // 최소 크기 설정
                      backgroundColor: const Color(0xFFFF9966), // 배경색 지정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      // "식사" 버튼이 눌렸을 때 할 일 추가
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MealRecommend()),
                      );
                    },
                    child: Column(children: [
                      Image.asset(
                        'images/mainPageImg/mealIcon.png',
                        width: width * 0.15,
                      ),
                      const Text(
                        '식사',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),

                      ),
                    ),
                  ]),
                ),
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      // 버튼 스타일 지정

                      minimumSize: const Size(160, 160), // 최소 크기 설정
                      backgroundColor: const Color(0xFFA1DCFF), // 배경색 지정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      // MedicalHistory 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalHistory()),
                      );
                    },
                    child: Column(children: [
                      Image.asset(
                        'images/mainPageImg/medicalIcon.png',
                        width: width * 0.15,
                      ),
                      const Text(
                        '진료',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),

                      ),
                    ),
                  ]),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(20, 20),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Column(
                children: [
                  const Text(
                    '원하는 이름',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
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
                  Column(children: [
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
                  ])
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
