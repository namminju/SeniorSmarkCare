import 'package:flutter/material.dart';
import '../../widgets/PageNavigationBigButton.dart';
import './MedicalHistory.dart'; // MedicalHistory 페이지 import

class TelemedAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형으로 구현하기 위함
    double width = screenSize.width;
    double height = screenSize.height; // 상대 수치를 이용하기 위함
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text('비대면 진료'),
        ),
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            SizedBox(
              width: width * 0.8,
              height: height * 0.65,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    'images/mainPageImg/qnaIcon.png',
                    width: width * 0.07,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFEB2B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                minimumSize: Size(320, 52),
                maximumSize: Size(320, 52), // 최소 크기 설정
              ),
              onPressed: () {
                // 버튼이 클릭되었을 때 실행되는 동작
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      content: Container(
                        width: 288, // 원하는 너비 설정
                        height: 256, // 원하는 높이 설정
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '알림',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // 취소 버튼을 누르면 다이얼로그만 종료
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('X'),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(24),
                            ),
                            Text(
                              '정말 종료하시겠습니까?',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                            ),
                            // PageNavigationBigButton 위젯 생성하면서 텍스트와 nextPage 설정
                            PageNavigationBigButton(
                              buttonText: '진료 종료하기',
                              nextPage:
                                  MedicalHistory(), // MedicalHistory 페이지로 이동
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '진료 종료',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8), // 텍스트와 이미지 사이의 간격 조절
                  Image.asset(
                    'images/medicalImg/call-slash.png', // 이미지 경로
                    height: 20, // 이미지 높이
                    width: 20, // 이미지 너비
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
