import 'package:flutter/material.dart';
import '../../widgets/PageNavigationBigButton.dart';
import 'package:frontend/screen/MedicalPage/MedicalHistory.dart'; // MedicalHistory 페이지 import
import 'package:frontend/widget/AppBar.dart';

class TelemedAppointment extends StatelessWidget {
  const TelemedAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형으로 구현하기 위함
    double width = screenSize.width;
    double height = screenSize.height; // 상대 수치를 이용하기 위함
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: const CustomAppBar(),
        body: Center(
            child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            SizedBox(
              width: width * 0.8,
              height: height * 0.65,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEB2B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                minimumSize: const Size(320, 52),
                maximumSize: const Size(320, 52), // 최소 크기 설정
              ),
              onPressed: () {
                // 버튼이 클릭되었을 때 실행되는 동작
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      content: SizedBox(
                        width: 288, // 원하는 너비 설정
                        height: 256, // 원하는 높이 설정
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
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
                                  child: const Text('X'),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.all(4),
                            ),
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.all(24),
                            ),
                            const Text(
                              '정말 종료하시겠습니까?',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(24),
                            ),
                            // PageNavigationBigButton 위젯 생성하면서 텍스트와 nextPage 설정
                            PageNavigationBigButton(
                                buttonText: '진료 종료하기',
                                nextPage:
                                    const MedicalHistory() // MedicalHistory 페이지로 이동
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
                  const Text(
                    '진료 종료',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8), // 텍스트와 이미지 사이의 간격 조절
                  Image.asset(
                    'images/medicalImg/call-slash.png', // 이미지 경로
                    height: 25, // 이미지 높이
                    width: 25, // 이미지 너비
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
