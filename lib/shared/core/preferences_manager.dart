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

  static void resetAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
