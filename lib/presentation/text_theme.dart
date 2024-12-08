import 'package:flutter/material.dart';

TextTheme createTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: colorScheme.onSurfaceVariant,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: colorScheme.primary,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: colorScheme.onPrimary,
    ),
  );
}