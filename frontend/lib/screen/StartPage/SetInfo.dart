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
                    const Text(
                      '거주지',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      //controller: _addressController,
                      decoration: _buildInputDecoration(''),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
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
                onPressed: () {},
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
