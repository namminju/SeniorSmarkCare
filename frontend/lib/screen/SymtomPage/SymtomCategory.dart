import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/screen/SymtomPage/SymtomHistory.dart';
import 'package:frontend/widgets/PageNavigationBigButton.dart';
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

final List<String> categories = ['', '머리', '상체', '하체', '손/발'];
List<bool> update = [];
DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

class DynamicPage extends StatefulWidget {
  final String category;
  final String paramName;

  DynamicPage({required this.category, required this.paramName});

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  final Logger _logger = Logger('_DynamicPageState');
  @override
  void initState() {
    super.initState();
    _getSymptoms();
  }

  List<dynamic> symptoms = [];
  List<bool> checkedList = [];
  Future<void> _getSymptoms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/symptom/${widget.paramName}'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var utf8Data = utf8.decode(response.bodyBytes);
          setState(() {
            symptoms = json.decode(utf8Data);
            _loadCheckedList(prefs); // SharedPreferences에서 체크 여부 불러오기
          });
        } else {
          _logger.warning('Failed to load symptoms: ${response.statusCode}');
        }
      } catch (e) {
        _logger.severe('Error loading symptoms: $e');
      }
    } else {
      _logger.warning('Token not found');
    }
  }

  void _loadCheckedList(SharedPreferences prefs) {
    for (var symptom in symptoms) {
      bool isChecked = prefs.getBool('${symptom['id']}') ?? false;
      checkedList.add(isChecked);
    }
  }

  void _saveCheckedState(int index, bool isChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${symptoms[index]['id']}', isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.category,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < symptoms.length; i++)
            Column(
              children: [
                const SizedBox(height: 1),
                CheckboxListTile(
                  title: Text(symptoms[i]['display_name'] ?? 'No name'),
                  value: checkedList[i],
                  activeColor: const Color(0xFFFEB2B2),
                  onChanged: (bool? value) {
                    setState(() {
                      checkedList[i] = value ?? false;
                      _saveCheckedState(i, checkedList[i]);
                    });
                  },
                ),
                const SizedBox(height: 1),
              ],
            ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class SymptomCategory extends StatefulWidget {
  final VoidCallback? onSubmit;

  SymptomCategory({Key? key, this.onSubmit}) : super(key: key);

  @override
  _SymptomCategoryState createState() => _SymptomCategoryState();
}

class _SymptomCategoryState extends State<SymptomCategory> {
  int currentPageIndex = 0;

  final List<String> paramNames = [
    '',
    'head',
    'upper_body',
    'lower_body',
    'hand_foot'
  ];
  final List<int> paramNumber = [0, 1, 8, 16, 23];
  final Logger _logger = Logger('_SymptomCategoryState');

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xFFF0F0F0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentPageIndex > 0)
            DynamicPage(
              category: categories[currentPageIndex],
              paramName: paramNames[currentPageIndex],
            ),
          if (currentPageIndex == 0)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 1; i < categories.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF0F0F0),
                        side: const BorderSide(width: 2, color: Colors.black),
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
                                    color: const Color(0xFFFEB2B2),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: width * 0.01,
                                    ),
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
                              const SizedBox(width: 8),
                              Text(
                                categories[i],
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
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
                const Padding(
                  padding: EdgeInsets.all(12),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEB2B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    minimumSize: const Size(280, 40),
                    maximumSize: const Size(300, 45),
                  ),
                  onPressed: () async {
                    update.clear();
                    List<Future<void>> futures = [];

                    for (int i = 1; i < paramNames.length; i++) {
                      futures.add(sendSymptoms(context, paramNames[i], i));
                    }

                    await Future.wait(futures);

                    _showSubmissionDialog(context);
                  },
                  child: const Text(
                    '제출',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          if (currentPageIndex > 0)
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEB2B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    minimumSize: const Size(110, 40),
                    maximumSize: const Size(130, 45),
                  ),
                  onPressed: () {
                    setState(() {
                      currentPageIndex = 0;
                    });
                  },
                  child: const Text(
                    '이전',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEB2B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    minimumSize: const Size(110, 40),
                    maximumSize: const Size(130, 45),
                  ),
                  onPressed: () async {
                    update.clear();
                    List<Future<void>> futures = [];

                    for (int i = 1; i < paramNames.length; i++) {
                      futures.add(sendSymptoms(context, paramNames[i], i));
                    }

                    await Future.wait(futures);

                    _logger.info(update);
                    _showSubmissionDialog(context);
                  },
                  child: const Text(
                    '제출',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

final List<int> paramNum = [0, 1, 8, 16, 23, 31];
Future<void> sendSymptoms(BuildContext context, String paramName, int i) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  final Logger logger = Logger('sendSymptoms');

  if (token != null && token.isNotEmpty) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "accept": "*/*",
      "Authorization": "Token $token"
    };

    var selectedSymptoms = [];
    for (int j = paramNum[i]; j < paramNum[i + 1]; j++) {
      bool isChecked = prefs.getBool(j.toString()) ?? false;
      if (isChecked) {
        selectedSymptoms.add((j).toString());
      }
    }

    // 모든 상태 정보 포함하여 body 구성
    var body = json.encode({
      "symptom_date": formattedDate,
      "${paramName.toLowerCase()}_symptoms": selectedSymptoms,
    });

    try {
      var response = await http.post(
        Uri.parse('${RootUrlProvider.baseURL}/symptom/create/$paramName'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        update.add(true);
        logger.info(i);
        logger.info('update');
        logger.info(update);
        //_showSubmissionDialog(context);
      } else {
        logger.warning('Submission failed: ${response.statusCode}');
        update.add(false);
        logger.warning('update');
        logger.warning(update);
        //_showErrorDialog(context);
      }
      logger.info(body);
    } catch (e) {
      logger.severe('Error submitting symptoms: $e');
    }
  } else {
    logger.warning('Token not found');
  }
}

void _showSubmissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Determine whether submission was successful or not based on `update` array
      bool isSuccess = update.contains(true);

      return AlertDialog(
        backgroundColor: Colors.white,
        content: SizedBox(
          width: 288,
          height: 256,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(' '),
                  const Text(' '),
                  Text(
                    isSuccess ? '알림' : '오류', // Show '알림' only if not successful
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(4),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(24),
              ),
              if (isSuccess) // Show categories only if successful
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      if (update[i])
                        Text(
                          categories[i + 1] + ',',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    if (update[3])
                      Text(
                        categories[4],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              Text(
                isSuccess ? '제출이 완료되었습니다.' : '제출에 실패했습니다.\n다시 시도해주세요.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(24),
              ),
              if (isSuccess) // Show button only if successful
                PageNavigationBigButton(
                  buttonText: '확인하러 가기',
                  nextPage: SymptomHistory(),
                ),
              if (!isSuccess) // Show button only if not successful
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEB2B2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4, // 그림자 높이 조정
                    minimumSize: const Size(240, 44), // 최소 크기 설정
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: SymptomCategory(),
  ));
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
