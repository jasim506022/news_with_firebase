import 'package:flutter/material.dart';

import '../../res/app_constant.dart';
import '../../res/app_string.dart';

/// A ChangeNotifier that manages and persists the app's theme mode

class ThemeModeProvider with ChangeNotifier {
  /// Current theme state (true = dark mode)
  bool _isDarkMode = false;

  /// Returns the current theme mode status
  bool get isDarkTheme => _isDarkMode;

  /// Sets and saves the user's theme preference
  Future<void> setDarkTheme(bool isDark) async {
    await AppConstants.sharedPreferences?.setBool(
      AppString.themeStatusSharePrefer,
      isDark,
    );
    _isDarkMode = isDark;
    notifyListeners();
  }
}

/*

 set setDarkTheme(bool value) {
    _darkTheme = value;
    themePrefernce.setDartTheme(value);
    notifyListeners();
  }

  setDartTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_STATUS, value);
  }
*/