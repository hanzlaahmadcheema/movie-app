import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import 'native_player_ui_state.dart';

class NativePlayerProgressBar extends StatelessWidget {
  const NativePlayerProgressBar({
    required this.state,
    required this.onSeek,
    super.key,
  });

  final NativePlayerUiState state;
  final ValueChanged<Duration> onSeek;

  @override
  Widget build(BuildContext context) {
    final durationMs = state.duration.inMilliseconds;
    final positionMs = state.position.inMilliseconds.clamp(0, durationMs);
    return SizedBox(
      height: 32,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: Colors.white24,
          thumbColor: AppColors.primary,
          overlayColor: AppColors.primary.withValues(alpha: 0.18),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
          trackHeight: 3.2,
        ),
        child: Slider(
          value: durationMs > 0 ? positionMs.toDouble() : 0,
          max: durationMs > 0 ? durationMs.toDouble() : 1,
          onChanged: state.canSeek
              ? (value) => onSeek(Duration(milliseconds: value.round()))
              : null,
        ),
      ),
    );
  }
}
