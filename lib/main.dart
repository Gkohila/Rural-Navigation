import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
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
      home: const HomeScreen(),
    );
  }
}
