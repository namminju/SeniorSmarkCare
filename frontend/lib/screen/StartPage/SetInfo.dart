import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/widget/AppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Api/RootUrlProvider.dart';
import 'package:frontend/screen/MyPage/ChangeAddress.dart';
import 'package:frontend/screen/MyPage/ChangeBodyInfo.dart';
import 'package:frontend/screen/MyPage/ChangePhoneNum.dart';
import 'package:frontend/screen/MyPage/ChangeGuardianPhoneNum.dart';
import 'package:frontend/screen/MyPage/ChangeHospitalNum.dart';

import 'package:logging/logging.dart';

class SetInfo extends StatefulWidget {
  const SetInfo({super.key});

  @override
  _SetInfo createState() => _SetInfo();
}

class _SetInfo extends State<SetInfo> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userBirthController = TextEditingController();
  final _userGenderController = TextEditingController();
  final _guardPhoneController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _hospitalCallController = TextEditingController();

  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _roadAddressController = TextEditingController();
  final _buildingNumberController = TextEditingController();
  final _detailedAddressController = TextEditingController();

  late String userName;
  late String userPhone;

  late String userBirth;
  late String userGender;
  late String guardPhone;
  late String height;
  late String weight;
  late String hospitalCall;

  late String postal_code;
  late String city;
  late String district;
  late String neighborhood;
  late String road_address;
  late String building_number;
  late String detailed_address;
  TextEditingController searchController = TextEditingController();
  TextEditingController detailAddressController = TextEditingController();
  late String userAddress = '';
  late String userDetailAddress = '';
  late String query = '';
  List<Map<String, dynamic>> searchData = [];

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
        var response = await http.post(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/address/'),
          headers: headers,
          body: body,
        );
        if (response.statusCode == 201 || response.statusCode == 200) {
          print('send successfully');
          //_showConfirmationDialog();
        } else {
          print('Failed ${response.statusCode}');
          //_showErrorDialog();
        }
      } catch (e) {
        print('Error: $e');
        //_showErrorDialog();
      }
    } else {
      print('Token not found');
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

  Future<void> fetchAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/address/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            postal_code = userData['postal_code']?.toString() ?? ''; //
            city = userData['city']?.toString() ?? '';
            district = userData['district']?.toString() ?? '';
            neighborhood = userData['neighborhood']?.toString() ?? '';
            road_address = userData['road_address']?.toString() ?? '';
            building_number = userData['building_number']?.toString() ?? '';
            detailed_address = userData['detailed_address']?.toString() ?? '';
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

  Future<void> fetchHospitalCall() async {
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

  Future<void> fetchNameNPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/mypage/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            userName = userData['userName']?.toString() ?? '';
            userPhone = userData['userPhone']?.toString() ?? '';
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

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token"
      };

      try {
        var response = await http.get(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/addinfo/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            userBirth = userData['userBirth']?.toString() ?? '';
            userGender = userData['userGender']?.toString() ?? '';
            guardPhone = userData['guardPhone']?.toString() ?? '';
            height = userData['height']?.toString() ?? '';
            weight = userData['weight']?.toString() ?? '';
            // if (userBirth == '0001-01-01') {
            //   userBirth = '미정';
            // }
            // if (userGender == '') {
            //   userGender = '미정';
            // }
            // if (guardPhone == '0100000000') {
            //   guardPhone = '미정';
            // }
            // if (userGender == 'Male') {
            //   userGender = '남성';
            // } else if (userGender == 'Female') {
            //   userGender = '여성';
            // }
            // // 값이 모두 0이면 미정으로 설정
            if (height == '0' && weight == '0') {
              height = '';
              weight = '';
            } else {
              // 하나만 값이 있는 경우 빈 문자열로 초기화
              if (height != '0' && weight == '0') {
                weight = '';
              } else if (height == '0' && weight != '0') {
                height = '';
              }
            }
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

//////////////*             입력 받는 부분 put             *//////////////
  Future<void> updateUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token",
        "Content-Type": "application/json",
      };

      Map<String, dynamic> body = {
        'userBirth': userBirth,
        'userGender': userGender,
        'guardPhone': guardPhone,
        'height': height,
        'weight': weight,
      };

      try {
        var response = await http.put(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/addinfo/'),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          // 업데이트 성공 시 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('정보가 업데이트되었습니다.')),
          );
        } else {
          print('Failed to update user data: ${response.statusCode}');
          // 실패 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('정보 업데이트에 실패하였습니다.')),
          );
        }
      } catch (e) {
        print('Error updating user data: $e');
        // 예외 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('정보 업데이트 중 오류가 발생하였습니다.')),
        );
      }
    } else {
      print('Token not found');
      // 토큰 없을 때 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 토큰이 없습니다. 다시 로그인해주세요.')),
      );
    }
  }

  Future<void> updateNameNPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token",
        "Content-Type": "application/json",
      };

      Map<String, dynamic> body = {
        'userName': userName,
        'userPhone': userPhone,
      };

      try {
        var response = await http.put(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/mypage/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          // 업데이트 성공 시 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('정보가 업데이트되었습니다.')),
          );
        } else {
          print('Failed to update user data: ${response.statusCode}');
          // 실패 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('정보 업데이트에 실패하였습니다.')),
          );
        }
      } catch (e) {
        print('Error updating user data: $e');
        // 예외 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('정보 업데이트 중 오류가 발생하였습니다.')),
        );
      }
    } else {
      print('Token not found');
      // 토큰 없을 때 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 토큰이 없습니다. 다시 로그인해주세요.')),
      );
    }
  }

  Future<void> updateAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Map<String, String> headers = {
        "accept": "*/*",
        "Authorization": "Token $token",
        "Content-Type": "application/json",
      };

      Map<String, dynamic> body = {
        'postal_code': postal_code,
        'city': city,
        'district': district,
        'neighborhood': neighborhood,
        'road_address': road_address,
        'building_number': building_number,
        'detailed_address': detailed_address,
      };

      try {
        var response = await http.put(
          Uri.parse('${RootUrlProvider.baseURL}/accounts/addinfo/'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          // 업데이트 성공 시 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('정보가 업데이트되었습니다.')),
          );
        } else {
          print('Failed to update user data: ${response.statusCode}');
          // 실패 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('정보 업데이트에 실패하였습니다.')),
          );
        }
      } catch (e) {
        print('Error updating user data: $e');
        // 예외 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('정보 업데이트 중 오류가 발생하였습니다.')),
        );
      }
    } else {
      print('Token not found');
      // 토큰 없을 때 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인 토큰이 없습니다. 다시 로그인해주세요.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchNameNPhone();
    fetchHospitalCall();
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      hintText: label,
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    '개인 정보 설정',
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '성명',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _userNameController,
                      decoration: _buildInputDecoration('성명'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '이름을 입력해주세요';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '생년월일',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _userBirthController,
                      decoration: _buildInputDecoration(''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '앓고있는 지병',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      //controller: _diseaseController,
                      decoration: _buildInputDecoration('어디아프세요'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter known diseases';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    const Text(
                      '신장',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _heightController,
                      decoration: _buildInputDecoration('cm'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your body information';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '몸무게',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _weightController,
                      decoration: _buildInputDecoration('kg'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your body information';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _userGenderController,
                      decoration: _buildInputDecoration('남/여'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '사용자 전화번호',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _userPhoneController,
                      decoration: _buildInputDecoration('전화번호'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '보호자 전화번호',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _guardPhoneController,
                      decoration: _buildInputDecoration('010-0000-0000'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter guardian\'s phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '주 병원 전화번호',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: _hospitalCallController,
                      decoration: _buildInputDecoration('--'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter hospital\'s phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       // Process data
                    //       print("Name: ${_nameController.text}");
                    //       print("DOB: ${_dobController.text}");
                    //       print("Known Diseases: ${_diseaseController.text}");
                    //       print("Address: ${_addressController.text}");
                    //       print("Body Info: ${_bodyInfoController.text}");
                    //       print("Gender: ${_genderController.text}");
                    //       print("Phone: ${_phoneController.text}");
                    //       print(
                    //           "Guardian Phone: ${_guardianPhoneController.text}");
                    //       print(
                    //           "Hospital Phone: ${_hospitalPhoneController.text}");
                    //     }
                    //   },
                    //   child: const Text('Submit'),
                    // ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 254, 178, 178),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 1,
                ),
                onPressed: () {
                  _sendAddress(userAddress, detailAddressController.text);
                },
                child: const SizedBox(
                  width: 320,
                  height: 52,
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
            ],
          ),
        ),
      ),
    );
  }
}
