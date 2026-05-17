import 'package:flutter/material.dart';

import '../app/app_theme.dart';

enum AppSnackbarType { success, warning, danger }

class AppSnackbar extends StatelessWidget {
  const AppSnackbar({required this.message, required this.type, super.key});

  final String message;
  final AppSnackbarType type;

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      AppSnackbarType.success => AppColors.success,
      AppSnackbarType.warning => AppColors.warning,
      AppSnackbarType.danger => AppColors.danger,
    };

    return Container(
      width: 313,
      constraints: const BoxConstraints(minHeight: 63),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        message,
        style: AppTextStyles.normal.copyWith(
          color: type == AppSnackbarType.warning ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
