import 'package:flutter/material.dart';

class StylesSettings {
  static ThemeData lightTheme() {
    final theme = ThemeData.light();
    return theme;
  }

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return theme;
  }

  static ThemeData userTheme(BuildContext context) {
    final theme = ThemeData.dark();
    return theme.copyWith(
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(primary: Color.fromARGB(255, 4, 155, 24)));
  }
}
