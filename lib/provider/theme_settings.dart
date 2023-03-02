import 'package:flutter/material.dart';

class ThemeSettings extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeData get currentTheme => currentTheme;

  void toggleTheme() {
    if (_currentTheme == ThemeData.light()) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }
  }
}
