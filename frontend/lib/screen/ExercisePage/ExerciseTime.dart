import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/screen/MainScreen.dart';

class ExerciseTime extends StatefulWidget {
  const ExerciseTime({super.key});

  @override
  _ExerciseTime createState() => _ExerciseTime();
}

class _ExerciseTime extends State<ExerciseTime> {
  List<TimeOfDay?> _selectedTimes = []; // 선택된 시간을 저장할 리스트
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
                  '운동 시간 알림',
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
                      const SizedBox(width: 8),
                      Material(
                        elevation: 5, // 그림자 높이 설정
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 90, 90, 90),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 120,
                          child: DropdownButton<int>(
                            dropdownColor: Colors.white, //
                            value: _selectedCount,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedCount = newValue!;
                                _selectedTimes = List.generate(
                                  _selectedCount,
                                  (_) => null, // 선택된 시간 초기화
                                );
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
                      const SizedBox(width: 8),
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
                    '운동 시간',
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
                  const SizedBox(height: 8),
                  //위 드롭박스에서 설정한 횟수만큼 시간 받기
                  //ex. 드롭박스에서 3을 선택했다면
                  // 3개의 시간 선택이 가능한 버튼 띄우기
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _selectedCount,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '시간 ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 24,
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
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _selectTime(context, index);
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  minimumSize: const Size(160, 50),
                                ),
                                child: Text(
                                  _selectedTimes.isNotEmpty &&
                                          _selectedTimes.length > index &&
                                          _selectedTimes[index] != null
                                      ? _formatTime(_selectedTimes[index]!)
                                      : '시간 선택 ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFEB2B2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4, // 그림자 높이 조정
            ),
            onPressed: () {
              bool allTimesEntered = true;
              for (int i = 0; i < _selectedCount; i++) {
                if (_selectedTimes.length <= i || _selectedTimes[i] == null) {
                  allTimesEntered = false;
                  break;
                }
              }

              if (!allTimesEntered) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Center(
                        child: Text(
                          '알림',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(
                            color: Colors.grey,
                            height: 1,
                            thickness: 1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '모든 시간을 기입해주세요!',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFFEB2B2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              '확인',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // 여기에 데이터 저장 등의 로직을 추가할 수 있습니다.
                // 예를 들어 저장이 성공하면 메인 화면으로 이동할 수 있습니다.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MainScreen()), // 실제 화면 클래스로 변경
                );
              }
            },
            child: Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                '저장하기',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFFFEB2B2), // 배경색 설정
            colorScheme:
                const ColorScheme.light(primary: Color(0xFFFEB2B2)), // 기타 색상 설정
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // 버튼 텍스트 테마 설정
            ),
            timePickerTheme: TimePickerThemeData(
              // 이 부분에서 entertime 스타일 설정
              hourMinuteShape: const CircleBorder(), // 시간 선택 버튼 모양
              dayPeriodShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)), // AM/PM 버튼 모양
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        if (_selectedTimes.length > index) {
          _selectedTimes[index] = pickedTime; // 선택된 시간 리스트에 저장
        }
      });
    }
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final DateTime selectedTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return '${selectedTime.hour}:${selectedTime.minute}';
  }
}
