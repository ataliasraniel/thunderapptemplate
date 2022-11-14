import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static void saveIsFirstTime() async {
    const String loadedKey = 'loadedFirstTime';
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(loadedKey)) {
      prefs.setBool(loadedKey, false);
    } else {
      prefs.setBool(loadedKey, true);
    }
  }

  static void saveTheme(bool theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', theme);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getBool('isDarkTheme')!;
    } catch (e) {
      return false;
    }
  }

  static void resetAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
