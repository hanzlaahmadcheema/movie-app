import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../core/streaming/streaming_embed_request.dart';
import '../../streaming/presentation/streaming_player_screen.dart';

class EmbeddedWatchPlayerPanel extends StatelessWidget {
  const EmbeddedWatchPlayerPanel({
    required this.request,
    required this.selectionPrompt,
    super.key,
  });

  final StreamingEmbedRequest? request;
  final String selectionPrompt;

  @override
  Widget build(BuildContext context) {
    if (request == null) {
      return Container(
        height: 304,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              selectionPrompt,
              textAlign: TextAlign.center,
              style: AppTextStyles.normal.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      );
    }
    return StreamingPlayerPanel(request: request);
  }
}
