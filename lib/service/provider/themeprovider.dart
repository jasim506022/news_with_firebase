import 'package:flutter/material.dart';
import 'package:newsapps/service/other/themepre.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference themePrefernce = ThemePreference();

  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    themePrefernce.setDartTheme(value);
    notifyListeners();
  }
}
