import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/auth/login_screen.dart';

import 'screens/home/home_screen.dart';
import 'screens/navigation/last_mile_screen.dart';

import 'theme/app_theme.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const SmartNavApp());
}

class SmartNavApp extends StatelessWidget {

  const SmartNavApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,

      home: LoginScreen(),
    );
  }
}