import 'package:flutter/material.dart';

import '../Caching/Shared Prefrences/shared_pref.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;


  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    ThemeMode? savedTheme =  PreferencesHelper.getAppTheme();
    if (savedTheme != null) {
      themeMode = savedTheme;
    } else {
      themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode mode) async {
    if (themeMode == mode) return;
    themeMode = mode;
    if (mode == ThemeMode.system) {
      await  PreferencesHelper.clearTheme();
    } else {
      await  PreferencesHelper.setAppTheme(mode);
    }
    notifyListeners();
  }
}
