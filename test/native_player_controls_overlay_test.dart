import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/jellyfin/player/widgets/native_player_controls_overlay.dart';
import 'package:movie_app/features/jellyfin/player/widgets/native_player_error_state.dart';
import 'package:movie_app/features/jellyfin/player/widgets/native_player_ui_state.dart';

void main() {
  test('formatPlayerDuration formats short and long durations', () {
    expect(formatPlayerDuration(const Duration(seconds: 5)), '00:05');
    expect(
      formatPlayerDuration(const Duration(hours: 1, minutes: 2, seconds: 3)),
      '1:02:03',
    );
  });

  test('clampSeekPosition keeps seek inside duration bounds', () {
    const duration = Duration(minutes: 2);
    expect(
      clampSeekPosition(const Duration(seconds: -4), duration),
      Duration.zero,
    );
    expect(clampSeekPosition(const Duration(minutes: 3), duration), duration);
    expect(
      clampSeekPosition(const Duration(seconds: 20), duration),
      const Duration(seconds: 20),
    );
  });

  testWidgets('native controls overlay renders core controls and callbacks', (
    tester,
  ) async {
    var playTapped = false;
    var rewindTapped = false;
    var forwardTapped = false;
    var muteTapped = false;
    var speedTapped = false;
    var fullscreenTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 380,
            height: 240,
            child: NativePlayerControlsOverlay(
              state: const NativePlayerUiState(
                isInitialized: true,
                isPlaying: false,
                isBuffering: false,
                isControlsVisible: true,
                isFullscreen: false,
                hasError: false,
                position: Duration(seconds: 5),
                duration: Duration(minutes: 2),
                volume: 1,
                playbackSpeed: 1,
              ),
              title: 'Fight Club',
              serverLabel: 'Jellyfin Native',
              onPlayPause: () => playTapped = true,
              onReplay: () {},
              onRewind: () => rewindTapped = true,
              onForward: () => forwardTapped = true,
              onMuteToggle: () => muteTapped = true,
              onSpeedTap: () => speedTapped = true,
              onSeek: (_) {},
              onFullscreen: () => fullscreenTapped = true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Fight Club'), findsOneWidget);
    expect(find.text('Jellyfin Native'), findsOneWidget);
    expect(find.text('00:05'), findsOneWidget);
    expect(find.text('/ 02:00'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow).first);
    await tester.tap(find.byIcon(Icons.replay_10));
    await tester.tap(find.byIcon(Icons.forward_10));
    await tester.tap(find.byIcon(Icons.volume_up));
    await tester.tap(find.text('1.00x'));
    await tester.tap(find.byIcon(Icons.open_in_full).first);

    expect(playTapped, isTrue);
    expect(rewindTapped, isTrue);
    expect(forwardTapped, isTrue);
    expect(muteTapped, isTrue);
    expect(speedTapped, isTrue);
    expect(fullscreenTapped, isTrue);
  });

  testWidgets('native controls overlay explicit animation renders safely', (
    tester,
  ) async {
    const hiddenState = NativePlayerUiState(
      isInitialized: true,
      isPlaying: true,
      isBuffering: false,
      isControlsVisible: false,
      isFullscreen: false,
      hasError: false,
      position: Duration(seconds: 12),
      duration: Duration(minutes: 4),
      volume: 1,
      playbackSpeed: 1,
    );
    const visibleState = NativePlayerUiState(
      isInitialized: true,
      isPlaying: true,
      isBuffering: false,
      isControlsVisible: true,
      isFullscreen: false,
      hasError: false,
      position: Duration(seconds: 12),
      duration: Duration(minutes: 4),
      volume: 1,
      playbackSpeed: 1,
    );

    Widget buildOverlay(NativePlayerUiState state) {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 380,
            height: 240,
            child: NativePlayerControlsOverlay(
              state: state,
              title: 'Animated Player',
              serverLabel: 'Jellyfin Native',
              onPlayPause: () {},
              onReplay: () {},
              onRewind: () {},
              onForward: () {},
              onMuteToggle: () {},
              onSpeedTap: () {},
              onSeek: (_) {},
            ),
          ),
        ),
      );
    }

    await tester.pumpWidget(buildOverlay(hiddenState));
    final overlay = find.byType(NativePlayerControlsOverlay);
    expect(
      find.descendant(of: overlay, matching: find.byType(FadeTransition)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: overlay, matching: find.byType(SlideTransition)),
      findsOneWidget,
    );

    await tester.pumpWidget(buildOverlay(visibleState));
    await tester.pump(const Duration(milliseconds: 220));

    expect(find.text('Animated Player'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('native error state shows retry and fallback actions', (
    tester,
  ) async {
    var retryTapped = false;
    var webTapped = false;
    var nextTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NativePlayerErrorState(
            visible: true,
            message: 'Native playback failed.',
            onRetry: () => retryTapped = true,
            onOpenWebFallback: () => webTapped = true,
            onTryNextServer: () => nextTapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Native playback failed.'), findsOneWidget);
    await tester.tap(find.text('Retry Native'));
    await tester.tap(find.text('Open Jellyfin Web Player'));
    await tester.tap(find.text('Try Next Server'));

    expect(retryTapped, isTrue);
    expect(webTapped, isTrue);
    expect(nextTapped, isTrue);
  });
}
