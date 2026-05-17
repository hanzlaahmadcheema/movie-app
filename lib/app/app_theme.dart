import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF121315);
  static const appBar = Color(0xFF0B0B0D);
  static const surface = Color(0xFF191B20);
  static const surfaceAlt = Color(0xFF242426);
  static const primary = Color(0xFF0FEFFD);
  static const primaryMuted = Color(0x80089099);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xCCFFFFFF);
  static const danger = Color(0xFFFF4D67);
  static const warning = Color(0xFFFFC857);
  static const success = Color(0xFF39D98A);
}

class AppTextStyles {
  static const String fontFamily = 'Pathway Extreme';

  static const title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1,
    letterSpacing: 0,
  );

  static const medium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1,
    letterSpacing: 0,
  );

  static const normal = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: 0,
  );

  static const small = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 0,
  );

  static const button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 0,
  );

  static const tag = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 0,
  );
}

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      textTheme:
          const TextTheme(
            titleLarge: AppTextStyles.title,
            titleMedium: AppTextStyles.medium,
            bodyMedium: AppTextStyles.normal,
            bodySmall: AppTextStyles.small,
            labelLarge: AppTextStyles.button,
          ).apply(
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          ),
    );
  }
}
