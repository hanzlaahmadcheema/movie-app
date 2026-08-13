import 'package:flutter/material.dart';

export '../core/theme/app_colors.dart';
export '../core/theme/app_radius.dart';
export '../core/theme/app_spacing.dart';
export '../core/theme/app_text_styles.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';

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
      hoverColor: AppColors.primary.withValues(alpha: 0.08),
      focusColor: AppColors.primary.withValues(alpha: 0.12),
      splashColor: AppColors.primary.withValues(alpha: 0.10),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceAlt,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      tooltipTheme: const TooltipThemeData(
        waitDuration: Duration(milliseconds: 400),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _NoAnimationPageTransitionsBuilder(),
          TargetPlatform.iOS: _NoAnimationPageTransitionsBuilder(),
          TargetPlatform.linux: _NoAnimationPageTransitionsBuilder(),
          TargetPlatform.macOS: _NoAnimationPageTransitionsBuilder(),
          TargetPlatform.windows: _NoAnimationPageTransitionsBuilder(),
          TargetPlatform.fuchsia: _NoAnimationPageTransitionsBuilder(),
        },
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

class _NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  const _NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
