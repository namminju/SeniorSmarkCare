import 'package:flutter/material.dart';
import 'package:frontend/screen/ExercisePage/ExercisePage.dart';
import 'package:frontend/screen/ExercisePage/ExerciseTime.dart';
import 'package:frontend/screen/MealPage/MealRecommend.dart';
import 'package:frontend/screen/MealPage/MealTime.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; //반응형으로 구현하기 위함
    double width = screenSize.width;
    double height = screenSize.height; //상대 수치를 이용하기 위함

    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height) * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBar(
                title: const Text('홀로똑똑'),
                backgroundColor: Colors.transparent,
                leading: Container(), //앱 바 좌축에 있는 버튼 지우는 효과 -> 뒤로 가기 같은 거
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
            const Center(
              child: Text('메인페이지'),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            TextButton(
              onPressed: () {
                // 버튼 클릭 시 mealrecommend() 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MealRecommend()),
                );
              },
              child: const Text('식사 추천'),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                // 버튼 클릭 시 mealrecommend() 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MealTime()),
                );
              },
              child: const Text('식사 시간 설정'),
            ),
          ],
        ),
      ),
    );
  }
}
