import 'package:flutter/material.dart';
import 'package:simulados_anac/core/theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColorLight: const Color(0XFFFA7240),
    scaffoldBackgroundColor: const Color(0xFFF3F2F8),
    textTheme: AppTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColorLight: const Color(0XFFFA7240),
    scaffoldBackgroundColor: const Color(0xFF1D1D1D),
    textTheme: AppTextTheme.darkTextTheme,
  );
}
