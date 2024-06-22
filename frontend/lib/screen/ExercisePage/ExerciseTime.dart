import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/screen/MainScreen.dart';

class ExerciseTime extends StatefulWidget {
  const ExerciseTime({super.key});

  @override
  _ExerciseTimeState createState() => _ExerciseTimeState();
}

class _ExerciseTimeState extends State<ExerciseTime> {
  List<TimeOfDay?> _selectedTimes = []; // 선택된 시간을 저장할 리스트
  int _selectedCount = 1; // 초기 알람 횟수 설정
  final List<int> _alarmcnt = [1, 2, 3, 4, 5]; // 선택할 수 있는 알람 횟수 목록
  int exerciseAlarmCount = 1; // 초기 알람 횟수 설정

  @override
  void initState() {
    super.initState();
    _fetchExerciseAlarmCount(); // 초기 알람 횟수를 백엔드에서 가져오는 함수 호출
    _fetchExerciseTimes(); // 초기 운동 시간을 백엔드에서 가져오는 함수 호출
  }

  // 백엔드에서 알람 횟수 가져오기
  void _fetchExerciseAlarmCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final String apiUrl = '${RootUrlProvider.baseURL}/exercise/alarm-cnt/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final exerciseAlarmCnt = jsonData['exerciseAlarmCnt'];
        setState(() {
          exerciseAlarmCount = exerciseAlarmCnt;
          _selectedCount = exerciseAlarmCnt;
          _selectedTimes = List.generate(
              _selectedCount, (_) => const TimeOfDay(hour: 0, minute: 0));
        });
      } else {
        throw Exception('Failed to load exercise alarm count');
      }
    } catch (e) {
      print('Error fetching exercise alarm count: $e');
      // 오류 발생 시 기본값으로 초기화
      setState(() {
        exerciseAlarmCount = 1;
        _selectedCount = 1;
        _selectedTimes = List.generate(
            _selectedCount, (_) => const TimeOfDay(hour: 0, minute: 0));
      });
    }
  }

  // 백엔드에서 운동 시간 가져오기
  void _fetchExerciseTimes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final String apiUrl = '${RootUrlProvider.baseURL}/exercise/time/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final times = (jsonData['exerciseTime'] ?? []) as List<dynamic>;
        setState(() {
          _selectedTimes = times
              .map((time) => time != null
                  ? TimeOfDay(
                      hour: int.parse(time.split(':')[0]),
                      minute: int.parse(time.split(':')[1]),
                    )
                  : const TimeOfDay(hour: 0, minute: 0))
              .toList();
        });
      } else {
        throw Exception('Failed to load exercise times');
      }
    } catch (e) {
      print('Error fetching exercise times: $e');
    }
  }

  // 운동 시간을 백엔드에 저장
  _saveExerciseTimes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final String apiUrl = '${RootUrlProvider.baseURL}/exercise/time/';

      // Create a map of exercise times with exerciseTime1, exerciseTime2, ...
      Map<String, String?> exerciseTimesMap = {};
      for (int i = 0; i < _selectedTimes.length; i++) {
        exerciseTimesMap['exerciseTime${i + 1}'] = _selectedTimes[i] != null
            ? _formatTimeForApi(_selectedTimes[i]!)
            : null;
      }

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(exerciseTimesMap),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Exercise times saved successfully');
      } else {
        throw Exception('Failed to save exercise times');
      }
    } catch (e) {
      print('Error saving exercise times: $e');
    }
  }

  // 알람 횟수를 백엔드에 저장
  _saveExerciseAlarmCount(int count) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final String apiUrl = '${RootUrlProvider.baseURL}/exercise/alarm-cnt/';
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'exerciseAlarmCnt': count}),
      );

      if (response.statusCode == 200) {
        // 성공적으로 저장됨

        print('Exercise alarm count saved successfully');
        //await _saveExerciseTimes();
      } else {
        throw Exception('Failed to save exercise alarm count');
      }
    } catch (e) {
      print('Error saving exercise alarm count: $e');
      // 실패 시 에러 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  const SizedBox(height: 4),
                  const Divider(height: 4, color: Colors.black),
                  const SizedBox(height: 8),
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
                        elevation: 5,
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
                            dropdownColor: Colors.white,
                            value: _selectedCount,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedCount = newValue!;
                                _selectedTimes = List.generate(
                                  _selectedCount,
                                  (_) => null,
                                );
                              });
                            },
                            underline: Container(
                              height: 0,
                            ),
                            items: _alarmcnt
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
                  const SizedBox(height: 36),
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
                  const SizedBox(height: 4),
                  const Divider(height: 4, color: Colors.black),
                  const SizedBox(height: 8),
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
                              const SizedBox(width: 20),
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
              elevation: 4,
            ),
            onPressed: () async {
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
                          Divider(color: Colors.grey, height: 1, thickness: 1),
                          SizedBox(height: 8),
                          Text(
                            '\n모든 시간을 기입해주세요!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        Container(
                          width: 240,
                          height: 44,
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
                return;
              }

              try {
                await _saveExerciseAlarmCount(_selectedCount);

                await _saveExerciseTimes();

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
                          Divider(color: Colors.grey, height: 1, thickness: 1),
                          SizedBox(height: 8),
                          Text(
                            '\n저장되었습니다!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        Container(
                          width: 240,
                          height: 44,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
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
              } catch (e) {
                print('Error saving exercise alarm count: $e');

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
                      actions: [
                        Container(
                          width: 240,
                          height: 44,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
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
              }
            },
            child: Container(
              height: 52,
              width: 320,
              alignment: Alignment.center,
              child: const Text(
                '저장하기',
                style: TextStyle(
                  fontSize: 16,
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
            primaryColor: const Color(0xFFFEB2B2),
            colorScheme: const ColorScheme.light(primary: Color(0xFFFEB2B2)),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            timePickerTheme: TimePickerThemeData(
              hourMinuteShape: const CircleBorder(),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        if (_selectedTimes.length > index) {
          _selectedTimes[index] = pickedTime;
        }
      });
      print('선택된 시간: ${_formatTime(pickedTime)}');
    }
  }

  String _formatTime(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatTimeForApi(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    final String formattedTime = '$hour:$minute:00';
    return formattedTime;
  }
}
