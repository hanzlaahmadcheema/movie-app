import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../core/config/app_config.dart';
import '../../../core/services/admin_repository.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/network_status_service.dart';
import '../../../core/services/user_activity_repository.dart';
import '../../../core/responsive/responsive_context.dart';
import '../../../core/responsive/adaptive_container.dart';
import '../../../core/streaming/streaming_embed_request.dart';
import '../../../core/streaming/streaming_embed_result.dart';
import '../../../core/streaming/streaming_navigation_policy.dart';
import '../../../core/streaming/streaming_repository.dart';
import '../../../app/app_theme.dart';
import '../../jellyfin/player/jellyfin_native_player_view.dart';
import '../widgets/streaming_error_view.dart';
import '../widgets/streaming_loading_view.dart';
import '../widgets/web_video_player.dart';
import '../../../widgets/app_shell.dart';
import 'streaming_player_controller.dart';

class StreamingPlayerScreen extends StatefulWidget {
  const StreamingPlayerScreen({required this.request, super.key});

  final StreamingEmbedRequest? request;

  @override
  State<StreamingPlayerScreen> createState() => _StreamingPlayerScreenState();
}

class _StreamingPlayerScreenState extends State<StreamingPlayerScreen> {
  final _panelKey = GlobalKey<_StreamingPlayerPanelState>();

  @override
  Widget build(BuildContext context) {
    final playerPage = Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(widget.request?.title ?? 'Streaming Player'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: AdaptiveContainer(
            maxWidth: 1400,
            padding: EdgeInsets.symmetric(
              horizontal: context.isMobile ? 0 : 24,
              vertical: context.isMobile ? 0 : 24,
            ),
            child: StreamingPlayerPanel(
              key: _panelKey,
              request: widget.request,
            ),
          ),
        ),
      ),
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        final panelState = _panelKey.currentState;
        if (!didPop && panelState != null) {
          unawaited(panelState._handleBack());
        }
      },
      child: context.isMobile ? playerPage : AppShell(body: playerPage),
    );
  }
}

class StreamingPlayerPanel extends StatefulWidget {
  const StreamingPlayerPanel({
    required this.request,
    this.topRightActions = const <Widget>[],
    super.key,
  });

  final StreamingEmbedRequest? request;
  final List<Widget> topRightActions;

  @override
  State<StreamingPlayerPanel> createState() => _StreamingPlayerPanelState();
}

class _StreamingPlayerPanelState extends State<StreamingPlayerPanel> {
  StreamingPlayerController? _playerController;
  WebViewController? _webViewController;
  String? _webViewUnavailableMessage;
  bool _offline = false;
  int _loadedAttempt = -1;
  int _recordedAttempt = -1;
  bool _fullscreenRouteOpen = false;
  final StreamingNavigationPolicy _navigationPolicy =
      const StreamingNavigationPolicy();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      unawaited(_initializeRequest());
      return;
    }
    try {
      _webViewController = _createWebViewController();
    } catch (error) {
      _webViewUnavailableMessage =
          'Android System WebView is unavailable on this device.';
      _debugLog('WebView initialization failed: ${error.runtimeType}');
      return;
    }
    unawaited(_initializeRequest());
  }

  @override
  void didUpdateWidget(covariant StreamingPlayerPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.request != oldWidget.request) {
      unawaited(_initializeRequest());
    }
  }

  Future<void> _initializeRequest() async {
    final oldController = _playerController;
    oldController?.removeListener(_handlePlayerChanged);
    oldController?.dispose();
    _playerController = null;
    _loadedAttempt = -1;
    _recordedAttempt = -1;
    _offline = false;

    final request = widget.request;
    if (request == null || (!kIsWeb && _webViewController == null)) {
      if (mounted) setState(() {});
      return;
    }

    if (!await const NetworkStatusService().hasInternet()) {
      if (!mounted) return;
      setState(() => _offline = true);
      return;
    }

    final playerController = StreamingPlayerController(
      request: request,
      repository: StreamingRepository.fromConfig(AppConfig.fromEnv()),
    );
    _playerController = playerController;
    playerController.addListener(_handlePlayerChanged);
    unawaited(playerController.initialize());
  }

  WebViewController _createWebViewController() {
    PlatformWebViewControllerCreationParams params =
        const PlatformWebViewControllerCreationParams();
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params =
          WebKitWebViewControllerCreationParams.fromPlatformWebViewControllerCreationParams(
            params,
            allowsInlineMediaPlayback: true,
            mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
            javaScriptCanOpenWindowsAutomatically: false,
          );
    }

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: _handleProgress,
          onPageStarted: _handlePageStarted,
          onPageFinished: _handlePageFinished,
          onNavigationRequest: _handleNavigationRequest,
          onWebResourceError: _handleWebResourceError,
          onHttpError: _handleHttpError,
          onSslAuthError: _handleSslAuthError,
        ),
      );

    if (controller.platform is AndroidWebViewController) {
      final androidController = controller.platform as AndroidWebViewController;
      unawaited(androidController.setMediaPlaybackRequiresUserGesture(false));
      androidController.setOnPlatformPermissionRequest((request) => request.deny());
      unawaited(
        androidController.setCustomWidgetCallbacks(
          onShowCustomWidget: _showFullscreenWidget,
          onHideCustomWidget: _hideFullscreenWidget,
        ),
      );
    }
    return controller;
  }

  void _handlePlayerChanged() {
    final playerController = _playerController;
    final webViewController = _webViewController;
    if (playerController == null) {
      return;
    }

    final candidate = playerController.currentCandidate;
    if (candidate != null && _loadedAttempt != playerController.attempt) {
      if (_shouldOpenNativeJellyfin(candidate)) {
        _loadedAttempt = playerController.attempt;
        playerController.markReady(_loadedAttempt);
        if (mounted) setState(() {});
        return;
      }
      _loadedAttempt = playerController.attempt;
      final attempt = _loadedAttempt;
      playerController.beginCurrentAttempt(attempt);
      if (kIsWeb) {
        playerController.markReady(attempt);
      } else if (webViewController != null) {
        webViewController.loadRequest(candidate.url).catchError((Object error) {
          _debugLog('WebView request failed: ${error.runtimeType}');
          playerController.failCurrent(attempt, 'Could not load provider');
        });
      }
    }

    if (playerController.status == StreamingPlayerStatus.ready &&
        _recordedAttempt != playerController.attempt) {
      _recordedAttempt = playerController.attempt;
      unawaited(_recordStreamingStarted());
    }

    if (mounted) {
      setState(() {});
    }
  }

  bool _shouldOpenNativeJellyfin(StreamingEmbedResult candidate) {
    return candidate.server.providerId == 'jellyfin_native' &&
        candidate.jellyfinItemId?.trim().isNotEmpty == true &&
        widget.request != null;
  }

  void _handleProgress(int progress) {
    _playerController?.updateProgress(_loadedAttempt, progress);
  }

  void _handlePageStarted(String url) {
    _debugHost('Page started', url);
    _suppressUnwantedPopupsAndAds();
  }

  void _handlePageFinished(String url) {
    _debugHost('Page finished', url);
    final uri = Uri.tryParse(url);
    if (uri?.scheme == 'data' &&
        _playerController?.currentCandidate?.url.scheme == 'data') {
      _playerController?.markPageLoaded(_loadedAttempt);
      return;
    }
    if (uri == null || !_isAllowedNavigationHost(uri.host)) {
      return;
    }
    _playerController?.markPageLoaded(_loadedAttempt);
    unawaited(_inspectPageTitle(_loadedAttempt));
    _suppressUnwantedPopupsAndAds();
  }

  void _suppressUnwantedPopupsAndAds() {
    if (kIsWeb || _webViewController == null) return;
    const js = '''
      (function() {
        try {
          window.open = function() { return null; };
          window.alert = function() {};
          window.confirm = function() { return false; };
          window.prompt = function() { return null; };

          if (!document.getElementById('_easylist_cosmetic_style')) {
            const style = document.createElement('style');
            style.id = '_easylist_cosmetic_style';
            style.innerHTML = `
              iframe[src*="ad"], iframe[src*="pop"], iframe[src*="bet"], iframe[src*="casino"],
              div[id*="pop"], div[id*="ad-"], div[class*="ad-"], div[class*="pop"], div[class*="banner"],
              div[style*="z-index: 999999"], div[style*="z-index: 2147483647"],
              a[href*="bet"], a[href*="casino"], a[href*="1xbet"], a[target="_blank"] {
                display: none !important;
                visibility: hidden !important;
                opacity: 0 !important;
                pointer-events: none !important;
              }
            `;
            (document.head || document.documentElement).appendChild(style);
          }

          if (!window._adClickShieldAttached) {
            window._adClickShieldAttached = true;
            document.addEventListener('click', function(e) {
              let el = e.target;
              while (el && el !== document.body && el !== document.documentElement) {
                if (el.tagName === 'A' && el.href) {
                  try {
                    const u = new URL(el.href);
                    if (u.host !== location.host && !u.host.includes('nxsha')) {
                      e.preventDefault();
                      e.stopPropagation();
                      return false;
                    }
                  } catch(err) {}
                }
                if (el.style && (el.style.zIndex > 1000 || el.style.position === 'fixed')) {
                  if (!el.querySelector('video') && !el.classList.contains('jwplayer') && !el.classList.contains('vjs-tech')) {
                    el.remove();
                  }
                }
                el = el.parentElement;
              }
            }, true);
          }

          const cleanPage = function() {
            const selector = 'iframe[src*="ad"], iframe[src*="pop"], iframe[src*="bet"], div[id*="pop"], div[class*="ad-"], div[class*="pop"], div[style*="z-index: 999999"], div[style*="z-index: 2147483647"], a[target="_blank"]';
            document.querySelectorAll(selector).forEach(function(el) {
              if (el.tagName === 'A') {
                el.removeAttribute('target');
                el.onclick = function(e) { e.preventDefault(); e.stopPropagation(); return false; };
              } else {
                el.remove();
              }
            });
          };
          cleanPage();
          if (!window._adCleanerInterval) {
            window._adCleanerInterval = setInterval(cleanPage, 500);
          }
        } catch (e) {}
      })();
    ''';
    _webViewController?.runJavaScript(js).catchError((_) {});
  }

  NavigationDecision _handleNavigationRequest(NavigationRequest request) {
    final uri = Uri.tryParse(request.url);
    final decision = _navigationPolicy.evaluate(
      uri: uri,
      isMainFrame: request.isMainFrame,
      isAllowedHost: _isAllowedNavigationHost,
      isHttpAllowedHost: _isAllowedHttpNavigationHost,
    );
    if (decision.allowed) {
      return NavigationDecision.navigate;
    }

    _blockNavigation(
      decision.reason ?? 'Blocked navigation',
      request.isMainFrame,
      causesFallback: decision.causesFallback,
    );
    return NavigationDecision.prevent;
  }

  bool _isAllowedNavigationHost(String host) {
    final registry = _playerController?.repository.registry;
    if (registry?.isAllowedNavigationHost(host) == true) {
      return true;
    }
    final candidateHost = _playerController?.currentCandidate?.url.host;
    return candidateHost != null &&
        candidateHost.toLowerCase() == host.toLowerCase();
  }

  bool _isAllowedHttpNavigationHost(String host) {
    final candidate = _playerController?.currentCandidate;
    return candidate?.server.allowHttpNavigation == true &&
        candidate?.url.host.toLowerCase() == host.toLowerCase();
  }

  void _blockNavigation(
    String target,
    bool isMainFrame, {
    bool causesFallback = false,
  }) {
    _debugLog(
      'Blocked ${isMainFrame ? 'main-frame' : 'subframe'} navigation: $target',
    );
    final playerController = _playerController;
    if (causesFallback && isMainFrame && playerController?.isLoading == true) {
      scheduleMicrotask(
        () => playerController?.failCurrent(
          _loadedAttempt,
          target,
          blockedNavigationReason: target,
        ),
      );
    }
  }

  Future<void> _inspectPageTitle(int expectedAttempt) async {
    final playerController = _playerController;
    final webViewController = _webViewController;
    if (playerController == null || webViewController == null) return;
    try {
      final rawTitle = await webViewController.runJavaScriptReturningResult(
        'document.title || ""',
      );
      if (expectedAttempt != playerController.attempt) return;
      final title = rawTitle.toString().replaceAll('"', '').toLowerCase();
      const unavailableTerms = [
        'not found',
        'unavailable',
        'removed',
        'no video',
        'error',
        '404',
        'blocked',
      ];
      if (unavailableTerms.any(title.contains)) {
        playerController.suspectUnavailable(
          expectedAttempt,
          'Provider page title indicates unavailable content',
        );
      }
    } catch (error) {
      _debugLog('Could not inspect provider title: ${error.runtimeType}');
    }
  }

  void _handleWebResourceError(WebResourceError error) {
    if (error.isForMainFrame != true) {
      return;
    }
    final reason = switch (error.errorType) {
      WebResourceErrorType.hostLookup ||
      WebResourceErrorType.connect ||
      WebResourceErrorType.io => 'No internet connection',
      WebResourceErrorType.timeout => 'Provider timed out',
      WebResourceErrorType.unsafeResource => 'Unsafe provider resource blocked',
      WebResourceErrorType.badUrl ||
      WebResourceErrorType.unsupportedScheme => 'Malformed provider URL',
      _ => 'WebView load failure',
    };
    _debugLog(
      'Main-frame WebView error: ${error.errorType?.name ?? 'unknown'}',
    );
    _playerController?.failCurrent(
      _loadedAttempt,
      reason,
      timeout: error.errorType == WebResourceErrorType.timeout,
    );
    unawaited(
      _logPlaybackError(
        errorType: error.errorType == WebResourceErrorType.timeout
            ? 'provider_timeout'
            : 'webview_failed',
        message: reason,
      ),
    );
  }

  void _handleHttpError(HttpResponseError error) {
    final candidate = _playerController?.currentCandidate;
    final response = error.response;
    final uri = response?.uri ?? error.request?.uri;
    if (candidate == null || uri == null) {
      return;
    }
    final isCandidateDocument =
        uri.host == candidate.url.host && uri.path == candidate.url.path;
    if (isCandidateDocument && (response?.statusCode ?? 0) >= 400) {
      _debugLog('Provider HTTP error: ${response?.statusCode}');
      _playerController?.failCurrent(
        _loadedAttempt,
        'Provider returned HTTP ${response?.statusCode}',
        httpStatus: response?.statusCode,
      );
      unawaited(
        _logPlaybackError(
          errorType: 'provider_http_error',
          message: 'Provider returned HTTP ${response?.statusCode}',
        ),
      );
    }
  }

  void _handleSslAuthError(SslAuthError error) {
    unawaited(error.cancel());
    _debugLog('Provider SSL error blocked');
    _playerController?.failCurrent(
      _loadedAttempt,
      'Provider SSL certificate failed',
      ssl: true,
    );
    unawaited(
      _logPlaybackError(
        errorType: 'provider_ssl_error',
        message: 'Provider SSL certificate failed',
      ),
    );
  }

  Future<void> _recordStreamingStarted() async {
    final request = widget.request;
    final candidate = _playerController?.currentCandidate;
    final user = AuthService.instance.currentUser;
    if (request == null || candidate == null || user == null) {
      return;
    }
    try {
      if (candidate.server.providerId == 'jellyfin_native') {
        return;
      }
      await UserActivityRepository.instance.markStreamingStarted(
        user: user,
        item: request.activityItem,
        server: candidate.server.displayName,
        providerId: candidate.server.providerId,
        jellyfinItemId: candidate.jellyfinItemId,
        seasonNumber: request.seasonNumber,
        episodeNumber: request.episodeNumber,
        episodeTitle: request.episodeTitle,
        playbackMode: candidate.server.providerId == 'jellyfin_web'
            ? 'web'
            : null,
      );
    } catch (error) {
      _debugLog(
        'Could not save all streaming activity fields: ${error.runtimeType}',
      );
    }
  }

  Future<void> _showFullscreenWidget(
    Widget widget,
    OnHideCustomWidgetCallback onHide,
  ) async {
    if (!mounted || _fullscreenRouteOpen) {
      return;
    }
    _fullscreenRouteOpen = true;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(child: widget),
        ),
      ),
    );
    _fullscreenRouteOpen = false;
    onHide();
  }

  void _hideFullscreenWidget() {
    if (!mounted || !_fullscreenRouteOpen) {
      return;
    }
    Navigator.of(context).pop();
  }

  Future<void> _handleBack() async {
    final webViewController = _webViewController;
    if (webViewController != null && await webViewController.canGoBack()) {
      await webViewController.goBack();
      return;
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  final GlobalKey _playerBodyKey = GlobalKey();
  final GlobalKey _webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final playerController = _playerController;
    final candidates = playerController?.candidates ?? const [];
    final currentIndex = playerController?.currentIndex ?? -1;

    final bool isMobileLandscape = !kIsWeb && (Platform.isAndroid || Platform.isIOS) && MediaQuery.orientationOf(context) == Orientation.landscape;

    final playerBodyWidget = KeyedSubtree(
      key: _playerBodyKey,
      child: _buildPlayerBody(),
    );

    if (isMobileLandscape) {
      return Stack(
        fit: StackFit.expand,
        children: [
          playerBodyWidget,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    if (candidates.isNotEmpty) ...[
                      ServerDropdownSelector(
                        candidates: candidates,
                        currentIndex: currentIndex,
                        enabled: playerController?.canUseControls ?? false,
                        onSelected: (index) => playerController?.selectCandidate(index),
                      ),
                      if (widget.topRightActions.isNotEmpty) const SizedBox(width: 8),
                    ],
                    ...widget.topRightActions,
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (context.isMobile)
          SizedBox(
            height: 240,
            width: double.infinity,
            child: playerBodyWidget,
          )
        else
          AspectRatio(aspectRatio: 16 / 9, child: playerBodyWidget),
        _FigmaServerSelector(
          candidates: candidates,
          currentIndex: currentIndex,
          enabled: playerController?.canUseControls ?? false,
          onSelected: (index) => playerController?.selectCandidate(index),
        ),
      ],
    );
  }

  Widget _buildPlayerBody() {
    final request = widget.request;
    if (request == null) {
      return StreamingErrorView(
        title: 'Stream unavailable',
        message: 'The streaming route is missing its content details.',
        onBack: () => unawaited(_handleBack()),
      );
    }
    if (!kIsWeb && _webViewUnavailableMessage != null) {
      return StreamingErrorView(
        title: 'WebView unavailable',
        message: _webViewUnavailableMessage!,
        onBack: () => unawaited(_handleBack()),
      );
    }
    if (_offline) {
      return StreamingErrorView(
        title: 'No internet connection',
        message:
            'Streaming needs an internet connection. Reconnect and try again.',
        onRetry: () => unawaited(_initializeRequest()),
        retryAllLabel: 'Retry',
        onBack: () => unawaited(_handleBack()),
      );
    }

    final playerController = _playerController;
    if (playerController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final candidate = playerController.currentCandidate;
    if (kIsWeb && candidate != null) {
      return WebVideoPlayer(key: ValueKey(candidate.url), url: candidate.url);
    }
    if (candidate?.server.providerId == 'jellyfin_native' &&
        candidate?.jellyfinItemId?.trim().isNotEmpty == true) {
      return JellyfinNativePlayerView(
        itemId: candidate!.jellyfinItemId!,
        request: request,
        title: request.title,
        onOpenWebFallback: () {
          final controller = _playerController;
          if (controller == null) return;
          final webIndex = controller.candidates.indexWhere(
            (entry) => entry.server.providerId == 'jellyfin_web',
          );
          if (webIndex >= 0) {
            controller.selectCandidate(webIndex);
          }
        },
        onTryNextServer: () => playerController.tryNextServer(),
      );
    }
    return switch (playerController.status) {
      StreamingPlayerStatus.unavailable => StreamingErrorView(
        title: 'Stream unavailable',
        message: playerController.message ?? 'Required stream data is missing.',
        onBack: () => unawaited(_handleBack()),
      ),
      StreamingPlayerStatus.exhausted => StreamingErrorView(
        title: 'No stream available',
        message: playerController.message ?? 'All streaming servers failed.',
        onRetry: playerController.retryAll,
        onRetryCurrent: playerController.retryCurrent,
        onTryNext: playerController.tryNextServer,
        retryAllLabel: 'Retry All',
        actionsEnabled: playerController.canUseControls,
        onBack: () => unawaited(_handleBack()),
      ),
      StreamingPlayerStatus.idle => const Center(
        child: CircularProgressIndicator(),
      ),
      StreamingPlayerStatus.loading ||
      StreamingPlayerStatus.pageLoaded ||
      StreamingPlayerStatus.suspectedUnavailable ||
      StreamingPlayerStatus.failed ||
      StreamingPlayerStatus.ready => Stack(
        fit: StackFit.expand,
        children: [
          ExcludeSemantics(
            child: WebViewWidget(
              key: _webViewKey,
              controller: _webViewController!,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
            ),
          ),
          if (playerController.status != StreamingPlayerStatus.ready)
            StreamingLoadingView(
              message: playerController.message ?? 'Loading stream...',
              detail: _streamingStatusDetail(playerController),
            ),
        ],
      ),
    };
  }

  void _debugHost(String action, String value) {
    final uri = Uri.tryParse(value);
    _debugLog(
      '$action: ${uri?.host.isNotEmpty == true ? uri!.host : 'unknown'}',
    );
  }

  void _debugLog(String message) {
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  Future<void> _logPlaybackError({
    required String errorType,
    required String message,
  }) async {
    final request = widget.request;
    final user = AuthService.instance.currentUser;
    final candidate = _playerController?.currentCandidate;
    if (request == null || user == null || candidate == null) {
      return;
    }
    await AdminRepository.instance.logPlaybackError(
      user: user,
      contentType: request.contentType.name,
      tmdbId: request.tmdbId,
      seasonNumber: request.seasonNumber,
      episodeNumber: request.episodeNumber,
      providerId: candidate.server.providerId,
      playbackMode: candidate.jellyfinPlaybackMode.name,
      errorType: errorType,
      errorMessageSafe: message,
      devicePlatform: defaultTargetPlatform.name,
      appVersion: 'debug',
    );
  }

  @override
  void dispose() {
    final playerController = _playerController;
    playerController?.removeListener(_handlePlayerChanged);
    playerController?.dispose();
    super.dispose();
  }
}

String? _streamingStatusDetail(StreamingPlayerController controller) {
  final candidate = controller.currentCandidate;
  final diagnostic = controller.currentDiagnostic;
  if (candidate == null) {
    return null;
  }
  final parts = <String>[
    'Server ${controller.currentIndex + 1} of ${controller.candidates.length}',
    candidate.server.displayName,
    if (diagnostic?.fallbackReason?.isNotEmpty == true) 'checking fallback',
  ];
  return parts.join(' - ');
}

class _FigmaServerSelector extends StatefulWidget {
  const _FigmaServerSelector({
    required this.candidates,
    required this.currentIndex,
    required this.enabled,
    required this.onSelected,
  });

  final List<StreamingEmbedResult> candidates;
  final int currentIndex;
  final bool enabled;
  final ValueChanged<int> onSelected;

  @override
  State<_FigmaServerSelector> createState() => _FigmaServerSelectorState();
}

class _FigmaServerSelectorState extends State<_FigmaServerSelector> {
  bool _isExpanded = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final active =
        widget.currentIndex >= 0 &&
            widget.currentIndex < widget.candidates.length
        ? widget.candidates[widget.currentIndex]
        : null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(21, 18, 21, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Focus(
            onFocusChange: (focused) => setState(() => _isFocused = focused),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.enabled && widget.candidates.isNotEmpty) {
                  setState(() => _isExpanded = !_isExpanded);
                }
              },
              child: Opacity(
                opacity: widget.enabled ? 1 : 0.6,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _isFocused ? Colors.white24 : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        active?.server.displayName ?? 'Servers',
                        style: AppTextStyles.medium,
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (var index = 0; index < widget.candidates.length; index++)
                    _ServerChip(
                      name: widget.candidates[index].server.displayName,
                      isSelected: index == widget.currentIndex,
                      onTap: () {
                        setState(() => _isExpanded = false);
                        widget.onSelected(index);
                      },
                    ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Text(
            widget.candidates.isEmpty
                ? 'No streaming server is currently available.'
                : "If current server doesn't work please try other servers above",
            style: AppTextStyles.normal.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServerChip extends StatelessWidget {
  const _ServerChip({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(name),
      onPressed: onTap,
      backgroundColor: isSelected ? AppColors.primary : Colors.black45,
      labelStyle: TextStyle(
        color: isSelected ? Colors.black : Colors.white,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class ServerDropdownSelector extends StatelessWidget {
  const ServerDropdownSelector({
    required this.candidates,
    required this.currentIndex,
    required this.enabled,
    required this.onSelected,
    super.key,
  });

  final List<StreamingEmbedResult> candidates;
  final int currentIndex;
  final bool enabled;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    if (candidates.isEmpty) return const SizedBox();

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: currentIndex >= 0 ? currentIndex : null,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
          dropdownColor: Colors.black87,
          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
          onChanged: enabled ? (int? newValue) {
            if (newValue != null) {
              onSelected(newValue);
            }
          } : null,
          items: List.generate(
            candidates.length,
            (index) => DropdownMenuItem<int>(
              value: index,
              child: Text(candidates[index].server.displayName),
            ),
          ),
        ),
      ),
    );
  }
}
