import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/screen/MainScreen.dart';
//
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//

class MealTime extends StatefulWidget {
  const MealTime({super.key});

  @override
  _MealTimeState createState() => _MealTimeState();
}

class _MealTimeState extends State<MealTime> {
  List<TimeOfDay?> _selectedTimes = []; // 선택된 시간을 저장할 리스트
  int _selectedCount = 1;
  final List<int> _mealCounts = [1, 2, 3, 4, 5];
  int mealAlarmCount = 1;

  @override
  void initState() {
    super.initState();
    _fetchMealAlarmCount(); // 초기 알람 횟수를 백엔드에서 가져오는 함수 호출
    _fetchMealTimes(); // 초기 운동 시간을 백엔드에서 가져오는 함수 호출
  }

// 백엔드에서 알람 횟수 가져오기
  void _fetchMealAlarmCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      const apiUrl = '${RootUrlProvider.baseURL}/meal/alarm-cnt/';
      final response = await http.get(
        // GET 요청으로 변경
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final mealAlarmCnt = jsonData['mealAlarmCnt'];
        setState(() {
          mealAlarmCount = mealAlarmCnt;
          _selectedCount = mealAlarmCnt;
          _selectedTimes = List.generate(
              _selectedCount, (_) => const TimeOfDay(hour: 0, minute: 0));
        });
      } else {
        throw Exception('Failed to load meal alarm count');
      }
    } catch (e) {
      print('Error fetching exercise alarm count: $e');
      // 오류 발생 시 기본값으로 초기화
      setState(() {
        mealAlarmCount = 1;
        _selectedCount = 1;
        _selectedTimes = List.generate(
            _selectedCount, (_) => const TimeOfDay(hour: 0, minute: 0));
      });
    }
  }

  // 백엔드에서 운동 시간 가져오기
  void _fetchMealTimes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      const apiUrl = '${RootUrlProvider.baseURL}/meal/time/';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final times = (jsonData['mealTime'] ?? []) as List<dynamic>;
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
        throw Exception('Failed to load meal times');
      }
    } catch (e) {
      print('Error fetching meal times: $e');
    }
  }

  // 운동 시간을 백엔드에 저장
  _saveMealTimes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      const apiUrl = '${RootUrlProvider.baseURL}/meal/time/';

      // Create a map of meal times with 1,2,...,5
      Map<String, String?> mealTimesMap = {};
      for (int i = 0; i < _selectedTimes.length; i++) {
        mealTimesMap['mealTime${i + 1}'] = _selectedTimes[i] != null
            ? _formatTimeForApi(_selectedTimes[i]!)
            : null;
      }

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(mealTimesMap),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Meal times saved successfully');
      } else {
        throw Exception('Failed to save meal times');
      }
    } catch (e) {
      print('Error saving meal times: $e');
    }
  }

  // 알람 횟수를 백엔드에 저장
  _saveMealAlarmCount(int count) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      const apiUrl = '${RootUrlProvider.baseURL}/meal/alarm-cnt/';
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Token $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'mealAlarmCnt': count}),
      );

      if (response.statusCode == 200) {
        // 성공적으로 저장됨
        print('Meal alarm count saved successfully');
      } else {
        throw Exception('Failed to save meal alarm count');
      }
    } catch (e) {
      print('Error saving meal alarm count: $e');
      // 실패 시 에러 처리
    }
  }

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
                            dropdownColor: Colors.white, //
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
                  const SizedBox(height: 36),
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
                  const SizedBox(height: 4),
                  const Divider(height: 4, color: Colors.black),
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
        ////
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEB2B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4),
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
                          Divider(
                            color: Colors.grey,
                            height: 1,
                            thickness: 1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\n모든 시간을 기입해주세요!',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
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
                // 모든 시간이 입력되었을 때 선택된 횟수를 저장하고 앱 상태를 업데이트
                await _saveMealAlarmCount(_selectedCount);

                await _saveMealTimes();

                // 저장 완료 시 사용자에게 메시지 표시
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
                                    builder: (context) => const MainScreen()),
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
                print('Error saving meal alarm count: $e');
                // 저장 실패 시 예외 처리
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
                                      builder: (context) => const MainScreen()),
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
                    });
              }
            },
            child: Container(
              height: 52,
              width: 320,
              alignment: Alignment.center,
              child: const Text(
                '저장하기',
                style: TextStyle(
                  fontSize: 16.0,
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
