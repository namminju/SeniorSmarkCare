import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('Symtom');

class SymtomHistoryAdd extends StatefulWidget {
  @override
  _SymtomHistoryAdd createState() => _SymtomHistoryAdd();
}

class _SymtomHistoryAdd extends State<SymtomHistoryAdd> {
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
          _logger.warning('Failed to load user data: ${response.statusCode}');
        }
      } catch (e) {
        _logger.severe('Error loading user data: $e');
      }
    } else {
      _logger.warning('Token not found');
    }
  }

  Widget _buildCategory(String category, List? symptoms) {
    return symptoms != null && symptoms.isNotEmpty
        ? Container(
            width: 320,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 240, 240),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(
                    symptoms.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${symptoms[index]['display_name']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text(
                  '$username님의 오늘의 건강 기록',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.black,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: userData.isNotEmpty
                              ? [
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                  ),
                                  _buildCategory(
                                      '머리', userData['head_symptoms']),
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                  ),
                                  _buildCategory(
                                      '상체', userData['upper_body_symptoms']),
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                  ),
                                  _buildCategory(
                                      '하체', userData['lower_body_symptoms']),
                                  const Padding(
                                    padding: EdgeInsets.all(8),
                                  ),
                                  _buildCategory(
                                      '손/발', userData['hand_foot_symptoms']),
                                  const Padding(
                                    padding: EdgeInsets.all(20),
                                  ),
                                ]
                              : [
                                  const Padding(
                                    padding: EdgeInsets.all(124),
                                  ),
                                  const Text(
                                    '오늘 등록된 증상이 없습니다.',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(148),
                                  ),
                                ],
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
    );
  }
}
