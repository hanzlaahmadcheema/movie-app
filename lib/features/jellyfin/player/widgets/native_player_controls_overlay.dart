import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import 'native_player_progress_bar.dart';
import 'native_player_ui_state.dart';

class NativePlayerControlsOverlay extends StatefulWidget {
  const NativePlayerControlsOverlay({
    required this.state,
    required this.title,
    required this.serverLabel,
    required this.onPlayPause,
    required this.onReplay,
    required this.onRewind,
    required this.onForward,
    required this.onMuteToggle,
    required this.onSpeedTap,
    required this.onSeek,
    this.onFullscreen,
    super.key,
  });

  final NativePlayerUiState state;
  final String title;
  final String serverLabel;
  final VoidCallback onPlayPause;
  final VoidCallback onReplay;
  final VoidCallback onRewind;
  final VoidCallback onForward;
  final VoidCallback onMuteToggle;
  final VoidCallback onSpeedTap;
  final ValueChanged<Duration> onSeek;
  final VoidCallback? onFullscreen;

  @override
  State<NativePlayerControlsOverlay> createState() =>
      _NativePlayerControlsOverlayState();
}

class _NativePlayerControlsOverlayState
    extends State<NativePlayerControlsOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      reverseDuration: const Duration(milliseconds: 140),
      value: widget.state.isControlsVisible ? 1 : 0,
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    _fadeAnimation = curved;
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.035),
      end: Offset.zero,
    ).animate(curved);
  }

  @override
  void didUpdateWidget(covariant NativePlayerControlsOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.isControlsVisible == oldWidget.state.isControlsVisible) {
      return;
    }
    if (widget.state.isControlsVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final controlIcon = state.isEnded
        ? Icons.replay
        : (state.isPlaying ? Icons.pause : Icons.play_arrow);
    final controlLabel = state.isEnded
        ? 'Replay'
        : (state.isPlaying ? 'Pause' : 'Play');

    return IgnorePointer(
      ignoring: !state.isControlsVisible,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xB3000000),
                  Color(0x20000000),
                  Color(0xCC000000),
                ],
                stops: [0, 0.45, 1],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 6),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (state.isFullscreen) ...[
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: widget.onFullscreen,
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.small.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                widget.serverLabel,
                                style: AppTextStyles.small.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ControlButton(
                        label: 'Back 10',
                        icon: Icons.replay_10,
                        onPressed: state.isInitialized ? widget.onRewind : null,
                      ),
                      const SizedBox(width: 12),
                      _PrimaryControlButton(
                        label: controlLabel,
                        icon: controlIcon,
                        onPressed: state.isInitialized
                            ? (state.isEnded
                                  ? widget.onReplay
                                  : widget.onPlayPause)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      _ControlButton(
                        label: 'Forward 10',
                        icon: Icons.forward_10,
                        onPressed: state.isInitialized
                            ? widget.onForward
                            : null,
                      ),
                    ],
                  ),
                  const Spacer(),
                  NativePlayerProgressBar(state: state, onSeek: widget.onSeek),
                  Row(
                    children: [
                      Text(
                        formatPlayerDuration(state.position),
                        style: AppTextStyles.small,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '/ ${formatPlayerDuration(state.duration)}',
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        tooltip: state.isMuted ? 'Unmute' : 'Mute',
                        onPressed: state.isInitialized
                            ? widget.onMuteToggle
                            : null,
                        icon: Icon(
                          state.isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        style: IconButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      TextButton(
                        onPressed: state.isInitialized
                            ? widget.onSpeedTap
                            : null,
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        child: Text(
                          '${state.playbackSpeed.toStringAsFixed(2)}x',
                        ),
                      ),
                      if (widget.onFullscreen != null)
                        IconButton(
                          tooltip: state.isFullscreen
                              ? 'Exit Fullscreen'
                              : 'Fullscreen',
                          onPressed: widget.onFullscreen,
                          icon: Icon(
                            state.isFullscreen
                                ? Icons.fullscreen_exit
                                : Icons.open_in_full,
                          ),
                          style: IconButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filledTonal(
          onPressed: onPressed,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withValues(alpha: 0.42),
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.small.copyWith(fontSize: 11)),
      ],
    );
  }
}

class _PrimaryControlButton extends StatelessWidget {
  const _PrimaryControlButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filled(
          onPressed: onPressed,
          icon: Icon(icon, size: 28),
          style: IconButton.styleFrom(
            fixedSize: const Size(56, 56),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.small.copyWith(fontSize: 11)),
      ],
    );
  }
}
