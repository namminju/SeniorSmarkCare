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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                '김박사 님',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.024),
                ),
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
                      MaterialPageRoute(builder: (context) => SymtomHistory()),
                    );
                  },
                  child: Text(
                    '건강',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.024),
                ),
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
                  onPressed: () {},
                  child: Text(
                    '운동',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.024),
                ),
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
                  onPressed: () {},
                  child: Text(
                    '식사',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.024),
                ),
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
                      MaterialPageRoute(builder: (context) => MedicalHistory()),
                    );
                  },
                  child: Text(
                    '진료',
                    style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
