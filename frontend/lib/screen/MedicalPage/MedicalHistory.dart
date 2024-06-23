import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:frontend/screen/MedicalPage/MedicalHistoryAdd.dart';

import 'package:frontend/widget/AppBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String day = DateFormat('yyyy-MM-dd').format(now);
String time = DateFormat('HH:mm').format(now);

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  String username = '';
  late String hospitalCall = '';
  List<dynamic> history = [];

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _loadHospitalCall();
    _loadMedicalHistory();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  Future<void> _loadMedicalHistory() async {
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
          var data = json.decode(response.body);
          setState(() {
            history = data;
          });
        } else {
          print('Failed to load medical history: ${response.statusCode}');
        }
      } catch (e) {
        print('Error loading medical history: $e');
      }
    } else {
      print('Token not found');
    }
  }

  Future<void> _loadHospitalCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/hospital/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            hospitalCall = userData['hospitalCall']?.toString() ?? '';
          });
        } else {
          print('Failed to load hospital call number: ${response.statusCode}');
        }
      } catch (e) {
        print('Error loading hospital call number: $e');
      }
    } else {
      print('Token not found');
    }
  }

  Future<void> sendAppointment(
      String reservationDate, String reservationTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      var body = json.encode({
        'reservationDate': reservationDate,
        'reservationTime': reservationTime,
        "isDone": true
      });
      print(body);

      try {
        var response = await http.post(
          Uri.parse('${RootUrlProvider.baseURL}/medical/'),
          headers: headers,
          body: body,
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          print('Appointment created successfully');
        } else {
          print('Failed to create appointment: ${response.statusCode}');
        }
      } catch (e) {
        print('Error creating appointment: $e');
      }
    } else {
      print('Token not found');
    }
  }

  void customLaunchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      print('Failed to launch URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                '비대면 진료',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '비대면 진료를 원하시나요?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '아래 버튼을 이용하여 진료를 받아보세요!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEB2B2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          sendAppointment(day, time);
                          customLaunchUrl('tel:$hospitalCall');
                        },
                        child: const SizedBox(
                          width: 320,
                          height: 52,
                          child: Center(
                            child: Text(
                              '진료하러 가기',
                              style: TextStyle(
                                fontSize: 25,
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
                              '$username님의 이전 진료 예약 내역',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              '(최근 3개월)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Center(
                        child: Column(
                          children: history.isNotEmpty
                              ? history.reversed
                                  .take(3)
                                  .map((record) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          '${record['reservationDate']}   ${record['reservationTime']}',
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ))
                                  .toList()
                              : [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      '진료 기록이 없습니다.',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MedicalHistoryAdd()),
                                );
                              },
                              child: const Text(
                                '더 보기',
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
            ],
          ),
        ),
      ),
    );
  }
}
