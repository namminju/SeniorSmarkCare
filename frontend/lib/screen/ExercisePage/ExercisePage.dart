import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';

// 가정: ExercisePhoto 위젯
class ExercisePhoto extends StatefulWidget {
  const ExercisePhoto({super.key});

  @override
  _ExercisePhotoState createState() => _ExercisePhotoState();
}

class _ExercisePhotoState extends State<ExercisePhoto> {
  int _selectedIndex = -1;

  void _toggleImage(int index) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('앉아서 하는 근력운동 ∇',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
            onTap: () => _toggleImage(0),
          ),
          if (_selectedIndex == 0)
            Container(
              margin: const EdgeInsets.all(4),
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Image.asset('images/exerciseImg/exercisePic1.png',
                  fit: BoxFit.cover),
            ), // A 이미지 URL을 여기에 넣으세요

          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('의자를 이용하는 근력운동 1 ∇',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
            onTap: () => _toggleImage(1),
          ),
          if (_selectedIndex == 1)
            Container(
              margin: const EdgeInsets.all(4),
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(1),
              //       spreadRadius: 2,
              //       blurRadius: 5,
              //       offset: const Offset(0, 2),
              //     ),
              //   ],
              // ),
              child: Image.asset('images/exerciseImg/exercisePic2.png',
                  fit: BoxFit.cover),
            ), // B 이미지 URL을 여기에 넣으세요

          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('의자를 이용하는 근력운동 2 ∇',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
            onTap: () => _toggleImage(2),
          ),
          if (_selectedIndex == 2)
            Container(
              margin: const EdgeInsets.all(4),
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Image.asset('images/exerciseImg/exercisePic5.png',
                  fit: BoxFit.cover), // C 이미지 URL을 여기에 넣으세요
            ),

          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('의자를 이용하는 근력운동 3 ∇',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
            onTap: () => _toggleImage(3),
          ),
          if (_selectedIndex == 3)
            Container(
              margin: const EdgeInsets.all(4),
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Image.asset('images/exerciseImg/exercisePic3.png',
                  fit: BoxFit.cover), // C 이미지 URL을 여기에 넣으세요
            ),

          ListTile(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('맨몸 뇌신경체조 ∇',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 1,
                ),
              ],
            ),
            onTap: () => _toggleImage(4),
          ),
          if (_selectedIndex == 4)
            Container(
              margin: const EdgeInsets.all(4),
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.withOpacity(0.5),
              //       spreadRadius: 5,
              //       blurRadius: 7,
              //       offset: const Offset(0, 3),
              //     ),
              //   ],
              // ),
              child: Image.asset('images/exerciseImg/exercisePic4.png',
                  fit: BoxFit.cover), // C 이미지 URL을 여기에 넣으세요
            ),
        ],
      ),
    );
  }
}

// 가정: ExerciseVideo 위젯
class ExerciseVideo extends StatelessWidget {
  const ExerciseVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '운동 영상 내용',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Exercisepage 위젯
class Exercisepage extends StatefulWidget {
  const Exercisepage({super.key});

  @override
  _ExercisePage createState() => _ExercisePage();
}

class _ExercisePage extends State<Exercisepage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 12),
            Center(
              child: Text(
                "운동 사진",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.5,
                      color: Color.fromARGB(128, 69, 69, 69),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ExercisePhoto(),
            ),
          ],
        ),
      ),
    );
  }
}
