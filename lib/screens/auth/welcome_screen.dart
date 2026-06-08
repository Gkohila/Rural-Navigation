import 'package:flutter/material.dart';
import 'login_screen.dart';

import '../../localization/app_localizations.dart';


import 'package:provider/provider.dart';
import '../../localization/language_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
late Animation<double> _fadeAnimation;
late Animation<double> _scaleAnimation;

  @override
void initState() {
  super.initState();

  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  _fadeAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  _scaleAnimation = Tween<double>(
    begin: 0.7,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ),
  );

  _controller.forward();


}

 
 @override
void dispose() {
  _controller.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    final languageCode =
    context.watch<LanguageProvider>()
        .languageCode;

final lang =
    AppLocalizations(languageCode);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/welcome_bg.png',
            fit: BoxFit.cover,
          ),

          // Dark Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.15),
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.55),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                // Logo Circle
                FadeTransition(
  opacity: _fadeAnimation,
  child: ScaleTransition(
    scale: _scaleAnimation,
    child: Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white54,
          width: 1.5,
        ),
      ),
      child: const Icon(
        Icons.explore_outlined,
        color: Colors.white,
        size: 35,
      ),
    ),
  ),
),

                const SizedBox(height: 40),

                FadeTransition(
  opacity: _fadeAnimation,
  child: Text(
    lang.text('title'),
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          blurRadius: 10,
          color: Colors.black54,
          offset: Offset(0, 2),
        ),
      ],
    ),
  ),
),

const SizedBox(height: 12),

                FadeTransition(
  opacity: _fadeAnimation,
  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    lang.text('subtitle'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.4,
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 35),

                // Language Toggle
                FadeTransition(
  opacity: _fadeAnimation,
  child: Container(
                  width: 240,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white54),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {

  await context
      .read<LanguageProvider>()
      .changeLanguage('en');
},
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: languageCode == 'en'
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                lang.text('english'),
                                style: TextStyle(
                                  color: languageCode == 'en'
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {

  await context
      .read<LanguageProvider>()
      .changeLanguage('ta');
},
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: languageCode == 'ta'
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                lang.text('tamil'),
                                style: TextStyle(
                                  color: languageCode == 'ta'
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
                const Spacer(),

                // Get Started Button
                FadeTransition(
  opacity: _fadeAnimation,
  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang.text('getStarted'),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      color: Colors.white70,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      lang.text('poweredBy'),
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}