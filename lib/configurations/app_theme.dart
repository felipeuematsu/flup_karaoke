import 'package:flutter/material.dart';

class AppTheme {
  static const _darkBlue = Color(0xFF265db3);
  static const _mediumBlue = Color(0xFF359bca);
  static const _mediumGreen = Color(0xFF58a434);
  static const _lightGreen = Color(0xFFa6e388);

  static final themeDataFromFinnBlue = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _darkBlue,
      secondary: _mediumGreen,
      secondaryContainer: _lightGreen,
      onSecondary: Colors.black,
      onSecondaryContainer: Colors.black,
      background: Colors.grey.shade200,
    ),
  ).copyWith(
      progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: _mediumGreen,
    circularTrackColor: _mediumGreen,
    linearTrackColor: _mediumGreen,
  ));
}
