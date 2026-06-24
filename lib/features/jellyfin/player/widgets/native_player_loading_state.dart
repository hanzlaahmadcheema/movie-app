import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';

class NativePlayerLoadingState extends StatelessWidget {
  const NativePlayerLoadingState({
    required this.visible,
    this.message = 'Preparing Jellyfin stream...',
    super.key,
  });

  final bool visible;
  final String message;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }
    return ColoredBox(
      color: Colors.black45,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 2.4),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
