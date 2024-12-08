import 'package:flutter/material.dart';
import 'package:flutter_weather_app/presentation/palette.dart';
import 'package:flutter_weather_app/presentation/text_theme.dart';

ThemeData createTheme() {
  const ColorScheme colorScheme = ColorScheme.light(
    primary: Palette.primary,
    onPrimary: Palette.onPrimary,
    secondary: Palette.secondary,
    onSecondary: Palette.onSecondary,
    error: Palette.error,
    onError: Palette.onError,
    surface: Palette.surface,
    onSurface: Palette.onSurface,
    onSurfaceVariant: Palette.onSurfaceVariant,
    surfaceContainer: Palette.surfaceContainer,
    shadow: Palette.shadow,
  );

  final TextTheme textTheme = createTextTheme(colorScheme);

  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    scaffoldBackgroundColor: Colors.transparent,

    // App Bar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: textTheme.headlineMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
      surfaceTintColor: null,
      elevation: 0,
      scrolledUnderElevation: 0.0,
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      modalBarrierColor: colorScheme.secondary.withOpacity(0.8),
      modalElevation: 2,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: colorScheme.surface,
      thickness: 1.0,
    ),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      insetPadding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: colorScheme.surfaceContainer,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: createInputDecorationScheme(
      colorScheme,
      null,
      textTheme,
    ),

    // Text Selection Theme
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colorScheme.primary,
      selectionColor: colorScheme.primary.withOpacity(0.4),
      selectionHandleColor: colorScheme.primary,
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        textStyle: textTheme.bodyMedium,
      ),
    ),
  );
}

InputDecorationTheme createInputDecorationScheme(ColorScheme colorScheme,
    dynamic supplementaryColorsExtension,
    TextTheme textTheme,) {
  return InputDecorationTheme(
    filled: true,
    fillColor: colorScheme.surfaceContainer,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: colorScheme.secondary, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: colorScheme.secondary, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: colorScheme.secondary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: colorScheme.error, width: 2),
    ),
  );
}
