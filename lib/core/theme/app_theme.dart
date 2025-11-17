import 'package:controle_de_abastecimento/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppPalette.secondary,
      onPrimary: Colors.white,
      secondary: AppPalette.accent, 
      onSecondary: Colors.black,
      error: AppPalette.error,
      onError: Colors.white,
      background: AppPalette.dominant,
      onBackground: Colors.white,
      surface: AppPalette.surface,
      onSurface: Colors.white,
      primaryContainer: const Color(0xFF312E81),
      onPrimaryContainer: Colors.white,
      secondaryContainer: const Color(0xFFFEF3C7),
      onSecondaryContainer: Colors.black,
      surfaceVariant: AppPalette.surfaceVariant,
      onSurfaceVariant: const Color(0xFFE5E7EB),
      outline: AppPalette.outline,
      shadow: Colors.black,
      inverseSurface: Colors.white,
      onInverseSurface: Colors.black,
      inversePrimary: AppPalette.accent,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppPalette.dominant,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        centerTitle: true,
        elevation: 0,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppPalette.accent,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppPalette.accent,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: AppPalette.accent, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),

      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        iconColor: AppPalette.accent,
      ),

      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
