import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  // Change only this IP when your laptop IP changes
  static const String laptopIp = "192.168.2.47";
  static const int port = 8081;

  static String get baseUrl {
    // Chrome
    if (kIsWeb) {
      return "http://localhost:$port";
    }

    // Android
    if (Platform.isAndroid) {
      // Real Android Phone
      return "http://$laptopIp:$port";

      // Emulator use this instead:
      // return "http://10.0.2.2:$port";
    }

    // iOS Simulator (future)
    return "http://localhost:$port";
  }
}