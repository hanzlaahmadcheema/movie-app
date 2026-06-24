import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kDefaultJellyfinServerUrl = '';
const kJellyfinServerUrlHint = 'https://your-jellyfin.example.com';

enum JellyfinPlaybackMode {
  auto,
  native,
  web;

  static JellyfinPlaybackMode fromName(String? value) {
    return JellyfinPlaybackMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => JellyfinPlaybackMode.auto,
    );
  }
}

class JellyfinConfig {
  const JellyfinConfig({
    this.enabled = false,
    this.serverUrl = kDefaultJellyfinServerUrl,
    this.accessToken = '',
    this.userId = '',
    this.userName = '',
    this.serverId = '',
    this.displayName = 'Jellyfin Private',
    this.playbackMode = JellyfinPlaybackMode.auto,
    this.lastSyncAt,
    this.deviceId = '',
  });

  final bool enabled;
  final String serverUrl;
  final String accessToken;
  final String userId;
  final String userName;
  final String serverId;
  final String displayName;
  final JellyfinPlaybackMode playbackMode;
  final DateTime? lastSyncAt;
  final String deviceId;

  Uri? get baseUri => normalizeJellyfinBaseUri(serverUrl);

  bool get hasToken => accessToken.trim().isNotEmpty;

  bool get isConfigured =>
      enabled && baseUri != null && hasToken && userId.trim().isNotEmpty;

  bool get needsLogin => !hasToken || userId.trim().isEmpty;

  String? validate() {
    final uri = baseUri;
    if (uri == null) {
      return 'Enter a valid Jellyfin server URL.';
    }
    if (uri.scheme == 'http' && !isAllowedPrivateHttpHost(uri.host)) {
      return 'HTTP is only allowed for local or Tailscale Jellyfin hosts.';
    }
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return 'Jellyfin URL must use HTTP or HTTPS.';
    }
    return null;
  }

  JellyfinConfig copyWith({
    bool? enabled,
    String? serverUrl,
    String? accessToken,
    String? userId,
    String? userName,
    String? serverId,
    String? displayName,
    JellyfinPlaybackMode? playbackMode,
    DateTime? lastSyncAt,
    bool clearLastSyncAt = false,
    String? deviceId,
  }) {
    return JellyfinConfig(
      enabled: enabled ?? this.enabled,
      serverUrl: serverUrl ?? this.serverUrl,
      accessToken: accessToken ?? this.accessToken,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      serverId: serverId ?? this.serverId,
      displayName: displayName ?? this.displayName,
      playbackMode: playbackMode ?? this.playbackMode,
      lastSyncAt: clearLastSyncAt ? null : lastSyncAt ?? this.lastSyncAt,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  JellyfinConfig withoutSession() {
    return copyWith(
      accessToken: '',
      userId: '',
      userName: '',
      serverId: '',
      clearLastSyncAt: true,
    );
  }

  static const empty = JellyfinConfig();
}

abstract class JellyfinConfigStore {
  Future<JellyfinConfig> load();
  Future<void> save(JellyfinConfig config);
  Future<void> clear();
  Future<void> clearSession({String? serverUrl});
}

class SecureJellyfinConfigStore implements JellyfinConfigStore {
  SecureJellyfinConfigStore({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  static final instance = SecureJellyfinConfigStore();

  final FlutterSecureStorage _storage;

  static const _enabledKey = 'jellyfin_enabled';
  static const _serverUrlKey = 'jellyfin_base_url';
  static const _accessTokenKey = 'jellyfin_access_token';
  static const _userIdKey = 'jellyfin_user_id';
  static const _userNameKey = 'jellyfin_username';
  static const _serverIdKey = 'jellyfin_server_id';
  static const _displayNameKey = 'jellyfin_display_name';
  static const _playbackModeKey = 'jellyfin_playback_mode';
  static const _lastSyncAtKey = 'jellyfin_last_sync_at';
  static const _deviceIdKey = 'jellyfin_device_id';

  @override
  Future<JellyfinConfig> load() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = await _storage.read(key: _accessTokenKey) ?? '';
    final deviceId =
        await _storage.read(key: _deviceIdKey) ?? await _ensureDeviceId();
    final serverUrl = prefs.getString(_serverUrlKey)?.trim().isNotEmpty == true
        ? prefs.getString(_serverUrlKey)!.trim()
        : kDefaultJellyfinServerUrl;
    final lastSyncRaw = prefs.getString(_lastSyncAtKey);
    return JellyfinConfig(
      enabled: prefs.getBool(_enabledKey) ?? false,
      serverUrl: serverUrl,
      accessToken: accessToken,
      userId: prefs.getString(_userIdKey) ?? '',
      userName: prefs.getString(_userNameKey) ?? '',
      serverId: prefs.getString(_serverIdKey) ?? '',
      displayName: prefs.getString(_displayNameKey)?.trim().isNotEmpty == true
          ? prefs.getString(_displayNameKey)!.trim()
          : 'Jellyfin Private',
      playbackMode: JellyfinPlaybackMode.fromName(
        prefs.getString(_playbackModeKey),
      ),
      lastSyncAt: lastSyncRaw == null ? null : DateTime.tryParse(lastSyncRaw),
      deviceId: deviceId,
    );
  }

  @override
  Future<void> save(JellyfinConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setBool(_enabledKey, config.enabled),
      prefs.setString(
        _serverUrlKey,
        config.serverUrl.trim().isEmpty
            ? kDefaultJellyfinServerUrl
            : config.serverUrl.trim(),
      ),
      prefs.setString(_userIdKey, config.userId.trim()),
      prefs.setString(_userNameKey, config.userName.trim()),
      prefs.setString(_serverIdKey, config.serverId.trim()),
      prefs.setString(
        _displayNameKey,
        config.displayName.trim().isEmpty
            ? 'Jellyfin Private'
            : config.displayName.trim(),
      ),
      prefs.setString(_playbackModeKey, config.playbackMode.name),
      if (config.lastSyncAt != null)
        prefs.setString(_lastSyncAtKey, config.lastSyncAt!.toIso8601String()),
      if (config.lastSyncAt == null) prefs.remove(_lastSyncAtKey),
      _storage.write(key: _accessTokenKey, value: config.accessToken.trim()),
      _storage.write(
        key: _deviceIdKey,
        value: config.deviceId.trim().isNotEmpty
            ? config.deviceId.trim()
            : await _ensureDeviceId(),
      ),
    ]);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_enabledKey),
      prefs.remove(_serverUrlKey),
      prefs.remove(_userIdKey),
      prefs.remove(_userNameKey),
      prefs.remove(_serverIdKey),
      prefs.remove(_displayNameKey),
      prefs.remove(_playbackModeKey),
      prefs.remove(_lastSyncAtKey),
      _storage.delete(key: _accessTokenKey),
    ]);
  }

  @override
  Future<void> clearSession({String? serverUrl}) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_userIdKey),
      prefs.remove(_userNameKey),
      prefs.remove(_serverIdKey),
      prefs.remove(_lastSyncAtKey),
      if (serverUrl != null) prefs.setString(_serverUrlKey, serverUrl.trim()),
      _storage.delete(key: _accessTokenKey),
    ]);
  }

  Future<String> _ensureDeviceId() async {
    final existing = await _storage.read(key: _deviceIdKey);
    if (existing?.trim().isNotEmpty == true) {
      return existing!.trim();
    }
    final random = Random.secure();
    final seed = List<int>.generate(16, (_) => random.nextInt(256));
    final deviceId = seed
        .map((value) => value.toRadixString(16).padLeft(2, '0'))
        .join();
    await _storage.write(key: _deviceIdKey, value: deviceId);
    return deviceId;
  }
}

class MemoryJellyfinConfigStore implements JellyfinConfigStore {
  MemoryJellyfinConfigStore([JellyfinConfig config = JellyfinConfig.empty])
    : _config = config;

  JellyfinConfig _config;

  @override
  Future<JellyfinConfig> load() async => _config;

  @override
  Future<void> save(JellyfinConfig config) async {
    _config = config;
  }

  @override
  Future<void> clear() async {
    _config = JellyfinConfig.empty;
  }

  @override
  Future<void> clearSession({String? serverUrl}) async {
    _config = _config.withoutSession().copyWith(
      serverUrl: serverUrl ?? _config.serverUrl,
    );
  }
}

Uri? normalizeJellyfinBaseUri(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  final uri = Uri.tryParse(trimmed);
  if (uri == null ||
      !uri.hasScheme ||
      uri.host.isEmpty ||
      (uri.scheme != 'http' && uri.scheme != 'https')) {
    return null;
  }
  return uri.replace(path: '', query: '', fragment: '');
}

bool isAllowedPrivateHttpHost(String host) {
  final value = host.trim().toLowerCase();
  if (value == 'localhost' || value == '127.0.0.1' || value == '::1') {
    return true;
  }
  final parts = value.split('.').map(int.tryParse).toList();
  if (parts.length != 4 || parts.any((part) => part == null)) {
    return false;
  }
  final a = parts[0]!;
  final b = parts[1]!;
  if (a == 10) return true;
  if (a == 192 && b == 168) return true;
  if (a == 172 && b >= 16 && b <= 31) return true;
  if (a == 100 && b >= 64 && b <= 127) return true;
  return false;
}

String redactJellyfinSecret(String value) {
  if (value.trim().isEmpty) return '';
  return '********';
}
