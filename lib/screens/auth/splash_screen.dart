import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/home_screen.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    bool isLoggedIn =
        prefs.getBool("isLoggedIn") ?? false;

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    if (isLoggedIn) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );

    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}