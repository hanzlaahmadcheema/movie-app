import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'jellyfin_config.dart';
import 'jellyfin_item.dart';
import 'jellyfin_playback_info.dart';

class JellyfinConnectionResult {
  const JellyfinConnectionResult({
    required this.serverName,
    required this.version,
  });

  final String serverName;
  final String version;
}

class JellyfinLoginResult {
  const JellyfinLoginResult({
    required this.accessToken,
    required this.userId,
    required this.userName,
    required this.serverId,
  });

  final String accessToken;
  final String userId;
  final String userName;
  final String serverId;
}

class JellyfinAuthenticatedUser {
  const JellyfinAuthenticatedUser({required this.id, required this.name});

  final String id;
  final String name;

  factory JellyfinAuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return JellyfinAuthenticatedUser(
      id: (json['Id'] ?? '').toString(),
      name: (json['Name'] ?? '').toString(),
    );
  }
}

class JellyfinException implements Exception {
  const JellyfinException(this.message, {this.debugReason});

  final String message;
  final String? debugReason;

  @override
  String toString() => message;
}

class JellyfinClient {
  JellyfinClient({
    required this.config,
    http.Client? httpClient,
    this.timeout = const Duration(seconds: 8),
  }) : _httpClient = httpClient ?? http.Client();

  static const _clientName = 'MovieApp';
  static const _deviceName = 'Flutter';
  static const _clientVersion = '1.0.0';

  final JellyfinConfig config;
  final http.Client _httpClient;
  final Duration timeout;

  Future<JellyfinConnectionResult> testConnection() async {
    final info = await _getJson('/System/Info', requireToken: false);
    return JellyfinConnectionResult(
      serverName: (info['ServerName'] ?? info['LocalAddress'] ?? 'Jellyfin')
          .toString(),
      version: (info['Version'] ?? 'Unknown').toString(),
    );
  }

  Future<JellyfinLoginResult> login({
    required String username,
    required String password,
  }) async {
    if (username.trim().isEmpty || password.isEmpty) {
      throw const JellyfinException(
        'Enter your Jellyfin username and password.',
      );
    }
    final json = await _postJson(
      '/Users/AuthenticateByName',
      body: {'Username': username.trim(), 'Pw': password},
      requireToken: false,
      includeAuthorization: true,
    );
    if (json is! Map<String, dynamic>) {
      throw const JellyfinException(
        'Jellyfin returned an invalid login response.',
      );
    }
    final accessToken = (json['AccessToken'] ?? '').toString().trim();
    final userJson = json['User'];
    final userId = userJson is Map
        ? (userJson['Id'] ?? '').toString().trim()
        : '';
    final userName = userJson is Map
        ? (userJson['Name'] ?? username).toString().trim()
        : username.trim();
    final serverId = (json['ServerId'] ?? '').toString().trim();
    if (accessToken.isEmpty || userId.isEmpty) {
      throw const JellyfinException(
        'Jellyfin login did not return a valid session.',
      );
    }
    return JellyfinLoginResult(
      accessToken: accessToken,
      userId: userId,
      userName: userName,
      serverId: serverId,
    );
  }

  Future<JellyfinAuthenticatedUser> validateSession() async {
    final json = await _getJson('/Users/Me');
    if (json is! Map<String, dynamic>) {
      throw const JellyfinException(
        'Jellyfin returned an invalid session response.',
      );
    }
    final user = JellyfinAuthenticatedUser.fromJson(json);
    if (user.id.isEmpty) {
      throw const JellyfinException(
        'Jellyfin session is invalid. Please log in again.',
      );
    }
    return user;
  }

  Future<List<JellyfinItem>> getItems(String userId) async {
    final encodedUserId = Uri.encodeComponent(userId);
    final json = await _getJson(
      '/Users/$encodedUserId/Items',
      query: const {
        'Recursive': 'true',
        'IncludeItemTypes': 'Movie,Series,Episode',
        'Fields':
            'ProviderIds,Path,ParentId,SeriesId,SeasonId,IndexNumber,ParentIndexNumber,ProductionYear,UserData,ImageTags',
      },
    );
    if (json is! Map || json['Items'] is! List) {
      return const [];
    }
    return (json['Items'] as List)
        .whereType<Map<String, dynamic>>()
        .map(JellyfinItem.fromJson)
        .where((item) => item.id.isNotEmpty)
        .toList(growable: false);
  }

  Future<JellyfinItem> getItem({
    required String itemId,
    required String userId,
  }) async {
    if (itemId.trim().isEmpty) {
      throw const JellyfinException('Missing Jellyfin item ID.');
    }
    final encodedUserId = Uri.encodeComponent(userId.trim());
    final encodedItemId = Uri.encodeComponent(itemId.trim());
    final json = await _getJson(
      '/Users/$encodedUserId/Items/$encodedItemId',
      query: const {
        'Fields': 'ProviderIds,UserData,ParentId,SeriesId,SeasonId',
      },
    );
    if (json is! Map<String, dynamic>) {
      throw const JellyfinException('Jellyfin returned an invalid item.');
    }
    final item = JellyfinItem.fromJson(json);
    if (item.id.isEmpty) {
      throw const JellyfinException('Jellyfin item was not found.');
    }
    return item;
  }

  Future<JellyfinPlaybackInfo> getPlaybackInfo({
    required String itemId,
    required String userId,
  }) async {
    if (itemId.trim().isEmpty) {
      throw const JellyfinException('Missing Jellyfin item ID.');
    }
    final encodedItemId = Uri.encodeComponent(itemId.trim());
    final json = await _getJson(
      '/Items/$encodedItemId/PlaybackInfo',
      query: {
        'UserId': userId.trim(),
        'StartTimeTicks': '0',
        'IsPlayback': 'true',
        'AutoOpenLiveStream': 'true',
        'MaxStreamingBitrate': '120000000',
      },
    );
    if (json is! Map<String, dynamic>) {
      throw const JellyfinException('Jellyfin returned invalid PlaybackInfo.');
    }
    return JellyfinPlaybackInfo.fromJson(json);
  }

  Future<void> reportPlaybackStart({
    required String itemId,
    required String mediaSourceId,
    required int positionSeconds,
    String? playSessionId,
    bool isPaused = false,
  }) {
    return _postWithoutResponse(
      '/Sessions/Playing',
      body: _playbackSessionBody(
        itemId: itemId,
        mediaSourceId: mediaSourceId,
        positionSeconds: positionSeconds,
        playSessionId: playSessionId,
        isPaused: isPaused,
      ),
    );
  }

  Future<void> reportPlaybackProgress({
    required String itemId,
    required String mediaSourceId,
    required int positionSeconds,
    String? playSessionId,
    bool isPaused = false,
  }) {
    return _postWithoutResponse(
      '/Sessions/Playing/Progress',
      body: _playbackSessionBody(
        itemId: itemId,
        mediaSourceId: mediaSourceId,
        positionSeconds: positionSeconds,
        playSessionId: playSessionId,
        isPaused: isPaused,
      ),
    );
  }

  Future<void> reportPlaybackStopped({
    required String itemId,
    required String mediaSourceId,
    required int positionSeconds,
    String? playSessionId,
  }) {
    return _postWithoutResponse(
      '/Sessions/Playing/Stopped',
      body: _playbackSessionBody(
        itemId: itemId,
        mediaSourceId: mediaSourceId,
        positionSeconds: positionSeconds,
        playSessionId: playSessionId,
      ),
    );
  }

  Map<String, String> _headers({
    required bool includeToken,
    bool includeAuthorization = false,
    Map<String, String>? extra,
  }) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (includeAuthorization)
        'X-Emby-Authorization':
            'MediaBrowser Client="$_clientName", Device="$_deviceName", DeviceId="${config.deviceId}", Version="$_clientVersion"',
      if (includeToken) 'X-Emby-Token': config.accessToken.trim(),
      ...?extra,
    };
    return headers;
  }

  Future<dynamic> _getJson(
    String path, {
    Map<String, String>? query,
    bool requireToken = true,
  }) async {
    final uri = _buildUri(path, query: query);
    final response = await _send(
      () => _httpClient.get(uri, headers: _headers(includeToken: requireToken)),
      requireToken: requireToken,
    );
    return _decodeJson(response.body);
  }

  Future<dynamic> _postJson(
    String path, {
    required Map<String, Object?> body,
    bool requireToken = true,
    bool includeAuthorization = false,
  }) async {
    final uri = _buildUri(path);
    final response = await _send(
      () => _httpClient.post(
        uri,
        headers: _headers(
          includeToken: requireToken,
          includeAuthorization: includeAuthorization,
        ),
        body: jsonEncode(body),
      ),
      requireToken: requireToken,
    );
    return _decodeJson(response.body);
  }

  Future<void> _postWithoutResponse(
    String path, {
    required Map<String, Object?> body,
    bool requireToken = true,
  }) async {
    final uri = _buildUri(path);
    await _send(
      () => _httpClient.post(
        uri,
        headers: _headers(includeToken: requireToken),
        body: jsonEncode(body),
      ),
      requireToken: requireToken,
    );
  }

  Map<String, Object?> _playbackSessionBody({
    required String itemId,
    required String mediaSourceId,
    required int positionSeconds,
    String? playSessionId,
    bool isPaused = false,
  }) {
    return {
      'ItemId': itemId.trim(),
      'MediaSourceId': mediaSourceId.trim(),
      'PositionTicks': positionSeconds < 0 ? 0 : positionSeconds * 10000000,
      'CanSeek': true,
      'IsPaused': isPaused,
      if (playSessionId?.trim().isNotEmpty == true)
        'PlaySessionId': playSessionId!.trim(),
    };
  }

  Uri _buildUri(String path, {Map<String, String>? query}) {
    final baseUri = config.baseUri;
    if (baseUri == null) {
      throw const JellyfinException('Invalid Jellyfin server URL.');
    }
    final configError = config.validate();
    if (configError != null) {
      throw JellyfinException(configError);
    }
    return baseUri.resolve(path).replace(queryParameters: query);
  }

  Future<http.Response> _send(
    Future<http.Response> Function() request, {
    required bool requireToken,
  }) async {
    if (requireToken && config.accessToken.trim().isEmpty) {
      throw const JellyfinException('Jellyfin login required.');
    }
    try {
      final response = await request().timeout(timeout);
      if (response.statusCode == 401 || response.statusCode == 403) {
        throw const JellyfinException(
          'Jellyfin session expired. Please log in again.',
          debugReason: 'unauthorized',
        );
      }
      if (response.statusCode == 404) {
        throw const JellyfinException('Jellyfin endpoint was not found.');
      }
      if (response.statusCode == 400 && !requireToken) {
        throw const JellyfinException(
          'Invalid Jellyfin username or password.',
          debugReason: 'bad_credentials',
        );
      }
      if (response.statusCode >= 400) {
        throw JellyfinException(
          'Jellyfin returned HTTP ${response.statusCode}.',
          debugReason: 'http_${response.statusCode}',
        );
      }
      return response;
    } on TimeoutException {
      throw const JellyfinException(
        'Jellyfin timed out. Make sure Tailscale is connected.',
        debugReason: 'timeout',
      );
    } on SocketException {
      throw const JellyfinException(
        'Jellyfin is unreachable. Make sure Tailscale is connected.',
        debugReason: 'socket',
      );
    } on FormatException {
      throw const JellyfinException(
        'Jellyfin returned an invalid response.',
        debugReason: 'invalid_json',
      );
    } on http.ClientException {
      throw const JellyfinException(
        'Jellyfin is unreachable. Make sure Tailscale is connected.',
        debugReason: 'client',
      );
    }
  }

  dynamic _decodeJson(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      throw const JellyfinException(
        'Jellyfin returned an invalid response.',
        debugReason: 'invalid_json',
      );
    }
  }
}
