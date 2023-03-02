import 'package:advance_flutter/presentation/resources/language_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  static const String PREFS_KEY_LANG = "PREFS_KEY_LANG";

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      // return default lang
      return LanguageType.ENGLISH.getValue();
    }
  }
}
