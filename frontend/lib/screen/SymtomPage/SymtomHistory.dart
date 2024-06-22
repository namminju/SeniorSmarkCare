import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/PageNavigationBigButton.dart';
import 'SymtomCategory.dart';
import 'SymtomHistoryAdd.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:frontend/Api/RootUrlProvider.dart';

class SymptomHistory extends StatefulWidget {
  @override
  _SymptomHistoryState createState() => _SymptomHistoryState();
}

class _SymptomHistoryState extends State<SymptomHistory> {
  String username = '';
  var userData = {};

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _getSymptom();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  Future<void> _getSymptom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/symptom/list/today'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var rawData = response.bodyBytes;
          var utf8Data = utf8.decode(rawData);

          setState(() {
            var tempData = json.decode(utf8Data);
            if (tempData[0].isNotEmpty) {
              userData = tempData[0];
            }
          });
        } else {
          print('Failed to load user data: ${response.statusCode}');
        }
      } catch (e) {
        print('Error loading user data: $e');
      }
    } else {
      print('Token not found');
    }
  }

  Widget _buildCategory(String category, List? symptoms) {
    return symptoms != null && symptoms.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Wrap(
                      children: List<Widget>.generate(
                        symptoms.length > 2 ? 2 : symptoms.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            child: Text(
                              '${symptoms[index]['display_name']}' +
                                  (index !=
                                          (symptoms.length > 2
                                              ? 1
                                              : symptoms.length - 1)
                                      ? ', '
                                      : ''),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar:
            CustomAppBar(), // Assuming CustomAppBar is correctly implemented
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/mainPageImg/grandma.png',
                      width: width * 0.1,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$username님',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '의 건강기록',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '오늘 나의 상태는?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(color: Colors.black),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: userData.isNotEmpty
                              ? [
                                  _buildCategory(
                                      '머리  :', userData['head_symptoms']),
                                  _buildCategory(
                                      '상체  :', userData['upper_body_symptoms']),
                                  _buildCategory(
                                      '하체  :', userData['lower_body_symptoms']),
                                  _buildCategory(
                                      '손/발 :', userData['hand_foot_symptoms']),
                                ]
                              : [
                                  Text(
                                    '오늘 등록된 증상이 없습니다.',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SymtomHistoryAdd(),
                                    ),
                                  );
                                },
                                child: Text(
                                  '더보기',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '혹시 더 아픈 부위가 있으신가요?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Divider(color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '아래 버튼을 이용하여 추가해보세요!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFEB2B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 4,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(20),
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Color(0XFFF0F0F0),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '오늘 나의 상태는?',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('X'),
                                          ),
                                        ],
                                      ),
                                      Divider(color: Colors.black),
                                      SizedBox(
                                        width: 300,
                                        height: 550,
                                        child: SymptomCategory(
                                          onSubmit: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 320,
                            height: 52,
                            child: Center(
                              child: Text(
                                '증상 추가',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
