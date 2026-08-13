import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../core/streaming/streaming_embed_request.dart';
import '../../../core/responsive/responsive_context.dart';
import '../../streaming/presentation/streaming_player_screen.dart';

class EmbeddedWatchPlayerPanel extends StatelessWidget {
  const EmbeddedWatchPlayerPanel({
    required this.request,
    required this.selectionPrompt,
    this.topRightActions = const <Widget>[],
    super.key,
  });

  final StreamingEmbedRequest? request;
  final String selectionPrompt;
  final List<Widget> topRightActions;

  @override
  Widget build(BuildContext context) {
    if (request == null) {
      final placeholder = DecoratedBox(
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
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 15 : 0),
        child: context.isMobile
            ? SizedBox(height: 304, child: placeholder)
            : AspectRatio(aspectRatio: 16 / 9, child: placeholder),
      );
    }
    return StreamingPlayerPanel(
      request: request,
      topRightActions: topRightActions,
    );
  }
}
