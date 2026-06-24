class NativePlayerUiState {
  const NativePlayerUiState({
    required this.isInitialized,
    required this.isPlaying,
    required this.isBuffering,
    required this.isControlsVisible,
    required this.isFullscreen,
    required this.hasError,
    required this.position,
    required this.duration,
    required this.volume,
    required this.playbackSpeed,
    this.errorMessage,
    this.isEnded = false,
  });

  const NativePlayerUiState.initial()
    : isInitialized = false,
      isPlaying = false,
      isBuffering = false,
      isControlsVisible = true,
      isFullscreen = false,
      hasError = false,
      errorMessage = null,
      position = Duration.zero,
      duration = Duration.zero,
      volume = 1,
      playbackSpeed = 1,
      isEnded = false;

  final bool isInitialized;
  final bool isPlaying;
  final bool isBuffering;
  final bool isControlsVisible;
  final bool isFullscreen;
  final bool hasError;
  final String? errorMessage;
  final Duration position;
  final Duration duration;
  final double volume;
  final double playbackSpeed;
  final bool isEnded;

  bool get isMuted => volume <= 0.01;
  bool get canSeek => isInitialized && duration > Duration.zero;
  bool get shouldKeepControlsVisible =>
      hasError || !isInitialized || isBuffering || !isPlaying || isEnded;

  NativePlayerUiState copyWith({
    bool? isInitialized,
    bool? isPlaying,
    bool? isBuffering,
    bool? isControlsVisible,
    bool? isFullscreen,
    bool? hasError,
    Object? errorMessage = _sentinel,
    Duration? position,
    Duration? duration,
    double? volume,
    double? playbackSpeed,
    bool? isEnded,
  }) {
    return NativePlayerUiState(
      isInitialized: isInitialized ?? this.isInitialized,
      isPlaying: isPlaying ?? this.isPlaying,
      isBuffering: isBuffering ?? this.isBuffering,
      isControlsVisible: isControlsVisible ?? this.isControlsVisible,
      isFullscreen: isFullscreen ?? this.isFullscreen,
      hasError: hasError ?? this.hasError,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      volume: volume ?? this.volume,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      isEnded: isEnded ?? this.isEnded,
    );
  }
}

const _sentinel = Object();

Duration clampSeekPosition(Duration target, Duration duration) {
  if (duration <= Duration.zero) {
    return target.isNegative ? Duration.zero : target;
  }
  if (target.isNegative) {
    return Duration.zero;
  }
  if (target > duration) {
    return duration;
  }
  return target;
}

String formatPlayerDuration(Duration duration) {
  if (duration.isNegative) {
    duration = Duration.zero;
  }
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
}
