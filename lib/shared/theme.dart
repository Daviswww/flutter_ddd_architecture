import 'package:flutter/material.dart';
import 'package:stunning_tribble/shared/colors.dart';

class AppThemeData {
  static ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: oil6Color,
    primaryColorDark: oil2Color,
    primaryColorLight: oil5Color,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 80.0,
        color: oil2Color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    backgroundColor: oil2Color,
    primaryColorDark: oil2Color,
    primaryColorLight: oil5Color,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 80.0,
        color: oil5Color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
