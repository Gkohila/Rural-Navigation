import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartnav/features/maps/screens/route_search_screen.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';

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

/// Tenkasi SmartNav application entry point.
class SmartNavApp extends StatelessWidget {
  const SmartNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tenkasi SmartNav',
      debugShowCheckedModeBanner: false,
      theme: SmartNavTheme.light,
      home: const RouteSearchScreen(),
    );
  }
}
