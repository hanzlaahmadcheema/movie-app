import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';

class NativePlayerErrorState extends StatelessWidget {
  const NativePlayerErrorState({
    required this.visible,
    required this.message,
    required this.onRetry,
    this.onOpenWebFallback,
    this.onTryNextServer,
    super.key,
  });

  final bool visible;
  final String message;
  final VoidCallback onRetry;
  final VoidCallback? onOpenWebFallback;
  final VoidCallback? onTryNextServer;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }
    return ColoredBox(
      color: Colors.black87,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 34, color: Colors.white70),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.normal,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: onRetry,
                    child: const Text('Retry Native'),
                  ),
                  if (onOpenWebFallback != null)
                    FilledButton(
                      onPressed: onOpenWebFallback,
                      child: const Text('Open Jellyfin Web Player'),
                    ),
                  if (onTryNextServer != null)
                    TextButton(
                      onPressed: onTryNextServer,
                      child: const Text('Try Next Server'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
