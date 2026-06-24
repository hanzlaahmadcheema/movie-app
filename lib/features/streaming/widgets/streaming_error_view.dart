import 'package:flutter/material.dart';

class StreamingErrorView extends StatelessWidget {
  const StreamingErrorView({
    required this.title,
    required this.message,
    required this.onBack,
    this.onRetry,
    this.onRetryCurrent,
    this.onTryNext,
    this.retryAllLabel = 'Retry',
    this.actionsEnabled = true,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback onBack;
  final VoidCallback? onRetry;
  final VoidCallback? onRetryCurrent;
  final VoidCallback? onTryNext;
  final String retryAllLabel;
  final bool actionsEnabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.live_tv_outlined, size: 54, color: Colors.white70),
            const SizedBox(height: 18),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                if (onRetry != null)
                  FilledButton.icon(
                    onPressed: actionsEnabled ? onRetry : null,
                    icon: const Icon(Icons.refresh),
                    label: Text(retryAllLabel),
                  ),
                if (onRetryCurrent != null)
                  OutlinedButton.icon(
                    onPressed: actionsEnabled ? onRetryCurrent : null,
                    icon: const Icon(Icons.replay),
                    label: const Text('Retry Current Server'),
                  ),
                if (onTryNext != null)
                  OutlinedButton.icon(
                    onPressed: actionsEnabled ? onTryNext : null,
                    icon: const Icon(Icons.skip_next),
                    label: const Text('Try Next Server'),
                  ),
                OutlinedButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
