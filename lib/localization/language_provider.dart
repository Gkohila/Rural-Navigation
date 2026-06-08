import 'package:flutter/material.dart';
import '../features/maps/services/language_service.dart';

class LanguageProvider extends ChangeNotifier {
  String _languageCode = 'en';

  String get languageCode => _languageCode;

  bool get isEnglish => _languageCode == 'en';

  Future<void> loadLanguage() async {
    _languageCode =
        await LanguageService.loadLanguage();

    notifyListeners();
  }

  Future<void> changeLanguage(String code) async {
    _languageCode = code;

    await LanguageService.saveLanguage(code);

    notifyListeners();
  }
}