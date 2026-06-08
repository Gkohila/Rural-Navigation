import 'app_strings.dart';

class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  String text(String key) {
    return AppStrings.strings[languageCode]?[key] ??
        AppStrings.strings['en']?[key] ??
        key;
  }
}