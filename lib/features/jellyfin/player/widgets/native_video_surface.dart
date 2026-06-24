import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../app/app_theme.dart';

class NativeVideoSurface extends StatelessWidget {
  const NativeVideoSurface({
    required this.controller,
    required this.isInitialized,
    required this.title,
    this.aspectRatio = 16 / 9,
    super.key,
  });

  final VideoPlayerController? controller;
  final bool isInitialized;
  final String title;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final playerController = controller;
    if (!isInitialized || playerController == null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.surface.withValues(alpha: 0.92), Colors.black],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.play_circle_outline,
                  size: 52,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final resolvedAspectRatio = playerController.value.aspectRatio > 0
        ? playerController.value.aspectRatio
        : aspectRatio;
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          aspectRatio: resolvedAspectRatio,
          child: VideoPlayer(playerController),
        ),
      ),
    );
  }
}
