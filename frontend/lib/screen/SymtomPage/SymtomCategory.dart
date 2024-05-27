import 'package:flutter/material.dart';
import '../../widgets/PageNavigationBigButton.dart';
import './SymtomHistory.dart';

class SymtomCategory extends StatefulWidget {
  final VoidCallback? onSubmit;

  SymtomCategory({Key? key, this.onSubmit}) : super(key: key);

  @override
  _SymtomCategoryState createState() => _SymtomCategoryState();
}

class _SymtomCategoryState extends State<SymtomCategory> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
    FivethPage(),
    // Add more pages here if needed
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 반응형으로 구현하기 위함
    double width = screenSize.width;
    double height = screenSize.height; // 상대 수치를 이용하기 위함

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Color(0xFFF0F0F0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          pages[currentPageIndex],
          SizedBox(height: 20),
          if (currentPageIndex == 0)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 1; i < pages.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF0F0F0), // 버튼의 배경색을 투명으로 설정
                        side: BorderSide(width: 2, color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          currentPageIndex = i;
                        });
                      },
                      child: SizedBox(
                        width: 295,
                        height: 90,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width * 0.16,
                                height: width * 0.16,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFEB2B2),
                                    border: Border.all(
                                        color: Colors.black,
                                        width: width * 0.01),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      getButtonImage(i),
                                      width: width * 0.11,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 5), // 간격 조절
                              Text(
                                getButtonText(i),
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '   +   ',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFEB2B2), // 버튼의 배경색을 빨간색으로 지정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    minimumSize: Size(280, 40),
                    maximumSize: Size(300, 45),
                  ),
                  onPressed: () {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  '제출이 완료되었습니다.',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                ),
                                // PageNavigationBigButton 위젯 생성하면서 텍스트와 nextPage 설정
                                PageNavigationBigButton(
                                  buttonText: '확인하러 가기',
                                  nextPage:
                                      SymtomHistory(), // MedicalHistory 페이지로 이동
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    '제출',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFEB2B2), // 버튼의 배경색을 빨간색으로 지정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    minimumSize: Size(110, 40),
                    maximumSize: Size(130, 45),
                  ),
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 0;
                    });
                  },
                  child: Text(
                    '이전',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFEB2B2), // 버튼의 배경색을 빨간색으로 지정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    minimumSize: Size(110, 40),
                    maximumSize: Size(130, 45),
                  ),
                  onPressed: () {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  '제출이 완료되었습니다.',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(24),
                                ),
                                // PageNavigationBigButton 위젯 생성하면서 텍스트와 nextPage 설정
                                PageNavigationBigButton(
                                  buttonText: '확인하러 가기',
                                  nextPage:
                                      SymtomHistory(), // MedicalHistory 페이지로 이동
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    '제출',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  // 버튼의 텍스트를 반환하는 함수
  String getButtonText(int index) {
    switch (index) {
      case 1:
        return '머리';
      case 2:
        return '상체';
      case 3:
        return '하체';
      case 4:
        return '손/발';
      default:
        return '';
    }
  }
}

String getButtonImage(int index) {
  switch (index) {
    case 1:
      return 'images/symtomImg/head.png';
    case 2:
      return 'images/symtomImg/upper.png';
    case 3:
      return 'images/symtomImg/lower.png';
    case 4:
      return 'images/symtomImg/handfoot.png';
    default:
      return '';
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '머리',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
        ),
        CheckboxListTile(
          title: Text('통증 1'),
          value: isChecked1,
          activeColor: Color(0xFFFEB2B2),
          onChanged: (bool? value) {
            setState(() {
              isChecked1 = value ?? false;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CheckboxListTile(
          title: Text('통증 2'),
          value: isChecked2,
          activeColor: Color(0xFFFEB2B2), // 체크된 상태의 색상을 초록색으로 변경
          onChanged: (bool? value) {
            setState(() {
              isChecked2 = value ?? false;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CheckboxListTile(
          title: Text('통증 3'),
          value: isChecked3,
          activeColor: Color(0xFFFEB2B2), // 체크된 상태의 색상을 빨간색으로 변경
          onChanged: (bool? value) {
            setState(() {
              isChecked3 = value ?? false;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CheckboxListTile(
          title: Text('통증 4'),
          value: isChecked4,
          activeColor: Color(0xFFFEB2B2), // 체크된 상태의 색상을 주황색으로 변경
          onChanged: (bool? value) {
            setState(() {
              isChecked4 = value ?? false;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CheckboxListTile(
          title: Text('통증 5'),
          value: isChecked5,
          activeColor: Color(0xFFFEB2B2), // 체크된 상태의 색상을 보라색으로 변경
          onChanged: (bool? value) {
            setState(() {
              isChecked5 = value ?? false;
            });
          },
        ),
        // Add more CheckboxListTile widgets here if needed
      ],
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '상체',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('세 번째 페이지 내용'),
      ],
    );
  }
}

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '하체',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('4 번째 페이지 내용'),
      ],
    );
  }
}

class FivethPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '손/발',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('5 번째 페이지 내용'),
      ],
    );
  }
}
