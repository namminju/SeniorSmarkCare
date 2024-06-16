import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/widgets/NoticeDialog.dart';

class ChangeAddress extends StatefulWidget {
  @override
  _ChangeAddress createState() => _ChangeAddress();
}

class _ChangeAddress extends State<ChangeAddress> {
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoticeDialog(
          text: ' 거주지 변경이\n완료되었습니다.', // 매개변수로 텍스트 전달
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoticeDialog(
          text: '거주지 변경이 실패하였습니다. 다시 시도해주세요.', // 매개변수로 텍스트 전달
        );
      },
    );
  }

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
                    '[거주지 변경]',
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '기존 등록된 거주지',
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
                            '01721',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                            '변경하고자 하는 거주지',
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
                                '도로명 주소 입력',
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
                                  // 찾기 버튼 클릭 시 동작 정의
                                },
                                child: Container(
                                  width: 68,
                                  height: 24,
                                  child: Center(
                                    child: Text(
                                      '찾기',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            '상세주소 입력',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFEB2B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 4, // 그림자 높이 조정
                          ),
                          onPressed:
                              _showConfirmationDialog, // 저장하기 버튼 클릭 시 팝업 띄우기
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
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
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
