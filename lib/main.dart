import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'screens/auth/welcome_screen.dart';
import 'providers/profile_provider.dart';
import 'localization/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home/home_screen.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs =
      await SharedPreferences.getInstance();

  bool isLoggedIn =
      prefs.getBool("isLoggedIn") ?? false;

  final languageProvider =
      LanguageProvider();

  await languageProvider.loadLanguage();

  SystemChrome.setSystemUIOverlayStyle(

    const SystemUiOverlayStyle(

      statusBarColor: Colors.transparent,

      statusBarIconBrightness:
          Brightness.dark,

    ),

  );

  runApp(

    MultiProvider(

      providers: [

        ChangeNotifierProvider.value(

          value: languageProvider,

        ),

        ChangeNotifierProvider(

          create: (_) => ProfileProvider(),

        ),

      ],

      child: SmartNavApp(

        isLoggedIn: isLoggedIn,

      ),

    ),

  );

}

class SmartNavApp extends StatelessWidget {

  final bool isLoggedIn;

  const SmartNavApp({

    super.key,

    required this.isLoggedIn,

  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: isLoggedIn
    ? const HomeScreen()
    : const WelcomeScreen(),
        );
      },
    );
  }
}