import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/auth/login_screen.dart';
import 'theme/app_theme.dart';
import 'screens/profile/profile_screen.dart';
import 'package:smartnav/features/maps/services/notification_service.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
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
      title: 'Tenkasi SmartNav',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,

      home: const LoginScreen(),
    );
  }
}