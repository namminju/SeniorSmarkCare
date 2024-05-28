import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';

class MealRecommend extends StatefulWidget {
  const MealRecommend({super.key});

  @override
  _MealRecommend createState() => _MealRecommend();
}

class _MealRecommend extends State<MealRecommend> {
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size; //반응형으로 구현하기 위함
    //double width = screenSize.width;
    //double height = screenSize.height; //상대 수치를 이용하기 위함

    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  '식사 식단 추천',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.5,
                        color: Color.fromARGB(128, 57, 57, 57),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/women.png', // 이미지 파일 경로
                          height: 40, // 이미지 높이 조정
                        ),
                        const SizedBox(width: 8), // 이미지와 텍스트 사이 간격 조절
                        const Text(
                          '김박사님께               ', // 사용자 이름 출력
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.5,
                                color: Color.fromARGB(128, 57, 57, 57),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '               추천드리는 식단!',
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 1.5,
                            color: Color.fromARGB(128, 57, 57, 57),
                          ),
                        ],
                      ),
                    ),
                    //또 다른 column이나 row를 작성하여 왼쪽 정렬
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '밥',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 1.5,
                                      color: Color.fromARGB(128, 57, 57, 57),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 4,
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/mealImg/riceIcon.png', // 이미지 파일 경로
                                  height: 80, // 이미지 높이 조정
                                ),
                                const SizedBox(width: 5),
                                const Expanded(
                                  child: // 이미지와 텍스트 사이 간격 조절
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '흑미밥 현미밥 잡곡밥 콩나물밥',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '국/찌개',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 1.5,
                                      color: Color.fromARGB(128, 57, 57, 57),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 4,
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/mealImg/soupIcon.png', // 이미지 파일 경로
                                  height: 80, // 이미지 높이 조정
                                ),
                                const SizedBox(width: 5),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '생배추국 소고기무국 홍합미역국 무된장국 시래기국',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '반찬',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 1.5,
                                      color: Color.fromARGB(128, 57, 57, 57),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(
                              height: 4,
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/mealImg/sidedishIcon.png', // 이미지 파일 경로
                                  height: 80, // 이미지 높이 조정
                                ),
                                const SizedBox(width: 5),
                                const Expanded(
                                  child: // 이미지와 텍스트 사이 간격 조절
                                      Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '새송이버섯 장조림 동이나물 봄나물 갈치조림 감자조림',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
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
    );
  }
}
