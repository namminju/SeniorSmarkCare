import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/screen/MyPage/ChangeAddress.dart';
import 'package:frontend/screen/MyPage/ChangeBodyInfo.dart';
import 'package:frontend/screen/MyPage/ChangePhoneNum.dart';
import 'package:frontend/screen/MyPage/ChangeGuardianPhoneNum.dart';
import 'package:frontend/screen/MyPage/ChangeChronicIll.dart';

class Mypage extends StatefulWidget {
  @override
  _Mypage createState() => _Mypage();
}

class _Mypage extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형으로 구현하기 위함
    double width = screenSize.width;
    double height = screenSize.height; // 상대 수치를 이용하기 위함

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
              Text(
                '마이페이지',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Text(
                  '* 변경 버튼이 없는 정보는 바꿀 수 없습니다.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
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
                          '성명',
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
                          '김도현',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '생년월일',
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
                          '2002-12-13',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '알고 있는 지병',
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '당뇨, 고혈압',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEB2B2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 1, // 그림자 높이 조정
                                ),
                                onPressed: () {
                                  // SymtomHistory 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeChronicIll()),
                                  );
                                },
                                child: Container(
                                  width: 68,
                                  height: 24,
                                  child: Center(
                                    child: Text(
                                      '상세 보기',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '거주지',
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '01721',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEB2B2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 1, // 그림자 높이 조정
                                ),
                                onPressed: () {
                                  // SymtomHistory 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeAddress()),
                                  );
                                },
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
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          '서울특별시 노원구 라이프신동아파트 116동 901호',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '신체 정보',
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '167cm / 100kg',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEB2B2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 1, // 그림자 높이 조정
                                ),
                                onPressed: () {
                                  // SymtomHistory 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeBodyInfo()),
                                  );
                                },
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
                            ]),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '성별',
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
                          '여성',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '전화번호',
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '010-1234-5678',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEB2B2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 1, // 그림자 높이 조정
                                ),
                                onPressed: () {
                                  // SymtomHistory 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangePhoneNum()),
                                  );
                                },
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
                            ]),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 30)),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '보호자 전화번호',
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '010-5678-5678',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEB2B2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 1, // 그림자 높이 조정
                                ),
                                onPressed: () {
                                  // SymtomHistory 페이지로 이동
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeGuardianPhoneNum()),
                                  );
                                },
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
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(36.0),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
