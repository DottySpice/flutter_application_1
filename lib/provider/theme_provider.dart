import 'package:flutter/material.dart';
import 'package:flutter_application_1/settings/styles.settings.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;
  ThemeProvider(BuildContext context) {
    _themeData = StylesSettings.lightTheme(context);
  }

  getThemeData() => this._themeData;
  setThemeData(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}
