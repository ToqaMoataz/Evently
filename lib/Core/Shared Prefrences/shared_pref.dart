import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class PreferencesHelper {
  static SharedPreferences? _prefs;

  static const String _themeKey = "App_Theme";
  static const String _onboardingSeenKey = 'onboarding_seen';
  static const String _userIdKey = "user_id";

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // ================= Theme =================

  static Future<void> setAppTheme(ThemeMode theme) async {
    if (theme == ThemeMode.system) {
      await _prefs!.remove(_themeKey);
    } else {
      await _prefs!.setString(_themeKey, theme.name);
    }
  }

  static ThemeMode? getAppTheme() {
    final value = _prefs!.getString(_themeKey);
    if (value == null) return null;
    return ThemeMode.values.firstWhere((e) => e.name == value);
  }

  static Future<void> clearTheme() async {
    await _prefs!.remove(_themeKey);
  }

  // ================= User =================

  static Future<void> setActiveUser(String id) async {
    await _prefs!.setString(_userIdKey, id);
  }

  static String? getActiveUser() {
    return _prefs!.getString(_userIdKey);
  }

  static Future<void> clearUser() async {
    await _prefs!.remove(_userIdKey);
  }

  // ================= Onboarding =================

  static Future<void> setOnboardingSeen() async {
    await _prefs!.setBool(_onboardingSeenKey, true);
  }

  static bool isOnboardingSeen() {
    return _prefs!.getBool(_onboardingSeenKey) ?? false;
  }
}
