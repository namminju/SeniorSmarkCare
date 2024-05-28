import 'package:flutter/material.dart';
import '../screen/MedicalPage/MedicalHistory.dart'; // medicalhistory.dart 파일을 가져옵니다.
import '../screen/SymtomPage/SymtomHistory.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형으로 구현하기 위함
    double width = screenSize.width;
    double height = screenSize.height; // 상대 수치를 이용하기 위함

    return SafeArea(
      // 안전한 영역의 확보
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBar(
                title: Text('홀로똑똑'),
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
                Padding(padding: EdgeInsets.all(10)),
                Image.asset(
                  'images/mainPageImg/grandma.png',
                  width: width * 0.1,
                ),
                Padding(padding: EdgeInsets.all(5)),
                Text(
                  '김박사 님',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            )),
            Padding(
              padding: EdgeInsets.all(width * 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SymtomHistory 페이지로 이동하는 버튼
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // 버튼 스타일 지정
                      minimumSize: Size(160, 160), // 최소 크기 설정
                      backgroundColor: Color(0xFFFFCC66), // 배경색 지정
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
                        Text(
                          '건강',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )),

                // MedicalHistory 페이지로 이동하는 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // 버튼 스타일 지정
                    minimumSize: Size(160, 160), // 최소 크기 설정
                    backgroundColor: Color(0xFF8ED973), // 배경색 지정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
                    // "운동" 버튼이 눌렸을 때 할 일 추가
                    // 이동할 페이지가 없으므로 일단 비워둡니다.
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'images/mainPageImg/exerciseIcon.png',
                        width: width * 0.15,
                      ),
                      Text(
                        '운동',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
                // SymtomHistory 페이지로 이동하는 버튼
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // 버튼 스타일 지정
                      minimumSize: Size(160, 160), // 최소 크기 설정
                      backgroundColor: Color(0xFFFF9966), // 배경색 지정
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      // "식사" 버튼이 눌렸을 때 할 일 추가
                      // 이동할 페이지가 없으므로 일단 비워둡니다.
                    },
                    child: Column(children: [
                      Image.asset(
                        'images/mainPageImg/mealIcon.png',
                        width: width * 0.15,
                      ),
                      Text(
                        '식사',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ])),

                // MedicalHistory 페이지로 이동하는 버튼
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // 버튼 스타일 지정

                      minimumSize: Size(160, 160), // 최소 크기 설정
                      backgroundColor: Color(0xFFA1DCFF), // 배경색 지정
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
                      Text(
                        '진료',
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ])),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.08),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08), // 양 옆에 10.0의 간격을 설정합니다.
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
                            color: Color.fromARGB(255, 170, 170, 170),
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
                            color: Colors.black),
                      )
                    ],
                  ),
                  Column(children: [
                    SizedBox(
                      width: width * 0.17,
                      height: width * 0.17,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 170, 170, 170),
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
                          color: Colors.black),
                    )
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
