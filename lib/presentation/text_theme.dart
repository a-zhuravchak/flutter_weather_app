import 'package:flutter/material.dart';

TextTheme createTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: colorScheme.onPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: colorScheme.onPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: colorScheme.onPrimary,
    ),
    labelSmall: TextStyle(
      fontSize: 8,
      color: colorScheme.onPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: colorScheme.onPrimary,
    ),
    labelLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: colorScheme.onPrimary,
    ),
  );
}
