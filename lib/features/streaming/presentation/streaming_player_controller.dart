import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/streaming/streaming_embed_request.dart';
import '../../../core/streaming/streaming_embed_result.dart';
import '../../../core/streaming/streaming_repository.dart';

enum StreamingPlayerStatus {
  idle,
  loading,
  pageLoaded,
  suspectedUnavailable,
  ready,
  failed,
  unavailable,
  exhausted,
}

class StreamingProviderDiagnostic {
  const StreamingProviderDiagnostic({
    required this.providerName,
    required this.host,
    this.endpointId,
    this.loadStartedAt,
    this.loadFinishedAt,
    this.timeout = false,
    this.httpError,
    this.sslError = false,
    this.blockedNavigationReason,
    this.fallbackReason,
  });

  final String providerName;
  final String host;
  final String? endpointId;
  final DateTime? loadStartedAt;
  final DateTime? loadFinishedAt;
  final bool timeout;
  final int? httpError;
  final bool sslError;
  final String? blockedNavigationReason;
  final String? fallbackReason;

  StreamingProviderDiagnostic copyWith({
    DateTime? loadStartedAt,
    DateTime? loadFinishedAt,
    bool? timeout,
    int? httpError,
    bool? sslError,
    String? blockedNavigationReason,
    String? fallbackReason,
  }) {
    return StreamingProviderDiagnostic(
      providerName: providerName,
      host: host,
      endpointId: endpointId,
      loadStartedAt: loadStartedAt ?? this.loadStartedAt,
      loadFinishedAt: loadFinishedAt ?? this.loadFinishedAt,
      timeout: timeout ?? this.timeout,
      httpError: httpError ?? this.httpError,
      sslError: sslError ?? this.sslError,
      blockedNavigationReason:
          blockedNavigationReason ?? this.blockedNavigationReason,
      fallbackReason: fallbackReason ?? this.fallbackReason,
    );
  }

  String toRedactedDebugString() {
    return [
      'provider=$providerName',
      if (endpointId?.isNotEmpty == true) 'endpoint=$endpointId',
      'host=$host',
      if (loadStartedAt != null) 'started=${loadStartedAt!.toIso8601String()}',
      if (loadFinishedAt != null)
        'finished=${loadFinishedAt!.toIso8601String()}',
      if (timeout) 'timeout=true',
      if (httpError != null) 'http=$httpError',
      if (sslError) 'ssl=true',
      if (blockedNavigationReason != null) 'blocked=$blockedNavigationReason',
      if (fallbackReason != null) 'fallback=$fallbackReason',
    ].join(' ');
  }
}

class StreamingPlayerController extends ChangeNotifier {
  StreamingPlayerController({required this.request, required this.repository});

  final StreamingEmbedRequest request;
  final StreamingRepository repository;

  List<StreamingEmbedResult> _candidates = const [];
  StreamingPlayerStatus _status = StreamingPlayerStatus.idle;
  int _currentIndex = -1;
  int _currentEndpointIndex = 0;
  int _attempt = 0;
  int _progress = 0;
  String? _message;
  Timer? _timeout;
  Timer? _readyGraceTimer;
  StreamingProviderDiagnostic? _currentDiagnostic;
  final List<StreamingProviderDiagnostic> _diagnostics = [];

  List<StreamingEmbedResult> get candidates => _candidates;
  StreamingPlayerStatus get status => _status;
  int get currentIndex => _currentIndex;
  int get currentEndpointIndex => _currentEndpointIndex;
  int get attempt => _attempt;
  int get progress => _progress;
  String? get message => _message;
  StreamingProviderDiagnostic? get currentDiagnostic => _currentDiagnostic;
  List<StreamingProviderDiagnostic> get diagnostics =>
      List.unmodifiable([..._diagnostics, ?_currentDiagnostic]);
  bool get isLoading =>
      _status == StreamingPlayerStatus.loading ||
      _status == StreamingPlayerStatus.pageLoaded ||
      _status == StreamingPlayerStatus.suspectedUnavailable ||
      _status == StreamingPlayerStatus.failed;
  bool get canUseControls =>
      _status != StreamingPlayerStatus.loading &&
      _status != StreamingPlayerStatus.pageLoaded &&
      _status != StreamingPlayerStatus.suspectedUnavailable &&
      _status != StreamingPlayerStatus.failed;

  StreamingEmbedResult? get currentCandidate {
    if (_currentIndex < 0 || _currentIndex >= _candidates.length) {
      return null;
    }
    return _candidates[_currentIndex].withResolvedEndpoint(
      _currentEndpointIndex,
    );
  }

  Future<void> initialize() async {
    _timeout?.cancel();
    try {
      _candidates = await repository.buildCandidatesAsync(request);
    } on StreamingRequestException catch (error) {
      _status = StreamingPlayerStatus.unavailable;
      _message = error.message;
      if (kDebugMode) {
        debugPrint('Streaming unavailable: ${error.message}');
      }
      notifyListeners();
      return;
    } catch (error, stack) {
      _status = StreamingPlayerStatus.unavailable;
      _message = 'Internal error: $error';
      if (kDebugMode) {
        debugPrint('Streaming internal error: $error\n$stack');
      }
      notifyListeners();
      return;
    }

    if (_candidates.isEmpty) {
      _status = StreamingPlayerStatus.unavailable;
      _message = 'No configured streaming provider supports this title.';
      notifyListeners();
      return;
    }
    _activate(0, initial: true);
  }

  void beginCurrentAttempt(int expectedAttempt) {
    if (expectedAttempt != _attempt || currentCandidate == null) {
      return;
    }
    _timeout?.cancel();
    _timeout = Timer(currentCandidate!.server.timeout, () {
      failCurrent(expectedAttempt, 'Provider timed out', timeout: true);
    });
  }

  void updateProgress(int expectedAttempt, int progress) {
    if (expectedAttempt != _attempt ||
        (_status != StreamingPlayerStatus.loading &&
            _status != StreamingPlayerStatus.pageLoaded)) {
      return;
    }
    final nextProgress = progress.clamp(0, 100);
    if (_progress == nextProgress) return;
    _progress = nextProgress;
    notifyListeners();
  }

  void markPageLoaded(int expectedAttempt) {
    if (expectedAttempt != _attempt || currentCandidate == null) {
      return;
    }
    _status = StreamingPlayerStatus.ready;
    _progress = 100;
    _message = null;
    _currentDiagnostic = _currentDiagnostic?.copyWith(
      loadFinishedAt: DateTime.now(),
    );
    _readyGraceTimer?.cancel();
    _timeout?.cancel();
    notifyListeners();
  }

  void markReady(int expectedAttempt) {
    if (expectedAttempt != _attempt ||
        currentCandidate == null ||
        _status == StreamingPlayerStatus.suspectedUnavailable ||
        _status == StreamingPlayerStatus.failed) {
      return;
    }
    _timeout?.cancel();
    _readyGraceTimer?.cancel();
    _status = StreamingPlayerStatus.ready;
    _progress = 100;
    _message = null;
    notifyListeners();
  }

  void suspectUnavailable(int expectedAttempt, String reason) {
    if (expectedAttempt != _attempt || currentCandidate == null) {
      return;
    }
    _status = StreamingPlayerStatus.suspectedUnavailable;
    _message = 'This server may not have this title. Trying next server...';
    notifyListeners();
    _readyGraceTimer?.cancel();
    _readyGraceTimer = Timer(const Duration(milliseconds: 650), () {
      failCurrent(expectedAttempt, reason);
    });
  }

  void failCurrent(
    int expectedAttempt,
    String reason, {
    bool timeout = false,
    int? httpStatus,
    bool ssl = false,
    String? blockedNavigationReason,
  }) {
    if (expectedAttempt != _attempt || currentCandidate == null) {
      return;
    }
    _timeout?.cancel();
    _readyGraceTimer?.cancel();
    _status = StreamingPlayerStatus.failed;
    _message = '${currentCandidate!.server.displayName} failed. Switching...';
    _finishDiagnostic(
      reason,
      timeout: timeout,
      httpStatus: httpStatus,
      ssl: ssl,
      blockedNavigationReason: blockedNavigationReason,
    );
    final providerCandidate = _candidates[_currentIndex];
    final nextEndpointIndex = _currentEndpointIndex + 1;
    if (nextEndpointIndex < providerCandidate.resolvedEndpoints.length) {
      _activateEndpoint(nextEndpointIndex, failureReason: reason);
      return;
    }

    final nextIndex = _currentIndex + 1;
    if (nextIndex >= _candidates.length) {
      _status = StreamingPlayerStatus.exhausted;
      _message = 'All streaming servers failed. $reason';
      notifyListeners();
      return;
    }
    _activate(nextIndex, failureReason: reason);
  }

  void retry() {
    retryAll();
  }

  void retryAll() {
    if (_candidates.isEmpty) {
      unawaited(initialize());
      return;
    }
    _activate(0, initial: true);
  }

  void retryCurrent() {
    if (_currentIndex < 0 || _currentIndex >= _candidates.length) {
      retryAll();
      return;
    }
    _activate(_currentIndex, manual: true);
  }

  void tryNextServer() {
    if (_candidates.isEmpty) {
      unawaited(initialize());
      return;
    }
    final nextIndex = _currentIndex + 1;
    if (nextIndex >= _candidates.length) {
      _status = StreamingPlayerStatus.exhausted;
      _message = 'No more streaming servers are available.';
      notifyListeners();
      return;
    }
    _activate(nextIndex, manual: true);
  }

  void selectCandidate(int index) {
    if (index < 0 || index >= _candidates.length) {
      return;
    }
    _activate(index, manual: true);
  }

  void _activate(
    int index, {
    bool initial = false,
    bool manual = false,
    String? failureReason,
  }) {
    _timeout?.cancel();
    _readyGraceTimer?.cancel();
    if (_currentDiagnostic != null) {
      _diagnostics.add(_currentDiagnostic!);
    }
    _currentIndex = index;
    _currentEndpointIndex = 0;
    _startAttempt(
      initial: initial,
      manual: manual,
      failureReason: failureReason,
    );
  }

  void _activateEndpoint(int endpointIndex, {String? failureReason}) {
    _timeout?.cancel();
    _readyGraceTimer?.cancel();
    if (_currentDiagnostic != null) {
      _diagnostics.add(_currentDiagnostic!);
    }
    _currentEndpointIndex = endpointIndex;
    _startAttempt(failureReason: failureReason);
  }

  void _startAttempt({
    bool initial = false,
    bool manual = false,
    String? failureReason,
  }) {
    _attempt++;
    _progress = 0;
    _status = StreamingPlayerStatus.loading;
    final candidate = currentCandidate!;
    _currentDiagnostic = StreamingProviderDiagnostic(
      providerName: candidate.server.displayName,
      host: candidate.url.host,
      endpointId: candidate.endpointId,
      loadStartedAt: DateTime.now(),
    );
    final serverNumber = _currentIndex + 1;
    final providerName = candidate.server.displayName;
    if (initial) {
      _message = 'Trying $providerName...';
    } else if (manual) {
      _message = 'Trying $providerName...';
    } else {
      final isInternalFallback = _currentEndpointIndex > 0;
      _message = isInternalFallback
          ? 'Trying $providerName...'
          : 'Server ${serverNumber - 1} failed, switching to $providerName...';
      if (kDebugMode && failureReason != null) {
        debugPrint('Streaming fallback: $failureReason');
      }
    }
    notifyListeners();
  }

  void _finishDiagnostic(
    String reason, {
    bool timeout = false,
    int? httpStatus,
    bool ssl = false,
    String? blockedNavigationReason,
  }) {
    final diagnostic = _currentDiagnostic;
    if (diagnostic == null) return;
    _currentDiagnostic = diagnostic.copyWith(
      loadFinishedAt: diagnostic.loadFinishedAt ?? DateTime.now(),
      timeout: timeout,
      httpError: httpStatus,
      sslError: ssl,
      blockedNavigationReason: blockedNavigationReason,
      fallbackReason: reason,
    );
    if (kDebugMode) {
      debugPrint(
        'Streaming diagnostic: ${_currentDiagnostic!.toRedactedDebugString()}',
      );
    }
  }

  @override
  void dispose() {
    _timeout?.cancel();
    _readyGraceTimer?.cancel();
    super.dispose();
  }
}
