import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F0B1E),
      fontFamily: 'SF',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
    );
  }
}