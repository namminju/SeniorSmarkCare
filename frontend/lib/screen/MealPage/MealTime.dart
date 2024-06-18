import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';

class MealTime extends StatefulWidget {
  const MealTime({super.key});

  @override
  _MealTimeState createState() => _MealTimeState();
}

class _MealTimeState extends State<MealTime> {
  int _selectedCount = 1;
  final List<int> _mealCounts = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //안전한 영역의 확보
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  '식사 시간 알림',
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
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '알림 횟수',
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
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' 하루  ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                      Material(
                        elevation: 5, // 그림자 높이 설정
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 90, 90, 90),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 120,
                          child: DropdownButton<int>(
                            value: _selectedCount,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedCount = newValue!;
                              });
                            },
                            underline: Container(
                              height: 0,
                            ),
                            items: _mealCounts
                                .map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const Text(
                        ' 번',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
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
                    ],
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  const Text(
                    '식사 시간',
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
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  //위 드롭박스에서 설정한 횟수만큼 시간 받기
                  //ex. 드롭박스에서 3을 선택했다면
                  // 3개의 시간 선택이 가능한 버튼 띄우기
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < _selectedCount; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _selectTime(context);
                              },
                              style: ElevatedButton.styleFrom(
                                // 버튼 그림자 설정
                                elevation: 5,
                                // 버튼 모서리를 둥글게 설정
                                minimumSize: const Size(160, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                              child: Text(
                                '시간 선택 $i',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      // 시간 선택 후 실행할 작업 추가
    }
  }
}
