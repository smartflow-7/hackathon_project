import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeUserManager {
  static const String _keyFirstTime = 'is_first_time';

  /// Checks if this is the first time the user has opened the app
  /// Returns true if first time, false otherwise
  static Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstTime) ?? true;
  }

  /// Marks that the user has opened the app (no longer first time)
  /// Call this after showing onboarding or welcome screen
  static Future<void> setNotFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstTime, false);
  }

  /// Resets the first time flag (useful for testing or if user wants to see intro again)
  static Future<void> resetFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstTime, true);
  }

  /// Clears all app preferences
  static Future<void> clearAllPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
