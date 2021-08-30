import 'package:flutter/material.dart';
import 'package:stunning_tribble/shared/colors.dart';

class AppThemeData {
  static ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(
      shadowColor: Colors.transparent,
    ),
    brightness: Brightness.dark,
    backgroundColor: oil6Color,
    primaryColor: oil6Color,
    primaryColorDark: oil3Color,
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
    appBarTheme: AppBarTheme(
      shadowColor: Colors.transparent,
    ),
    brightness: Brightness.light,
    backgroundColor: oil2Color,
    primaryColor: oil2Color,
    primaryColorDark: oil4Color,
    primaryColorLight: oil5Color,
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 80.0,
        color: oil1Color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
