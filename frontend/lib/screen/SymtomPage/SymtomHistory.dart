import 'package:flutter/material.dart';
import './SymtomCategory.dart';
import './SymtomHistoryAdd.dart';
import '../../widgets/PageNavigationBigButton.dart';

class SymtomHistory extends StatefulWidget {
  @override
  _SymtomHistory createState() => _SymtomHistory();
}

class _SymtomHistory extends State<SymtomHistory> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형으로 구현하기 위함
    double width = screenSize.width;
    double height = screenSize.height; // 상대 수치를 이용하기 위함
    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text('건강 기록'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/mainPageImg/grandma.png',
                      width: width * 0.1,
                    ),
                    Padding(padding: EdgeInsets.all(2)),
                    Text(
                      '000님',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '의 건강기록',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
                    )
                  ],
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '오늘 나의 상태는?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                '머리-압박감',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                '머리 급성 두통',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                '상체-심잠통증',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SymtomHistoryAdd()),
                                  );
                                  // 더보기 텍스트가 클릭되었을 때 실행되는 동작
                                },
                                child: Text(
                                  '더보기',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '혹시 더 아픈 부위가 있으신가요?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '아래 버튼을 이용하여 추가해보세요!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: 20), // 버튼 위에 여백 추가
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFEB2B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 4, // 그림자 높이 조정
                          ),
                          onPressed: () {
                            // 버튼이 클릭되었을 때 실행되는 동작
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(20),
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Color(0XFFF0F0F0),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '오늘 나의 상태는?',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width:
                                            300, // SymtomCategory 위젯의 너비를 지정합니다.
                                        height:
                                            550, // SymtomCategory 위젯의 높이를 지정합니다.
                                        child: SymtomCategory(
                                          onSubmit: () {
                                            // 제출 버튼이 눌렸을 때의 동작
                                            Navigator.of(context).pop();
                                          },
                                        ), // SymtomCategory 화면을 팝업에 표시합니다.
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 320,
                            height: 52,
                            child: Center(
                              child: Text(
                                '증상 추가',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
