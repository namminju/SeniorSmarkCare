import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';

// 가정: ExercisePhoto 위젯
class ExercisePhoto extends StatefulWidget {
  const ExercisePhoto({super.key});

  @override
  _ExercisePhotoState createState() => _ExercisePhotoState();
}

class _ExercisePhotoState extends State<ExercisePhoto> {
  bool _showImageA = false;
  bool _showImageB = false;
  bool _showImageC = false;

  void _toggleImageA() {
    setState(() {
      _showImageA = !_showImageA;
    });
  }

  void _toggleImageB() {
    setState(() {
      _showImageB = !_showImageB;
    });
  }

  void _toggleImageC() {
    setState(() {
      _showImageC = !_showImageC;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('a', style: TextStyle(fontSize: 24)),
          onTap: _toggleImageA,
        ),
        if (_showImageA)
          Image.network(
              'images/exerciseImg/exercisePic1.png'), // A 이미지 URL을 여기에 넣으세요

        ListTile(
          title: const Text('b', style: TextStyle(fontSize: 24)),
          onTap: _toggleImageB,
        ),
        if (_showImageB)
          Image.network(
              'images/exerciseImg/exercisePic2.png'), // B 이미지 URL을 여기에 넣으세요

        ListTile(
          title: const Text('c', style: TextStyle(fontSize: 24)),
          onTap: _toggleImageC,
        ),
        if (_showImageC)
          Image.network(
              'images/mealImg/exercisePic.png'), // C 이미지 URL을 여기에 넣으세요
      ],
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
  // 상태 변수: 0이면 운동 사진, 1이면 운동 영상
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0; // 운동 사진을 표시하도록 설정
                    });
                  },
                  child: Text(
                    "운동 사진",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: selectedIndex == 0
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : Colors.grey,
                      shadows: [
                        Shadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 1.5,
                          color: selectedIndex == 0
                              ? const Color.fromARGB(128, 69, 69, 69)
                              : const Color.fromARGB(128, 56, 56, 56),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1; // 운동 영상을 표시하도록 설정
                    });
                  },
                  child: Text(
                    "운동 영상",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: selectedIndex == 1
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : Colors.grey,
                      shadows: [
                        Shadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 1.5,
                          color: selectedIndex == 1
                              ? const Color.fromARGB(128, 69, 69, 69)
                              : const Color.fromARGB(128, 56, 56, 56),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: selectedIndex == 0
                  ? const ExercisePhoto()
                  : const ExerciseVideo(),
            ),
          ],
        ),
      ),
    );
  }
}
