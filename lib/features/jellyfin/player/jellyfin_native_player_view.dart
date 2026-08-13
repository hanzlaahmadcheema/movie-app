import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../app/app_routes.dart';
import '../../../app/app_theme.dart';
import '../../../core/jellyfin/jellyfin_config.dart';
import '../../../core/jellyfin/jellyfin_repository.dart';
import '../../../core/jellyfin/jellyfin_stream_url_builder.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/user_activity_repository.dart';
import '../../../core/streaming/streaming_content_type.dart';
import '../../../core/streaming/streaming_embed_request.dart';
import 'jellyfin_native_player_screen.dart';
import 'widgets/native_player_controls_overlay.dart';
import 'widgets/native_player_error_state.dart';
import 'widgets/native_player_loading_state.dart';
import 'widgets/native_player_ui_state.dart';
import 'widgets/native_video_surface.dart';

class JellyfinNativePlayerView extends StatefulWidget {
  const JellyfinNativePlayerView({
    required this.itemId,
    required this.request,
    required this.title,
    this.onOpenWebFallback,
    this.onTryNextServer,
    this.fullscreenEnabled = true,
    this.isFullscreen = false,
    super.key,
  });

  final String itemId;
  final StreamingEmbedRequest request;
  final String title;
  final VoidCallback? onOpenWebFallback;
  final VoidCallback? onTryNextServer;
  final bool fullscreenEnabled;
  final bool isFullscreen;

  @override
  State<JellyfinNativePlayerView> createState() =>
      _JellyfinNativePlayerViewState();
}

class _JellyfinNativePlayerViewState extends State<JellyfinNativePlayerView>
    with WidgetsBindingObserver {
  static const _playerAspectRatio = 16 / 9;
  static const _controlsAutoHideDelay = Duration(seconds: 3);
  static const _speedOptions = <double>[0.5, 0.75, 1, 1.25, 1.5, 2];

  final _repository = JellyfinRepository.local();
  VideoPlayerController? _controller;
  JellyfinNativePlaybackCandidate? _candidate;
  Timer? _progressTimer;
  Timer? _controlsHideTimer;
  NativePlayerUiState _uiState = const NativePlayerUiState.initial();
  bool _loading = true;
  String? _error;
  bool _playbackStarted = false;
  double _volume = 1;
  double _playbackSpeed = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_initialize());
  }

  @override
  void didUpdateWidget(covariant JellyfinNativePlayerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemId != oldWidget.itemId) {
      _resetAndInitialize();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      unawaited(_pauseAndPersistProgress());
    }
  }

  Future<void> _resetAndInitialize() async {
    _disposeController();
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
      _playbackStarted = false;
      _uiState = const NativePlayerUiState.initial();
      _volume = 1;
      _playbackSpeed = 1;
    });
    await _initialize();
  }

  Future<void> _initialize() async {
    try {
      final candidate = await _repository.buildNativePlaybackCandidate(
        itemId: widget.itemId,
      );
      final resumePositionSeconds = _effectiveResumePositionSeconds(candidate);
      final controller = VideoPlayerController.networkUrl(
        candidate.streamUri,
        httpHeaders: candidate.headers,
      );
      await controller.initialize();
      await controller.setVolume(_volume);
      await controller.setPlaybackSpeed(_playbackSpeed);
      if (resumePositionSeconds > 0) {
        final target = _normalizedResumePosition(
          duration: controller.value.duration,
          resumePositionSeconds: resumePositionSeconds,
        );
        if (target > Duration.zero) {
          await controller.seekTo(target);
        }
      }
      controller.addListener(_handlePlayerChanged);
      await controller.play();
      await _reportPlaybackStart(controller, candidate);
      _playbackStarted = true;
      if (!mounted) {
        await controller.dispose();
        return;
      }
      _progressTimer?.cancel();
      setState(() {
        _candidate = candidate;
        _controller = controller;
        _loading = false;
        _error = null;
        _uiState = _composeUiState(
          controller: controller,
          candidate: candidate,
          controlsVisible: true,
        );
      });
      _scheduleControlsAutoHide();
      unawaited(_syncProgress());
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'Native playback failed. Try Jellyfin Web Player.';
        _uiState = _composeUiState(controlsVisible: true);
      });
    }
  }

  NativePlayerUiState _composeUiState({
    VideoPlayerController? controller,
    JellyfinNativePlaybackCandidate? candidate,
    bool? controlsVisible,
  }) {
    final playerController = controller ?? _controller;
    final value = playerController?.value;
    final initialized = value?.isInitialized == true;
    final duration = initialized ? value!.duration : Duration.zero;
    final rawPosition = initialized ? value!.position : Duration.zero;
    final position = rawPosition > duration && duration > Duration.zero
        ? duration
        : rawPosition;
    final hasError = _error != null || value?.hasError == true;
    final isEnded =
        initialized &&
        duration > Duration.zero &&
        position >= duration &&
        value?.isPlaying != true;
    final next = NativePlayerUiState(
      isInitialized: initialized,
      isPlaying: value?.isPlaying == true,
      isBuffering: initialized && value?.isBuffering == true,
      isControlsVisible:
          controlsVisible ?? _uiState.isControlsVisible || !initialized,
      isFullscreen: widget.isFullscreen,
      hasError: hasError,
      errorMessage: _error ?? value?.errorDescription,
      position: position,
      duration: duration,
      volume: _volume,
      playbackSpeed: _playbackSpeed,
      isEnded: isEnded,
    );
    return next.shouldKeepControlsVisible
        ? next.copyWith(isControlsVisible: true)
        : next;
  }

  void _handlePlayerChanged() {
    final controller = _controller;
    if (controller == null || !mounted) return;
    if (!_playbackStarted && controller.value.isPlaying) {
      _playbackStarted = true;
      unawaited(_reportPlaybackStart(controller, _candidate));
    }
    if (controller.value.hasError) {
      _error = controller.value.errorDescription ?? 'Native playback failed.';
    }
    final next = _composeUiState();
    if (next.shouldKeepControlsVisible) {
      _controlsHideTimer?.cancel();
    } else {
      _scheduleControlsAutoHide();
    }
    if (mounted) {
      setState(() {
        _uiState = next;
      });
    }
  }

  int _effectiveResumePositionSeconds(
    JellyfinNativePlaybackCandidate candidate,
  ) {
    final requestResume = widget.request.resumePositionSeconds ?? 0;
    final candidateResume = candidate.resumePositionSeconds ?? 0;
    return candidateResume > requestResume ? candidateResume : requestResume;
  }

  Duration _normalizedResumePosition({
    required Duration duration,
    required int resumePositionSeconds,
  }) {
    if (resumePositionSeconds <= 0) {
      return Duration.zero;
    }
    final maxSeconds = duration.inSeconds;
    if (maxSeconds <= 0) {
      return Duration(seconds: resumePositionSeconds);
    }
    final clampedSeconds = resumePositionSeconds >= maxSeconds
        ? maxSeconds - 2
        : resumePositionSeconds;
    return clampedSeconds > 0
        ? Duration(seconds: clampedSeconds)
        : Duration.zero;
  }

  void _scheduleControlsAutoHide() {
    _controlsHideTimer?.cancel();
    if (!_uiState.isPlaying ||
        _uiState.shouldKeepControlsVisible ||
        !_uiState.isControlsVisible) {
      return;
    }
    _controlsHideTimer = Timer(_controlsAutoHideDelay, () {
      if (!mounted) return;
      setState(() {
        _uiState = _composeUiState(controlsVisible: false);
      });
    });
  }

  void _showControls() {
    _controlsHideTimer?.cancel();
    if (!mounted) return;
    setState(() {
      _uiState = _composeUiState(controlsVisible: true);
    });
    _scheduleControlsAutoHide();
  }

  void _toggleControlsVisibility() {
    if (_uiState.shouldKeepControlsVisible) {
      _showControls();
      return;
    }
    final nextVisible = !_uiState.isControlsVisible;
    _controlsHideTimer?.cancel();
    if (!mounted) return;
    setState(() {
      _uiState = _composeUiState(controlsVisible: nextVisible);
    });
    if (nextVisible) {
      _scheduleControlsAutoHide();
    }
  }

  Future<void> _togglePlayPause() async {
    final controller = _controller;
    if (controller == null || !_uiState.isInitialized) return;
    _showControls();
    if (_uiState.isEnded) {
      await controller.seekTo(Duration.zero);
      await controller.play();
      await _saveProgress();
      return;
    }
    if (controller.value.isPlaying) {
      await controller.pause();
      await _saveProgress(syncToJellyfin: true);
    } else {
      await controller.play();
    }
  }

  Future<void> _seekRelative(int seconds) async {
    final controller = _controller;
    if (controller == null || !_uiState.canSeek) return;
    _showControls();
    final target = clampSeekPosition(
      _uiState.position + Duration(seconds: seconds),
      _uiState.duration,
    );
    await controller.seekTo(target);
    await _saveProgress(syncToJellyfin: true);
  }

  Future<void> _seekTo(Duration target) async {
    final controller = _controller;
    if (controller == null || !_uiState.canSeek) return;
    _showControls();
    await controller.seekTo(clampSeekPosition(target, _uiState.duration));
    await _saveProgress(syncToJellyfin: true);
  }

  Future<void> _toggleMute() async {
    final controller = _controller;
    if (controller == null || !_uiState.isInitialized) return;
    _showControls();
    final nextVolume = _volume <= 0.01 ? 1.0 : 0.0;
    await controller.setVolume(nextVolume);
    if (!mounted) return;
    setState(() {
      _volume = nextVolume;
      _uiState = _composeUiState();
    });
  }

  Future<void> _showSpeedMenu() async {
    final controller = _controller;
    if (controller == null || !_uiState.isInitialized) return;
    _showControls();
    final selected = await showModalBottomSheet<double>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text('Playback Speed', style: AppTextStyles.medium),
              const SizedBox(height: 8),
              for (final speed in _speedOptions)
                ListTile(
                  title: Text('${speed.toStringAsFixed(speed == 1 ? 1 : 2)}x'),
                  trailing: _playbackSpeed == speed
                      ? const Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () => Navigator.pop(context, speed),
                ),
            ],
          ),
        );
      },
    );
    if (selected == null) return;
    try {
      await controller.setPlaybackSpeed(selected);
      if (!mounted) return;
      setState(() {
        _playbackSpeed = selected;
        _uiState = _composeUiState();
      });
      _showControls();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Playback speed is not supported here.')),
      );
    }
  }

  Future<void> _syncProgress() async {
    await _saveProgress(syncToJellyfin: true);
  }

  Future<void> _saveProgress({bool syncToJellyfin = false}) async {
    final controller = _controller;
    final candidate = _candidate;
    final user = AuthService.instance.currentUser;
    if (controller == null ||
        candidate == null ||
        user == null ||
        !controller.value.isInitialized) {
      return;
    }
    final positionSeconds = controller.value.position.inSeconds;
    final durationSeconds = controller.value.duration.inSeconds > 0
        ? controller.value.duration.inSeconds
        : candidate.durationSeconds;
    try {
      await UserActivityRepository.instance.markStreamingStarted(
        user: user,
        item: widget.request.activityItem,
        server: 'Jellyfin Native',
        providerId: 'jellyfin_native',
        jellyfinItemId: widget.itemId,
        seasonNumber: widget.request.seasonNumber,
        episodeNumber: widget.request.episodeNumber,
        episodeTitle: widget.request.episodeTitle,
        positionSeconds: positionSeconds,
        durationSeconds: durationSeconds,
        playbackMode: 'native',
        mediaSourceId: candidate.mediaSourceId,
      );
    } catch (_) {}
    if (!syncToJellyfin) {
      return;
    }
    try {
      await _repository.reportPlaybackProgress(
        itemId: widget.itemId,
        mediaSourceId: candidate.mediaSourceId,
        positionSeconds: positionSeconds,
        playSessionId: candidate.playbackSessionId,
        isPaused: !controller.value.isPlaying,
      );
    } catch (_) {}
  }

  Future<void> _reportPlaybackStart(
    VideoPlayerController controller,
    JellyfinNativePlaybackCandidate? candidate,
  ) async {
    if (candidate == null) return;
    try {
      await _repository.reportPlaybackStart(
        itemId: widget.itemId,
        mediaSourceId: candidate.mediaSourceId,
        positionSeconds: controller.value.position.inSeconds,
        playSessionId: candidate.playbackSessionId,
        isPaused: !controller.value.isPlaying,
      );
    } catch (_) {}
  }

  Future<void> _reportPlaybackStopped() async {
    final controller = _controller;
    final candidate = _candidate;
    if (controller == null ||
        candidate == null ||
        !controller.value.isInitialized) {
      return;
    }
    try {
      await _repository.reportPlaybackStopped(
        itemId: widget.itemId,
        mediaSourceId: candidate.mediaSourceId,
        positionSeconds: controller.value.position.inSeconds,
        playSessionId: candidate.playbackSessionId,
      );
    } catch (_) {}
  }

  Future<void> _pauseAndPersistProgress() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (controller.value.isPlaying) {
      await controller.pause();
    }
    await _saveProgress(syncToJellyfin: true);
    if (!mounted) return;
    setState(() {
      _uiState = _composeUiState(controlsVisible: true);
    });
  }

  Future<void> _openWebFallback() async {
    await _pauseAndPersistProgress();
    await _reportPlaybackStopped();
    widget.onOpenWebFallback?.call();
  }

  Future<void> _openFullscreen() async {
    if (widget.isFullscreen) {
      Navigator.pop(context);
      return;
    }
    final controller = _controller;
    if (controller == null || !widget.fullscreenEnabled) return;
    final wasPlaying = controller.value.isPlaying;
    await _pauseAndPersistProgress();
    final fullscreenRequest = JellyfinNativePlayerRequest(
      itemId: widget.itemId,
      title: widget.title,
      sourceRequest: widget.request.copyWith(
        resumePositionSeconds: controller.value.position.inSeconds,
        resumeDurationSeconds: controller.value.duration.inSeconds > 0
            ? controller.value.duration.inSeconds
            : _candidate?.durationSeconds,
      ),
      mode: JellyfinPlaybackMode.native,
    );
    if (!mounted) return;
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.jellyfinNativePlayerFullscreen,
      arguments: fullscreenRequest,
    );
    if (!mounted) return;
    await _resetAndInitialize();
    if (!wasPlaying) {
      final resumedController = _controller;
      if (resumedController != null && resumedController.value.isPlaying) {
        await resumedController.pause();
        if (!mounted) return;
        setState(() {
          _uiState = _composeUiState(controlsVisible: true);
        });
      }
    }
  }

  Future<void> _retryNative() async {
    await _resetAndInitialize();
  }

  void _disposeController() {
    _progressTimer?.cancel();
    _controlsHideTimer?.cancel();
    final controller = _controller;
    controller?.removeListener(_handlePlayerChanged);
    if (controller != null) {
      unawaited(controller.dispose());
    }
    _controller = null;
    _candidate = null;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.request.contentType == StreamingContentType.episode
        ? 'S${widget.request.seasonNumber} E${widget.request.episodeNumber}'
        : widget.title;
    final loadingVisible =
        _loading || (_uiState.isBuffering && !_uiState.hasError);
    final errorVisible = _uiState.hasError;

    final playerWidget = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleControlsVisibility,
      child: Stack(
        fit: StackFit.expand,
        children: [
          NativeVideoSurface(
            controller: _controller,
            isInitialized: _uiState.isInitialized,
            title: title,
            aspectRatio: _playerAspectRatio,
          ),
          NativePlayerLoadingState(visible: loadingVisible),
          NativePlayerControlsOverlay(
            state: _uiState,
            title: title,
            serverLabel: 'Jellyfin Native',
            onPlayPause: _togglePlayPause,
            onReplay: _togglePlayPause,
            onRewind: () => _seekRelative(-10),
            onForward: () => _seekRelative(10),
            onMuteToggle: _toggleMute,
            onSpeedTap: _showSpeedMenu,
            onSeek: _seekTo,
            onFullscreen: widget.fullscreenEnabled ? _openFullscreen : null,
          ),
          NativePlayerErrorState(
            visible: errorVisible,
            message:
                _uiState.errorMessage ??
                'Native playback failed unexpectedly.',
            onRetry: _retryNative,
            onOpenWebFallback: widget.onOpenWebFallback != null
                ? _openWebFallback
                : null,
            onTryNextServer: widget.onTryNextServer,
          ),
        ],
      ),
    );

    if (widget.isFullscreen) {
      return playerWidget;
    }

    return Container(
      height: 240,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      clipBehavior: Clip.antiAlias,
      child: playerWidget,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_syncProgress());
    unawaited(_reportPlaybackStopped());
    _disposeController();
    super.dispose();
  }
}
