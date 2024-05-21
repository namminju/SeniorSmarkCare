import 'package:flutter/material.dart';

class SymtomCategory extends StatefulWidget {
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
                          child: Text(
                            getButtonText(i),
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            )
          else
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // 버튼의 배경색을 빨간색으로 지정
              ),
              onPressed: () {
                setState(() {
                  currentPageIndex = 0;
                });
              },
              child: Text('첫 번째 페이지로 돌아가기'),
            ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '머리',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        CheckboxListTile(
          title: Text('통증 1'),
          value: isChecked1,
          onChanged: (bool? value) {
            setState(() {
              isChecked1 = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: Text('통증 2'),
          value: isChecked2,
          onChanged: (bool? value) {
            setState(() {
              isChecked2 = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: Text('통증 3'),
          value: isChecked2,
          onChanged: (bool? value) {
            setState(() {
              isChecked2 = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: Text('통증4 '),
          value: isChecked2,
          onChanged: (bool? value) {
            setState(() {
              isChecked2 = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: Text('통증 5'),
          value: isChecked2,
          onChanged: (bool? value) {
            setState(() {
              isChecked2 = value ?? false;
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
