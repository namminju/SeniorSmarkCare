import 'package:flutter/foundation.dart';

class RootUrlProvider extends ChangeNotifier {
  String _rootUrl = 'http://127.0.0.1:8000';

  String get rootUrl => _rootUrl;

  set rootUrl(String url) {
    _rootUrl = url;
    notifyListeners(); // 상태 변경을 감지하도록 알림
  }
}
