import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart'; // 수정된 파일 경로
import 'package:frontend/widgets/NoticeDialog.dart'; // 수정된 파일 경로

class ChangeChronicIll extends StatefulWidget {
  @override
  _ChangeChronicIllState createState() => _ChangeChronicIllState();
}

class _ChangeChronicIllState extends State<ChangeChronicIll> {
  bool lastChecked1 = false;
  bool lastChecked2 = false;
  bool lastChecked3 = false;
  bool lastChecked4 = false;
  bool lastChecked5 = false;
  bool lastChecked6 = false;
  bool lastChecked7 = false;
  bool nowChecked1 = false;
  bool nowChecked2 = false;
  bool nowChecked3 = false;
  bool nowChecked4 = false;
  bool nowChecked5 = false;
  bool nowChecked6 = false;
  bool nowChecked7 = false;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const NoticeDialog(
          text: '앓고 있는 지병 변경이\n     완료되었습니다.', // 매개변수로 텍스트 전달
        );
      },
    );
  }

  // void _showErrorDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return NoticeDialog(
  //         text: '앓고 있는 지병 변경이 실패하였습니다. 다시 시도해주세요.', // 매개변수로 텍스트 전달
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    //double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(), // 수정된 AppBar 사용 방법
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.03),
                ),
                const Text(
                  '마이페이지',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: const Text(
                    '[앓고 있는 지병]',
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
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '과거병력',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: lastChecked1,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              lastChecked1 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(
                                            width: 8), // 체크박스와 텍스트 사이의 간격 조정
                                        const Text(
                                          '고혈압',
                                          style: TextStyle(
                                              fontSize: 24), // 텍스트 스타일 조정 가능
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: lastChecked2,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              lastChecked2 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '심장질환',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: lastChecked3,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              lastChecked3 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '당뇨',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: lastChecked4,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              lastChecked4 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '알레르기',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: lastChecked5,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              lastChecked5 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '결핵',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: lastChecked6,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              lastChecked6 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '수술력',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: lastChecked7,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              lastChecked7 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '간염',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    child: Row(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '현재 앓고 있는 지병',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: nowChecked1,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nowChecked1 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(
                                            width: 8), // 체크박스와 텍스트 사이의 간격 조정
                                        const Text(
                                          '고혈압',
                                          style: TextStyle(
                                              fontSize: 24), // 텍스트 스타일 조정 가능
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: nowChecked2,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nowChecked2 = value ?? false;
                                            });
                                          },
                                          activeColor:
                                              Color(0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '심장질환',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: nowChecked3,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nowChecked3 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '당뇨',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: nowChecked4,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nowChecked4 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '알레르기',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: nowChecked5,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nowChecked5 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '결핵',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: nowChecked6,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nowChecked6 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '수술력',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: nowChecked7,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              nowChecked7 = value ?? false;
                                            });
                                          },
                                          activeColor: const Color(
                                              0xFFFEB2B2), // 체크 시 분홍색 지정
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          '간염',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    child: Row(),
                                  ),
                                ],
                              ),
                              const Row(),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFEB2B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 4,
                          ),
                          onPressed: _showConfirmationDialog,
                          child: const SizedBox(
                            width: 320,
                            height: 40,
                            child: Center(
                              child: Text(
                                '저장하기',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 130.0),
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
