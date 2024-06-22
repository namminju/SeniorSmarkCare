import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/MainScreen.dart';
import 'package:frontend/screen/LoginPage/Login.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  runApp(const MyApp());
}

void _logToConsole(LogRecord record) {
  final message = '${record.level.name}: ${record.time}: ${record.message}';
  // print 대신 아래와 같이 로그 메시지를 콘솔에 기록하는 다른 방법 사용
  debugPrint(message);
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // 로그 레벨 설정
  Logger.root.onRecord.listen((record) {
    _logToConsole(record);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            // 에러 처리 로직 추가
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('에러 발생!'),
                ),
              ),
            );
          } else {
            bool isLoggedIn = snapshot.data ?? false;
            return MaterialApp(
              title: '홀로똑똑',

              home: isLoggedIn ? const MainScreen() : const Login(),

            );
          }
        }
      },
    );
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // token이 있는지 여부에 따라 로그인 상태를 판단할 수 있음
    return token != null && token.isNotEmpty;
  }
}
