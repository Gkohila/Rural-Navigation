import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smartnav/features/maps/services/notification_service.dart';

import 'screens/auth/login_screen.dart';
import 'theme/app_theme.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/auth/welcome_screen.dart';

import 'package:provider/provider.dart';
import 'localization/language_provider.dart';

import 'providers/profile_provider.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  SystemChrome.setSystemUIOverlayStyle(

    const SystemUiOverlayStyle(

      statusBarColor: Colors.transparent,

      statusBarIconBrightness:
          Brightness.dark,
    ),
  );

  final languageProvider = LanguageProvider();

await languageProvider.loadLanguage();

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

    child: const SmartNavApp(),
  ),
);
}

class SmartNavApp extends StatelessWidget {
  const SmartNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.light,

  locale: Locale(
    languageProvider.languageCode,
  ),

  home: const WelcomeScreen(),
);
      },
    );
  }
}