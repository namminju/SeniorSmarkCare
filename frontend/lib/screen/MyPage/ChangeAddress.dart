import 'package:flutter/material.dart';
import 'package:frontend/widget/AppBar.dart'; // AppBar.dart를 widgets 폴더 안에 있는 것으로 수정 필요
import 'package:frontend/widgets/NoticeDialog.dart'; // widgets 폴더 안에 있는 NoticeDialog.dart로 수정 필요
import 'dart:convert';
import 'package:flutter/material.dart'; // 중복된 import 제거
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';

class ChangeAddress extends StatefulWidget {
  @override
  _ChangeAddress createState() => _ChangeAddress();
}

class _ChangeAddress extends State<ChangeAddress> {
  TextEditingController searchController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  late String originUserAddress = '';
  late String userAddress = '';
  late String userDetailAddress = '';
  late String query = '';
  List<Map<String, dynamic>> searchData = [];
  @override
  void initState() {
    super.initState();
    fetchUserAddress();
  }

  Future<void> _sendAddress(
      String userAddress, String userDetailAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      var body = json.encode({
        "postal_code": "",
        "city": userAddress,
        "district": "",
        "neighborhood": "",
        "road_address": "",
        "building_number": "",
        "detailed_address": userDetailAddress
      });
      print(headers);
      print(body);

      try {
        var response = await http.put(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/address/my'),
          headers: headers,
          body: body,
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          print('send successfully');
          _showConfirmationDialog();
        } else {
          print('Failed ${response.statusCode}');
          _showErrorDialog();
        }
      } catch (e) {
        print('Error: $e');
        _showErrorDialog();
      }
    } else {
      print('Token not found');
    }
  }

  Future<void> fetchUserAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print(query);
    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/address/my'),
          headers: headers,
        );
        var utf8Data = utf8.decode(response.bodyBytes);

        if (response.statusCode == 200) {
          var userData = json.decode(utf8Data);
          setState(() {
            originUserAddress = userData['city']?.toString() ?? '';
            /*originUserAddress += ' ';
            originUserAddress += userData['district']?.toString() ?? '';
            originUserAddress += ' ';
            originUserAddress += userData['neighborhood']?.toString() ?? '';
            originUserAddress += ' ';
            originUserAddress += userData['road_address']?.toString() ?? '';
            originUserAddress += ' ';
            originUserAddress += userData['building_number']?.toString() ?? '';
            */
            userDetailAddress = userData['detailed_address']?.toString() ?? '';
          });
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

  void _showAddressSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                width: 288,
                height: 256,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF0F0F0),
                              hintText: '찾고자하는 주소',
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFEB2B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            elevation: 1,
                          ),
                          onPressed: () async {
                            query = searchController.text;
                            await searchAddress();
                            setState(() {}); // 검색 결과가 변경되었음을 알림
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 4),
                            child: Text(
                              '찾기',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    buildSearchDataWidget(), // 여기에 buildSearchDataWidget() 추가
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSearchDataWidget() {
    return Container(
      height: 180, // 세로 크기 지정
      child: ListView.builder(
        itemCount: searchData.length,
        itemBuilder: (context, index) {
          var prediction = searchData[index];
          return ListTile(
            title: Text(prediction['description'].replaceAll('대한민국 ', '')),
            onTap: () {
              // Handle tap on prediction
              setState(() {
                userAddress = prediction['description'].replaceAll('대한민국 ', '');
              });
              print(prediction['description']);
              print(prediction['structured_formatting']['secondary_text']);
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
          );
        },
      ),
    );
  }

  Future<void> searchAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse(
              '${RootUrlProvider.baseURL}/accounts/address/search/?query=$query'),
          headers: headers,
        );
        var utf8Data = utf8.decode(response.bodyBytes);

        if (response.statusCode == 200) {
          var data = json.decode(utf8Data);
          if (data.isNotEmpty) {
            setState(() {
              // Clear existing searchData before adding new data
              searchData.clear();
              // Add each prediction to searchData list
              for (var prediction in data["predictions"]) {
                searchData.add(prediction);
              }
            });
            print(searchData);
          }
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoticeDialog(
          text: ' 거주지 변경이\n완료되었습니다.', // 매개변수로 텍스트 전달
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NoticeDialog(
          text: '거주지 변경이 실패하였습니다. 다시 시도해주세요.', // 매개변수로 텍스트 전달
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(), // AppBar.dart에서 이미 AppBar를 반환하므로 const 제거
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.03),
                ),
                Text(
                  '마이페이지',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Text(
                    '[거주지 변경]',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
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
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '기존 등록된 거주지',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            '$originUserAddress \n$userDetailAddress',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 30)),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '변경하고자 하는 거주지',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // 간격을 좁히기 위해 MainAxisAlignment.start 사용
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    userAddress.isEmpty
                                        ? ' 내 주소 찾아보기'
                                        : userAddress,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // 간격 추가
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEB2B2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  elevation: 1,
                                ),
                                onPressed: _showAddressSearchDialog,
                                child: Container(
                                  width: 68,
                                  height: 24,
                                  child: Center(
                                    child: Text(
                                      '찾기',
                                      style: TextStyle(
                                        fontSize: 12,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextField(
                            controller: detailAddressController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF0F0F0),
                              hintText: '상세 주소 입력',
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFEB2B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 4,
                          ),
                          onPressed: () {
                            setState(() {
                              userDetailAddress = detailAddressController.text;
                            });
                            _sendAddress(userAddress, userDetailAddress);
                          },
                          child: Container(
                            width: 320,
                            height: 40,
                            child: Center(
                              child: Text(
                                '저장하기',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
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
