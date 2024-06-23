import 'package:flutter/foundation.dart' show kIsWeb;

class RootUrlProvider {
  static String get baseURL {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    } else {
      return 'http://192.168.0.6:8000';
    }
  }
}
