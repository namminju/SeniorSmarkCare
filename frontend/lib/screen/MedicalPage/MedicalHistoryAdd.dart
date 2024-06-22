import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';
import 'dart:convert';

class MedicalHistoryAdd extends StatefulWidget {
  @override
  _MedicalHistoryAdd createState() => _MedicalHistoryAdd();
}

class _MedicalHistoryAdd extends State<MedicalHistoryAdd> {
  String username = '';
  late String hospitalCall = '';
  List<dynamic> history = [];
  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadMedialHistory();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  Future<void> _loadMedialHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/medical/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var Data = json.decode(response.body);
          setState(() {
            history = Data;
          });
          print(history);
          //print(history[0]);
          //print(history[0]['reservationDate']);
        } else {
          print('Failed to load user data: ${response.statusCode}');
          // Handle failure
        }
      } catch (e) {
        print('Error loading user data: $e');
        // Handle exceptions
      }
    } else {
      print('Token not found');
      // Handle case where token is not available
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: const CustomAppBar(),
      body: Column(
        // Column 추가
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            // Expanded 추가
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // 세로 정렬을 위로 변경
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                    ),
                    Text(
                      '비대면 진료 내역',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '000님의 이전 진료 예약 내역',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  history.isNotEmpty
                                      ? Column(
                                          children: history.reversed
                                              .map((record) => Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: Text(
                                                      '${record['reservationDate']}   ${record['reservationTime']}',
                                                      style: TextStyle(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            '진료기록이 없습니다.',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
