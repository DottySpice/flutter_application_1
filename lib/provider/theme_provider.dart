import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/theme_settings.dart';
import 'package:flutter_application_1/settings/styles.settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeData get currentTheme => _currentTheme;

  ThemeData temaClaro = ThemeData.light();
  ThemeData temaOscuro = ThemeData.dark();
  ThemeData temaPersonalizado = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(primary: Colors.green, secondary: Colors.red));

  ThemeProvider(bool isDark, bool isLight) {
    if (isDark) {
      _currentTheme = temaOscuro;
    } else {
      if (isLight) {
        _currentTheme = temaClaro;
      } else {
        _currentTheme = temaPersonalizado;
      }
    }
  }

  void cambiarTemaOscuro() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (_currentTheme == temaClaro || _currentTheme == temaPersonalizado) {
      _currentTheme = temaOscuro;
      sharedPreferences.setBool('is_dark', true);
      sharedPreferences.setBool('is_light', false);
    }
    notifyListeners();
  }

  void cambiarTemaClaro() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (_currentTheme == temaOscuro || _currentTheme == temaPersonalizado) {
      _currentTheme = temaClaro;
      sharedPreferences.setBool('is_dark', false);
      sharedPreferences.setBool('is_light', true);
    }
    notifyListeners();
  }

  void cambiarTemaPersonalizado() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (_currentTheme == temaClaro || _currentTheme == temaOscuro) {
      _currentTheme = temaPersonalizado;
      sharedPreferences.setBool('is_dark', false);
      sharedPreferences.setBool('is_light', false);
    }
    notifyListeners();
  }
}
