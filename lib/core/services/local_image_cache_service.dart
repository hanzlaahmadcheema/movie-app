import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../local_db/image_cache_dao.dart';

typedef ImageBytesDownloader = Future<Uint8List> Function(Uri uri);
typedef CacheDirectoryProvider = Future<Directory> Function();
typedef NowProvider = DateTime Function();

class LocalImageCacheService {
  LocalImageCacheService({
    ImageCacheDao? dao,
    ImageBytesDownloader? downloader,
    CacheDirectoryProvider? cacheDirectoryProvider,
    NowProvider? nowProvider,
  }) : _dao = dao ?? ImageCacheDao(),
       _downloader = downloader ?? _defaultDownloader,
       _cacheDirectoryProvider =
           cacheDirectoryProvider ?? _defaultCacheDirectoryProvider,
       _nowProvider = nowProvider ?? DateTime.now;

  static final LocalImageCacheService instance = LocalImageCacheService();

  static const imageTypePoster = 'poster';
  static const imageTypeBackdrop = 'backdrop';
  static const imageTypeProfile = 'profile';
  static const imageTypeOther = 'other';
  static const _tmdbImageHost = 'image.tmdb.org';
  static const _cacheFolderName = 'tmdb_image_cache';

  static final Map<String, File> _memCache = {};
  DateTime? _lastCleanupTime;

  final ImageCacheDao _dao;
  final ImageBytesDownloader _downloader;
  final CacheDirectoryProvider _cacheDirectoryProvider;
  final NowProvider _nowProvider;

  Future<File?> cachedFileFor({
    required String remoteUrl,
    required String imageType,
  }) async {
    final normalizedUrl = normalizeTmdbImageUrl(remoteUrl, imageType);
    if (!isCacheableTmdbUrl(normalizedUrl)) {
      return null;
    }

    final cachedMemory = _memCache[normalizedUrl];
    if (cachedMemory != null) {
      if (await cachedMemory.exists()) {
        return cachedMemory;
      }
      _memCache.remove(normalizedUrl);
    }

    final now = _nowProvider();
    final entry = await _dao.findByRemoteUrl(normalizedUrl);
    if (entry != null) {
      final file = File(entry.localPath);
      if (await file.exists()) {
        _memCache[normalizedUrl] = file;
        unawaited(_dao.touch(normalizedUrl, now));
        _maybeCleanupOldCacheFiles();
        return file;
      }
    }

    final file = await _downloadAndCache(
      remoteUrl: normalizedUrl,
      imageType: imageType,
      now: now,
    );
    _memCache[normalizedUrl] = file;
    _maybeCleanupOldCacheFiles();
    return file;
  }

  void _maybeCleanupOldCacheFiles() {
    final now = _nowProvider();
    if (_lastCleanupTime == null ||
        now.difference(_lastCleanupTime!) > const Duration(hours: 24)) {
      _lastCleanupTime = now;
      unawaited(cleanupOldCacheFiles());
    }
  }

  Future<void> cleanupOldCacheFiles({
    Duration maxAge = const Duration(days: 30),
  }) async {
    final cutoff = _nowProvider().subtract(maxAge);
    final oldEntries = await _dao.entriesLastAccessedBefore(cutoff);
    if (oldEntries.isEmpty) {
      return;
    }

    for (final entry in oldEntries) {
      final file = File(entry.localPath);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await _dao.deleteByRemoteUrls(
      oldEntries.map((entry) => entry.remoteUrl).toList(growable: false),
    );
  }

  Future<File> _downloadAndCache({
    required String remoteUrl,
    required String imageType,
    required DateTime now,
  }) async {
    final uri = Uri.parse(remoteUrl);
    final bytes = await _downloader(uri);
    final directory = await _cacheDirectoryProvider();
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final file = File(path.join(directory.path, _fileNameFor(uri)));
    await file.writeAsBytes(bytes, flush: true);
    await _dao.upsert(
      remoteUrl: remoteUrl,
      localPath: file.path,
      imageType: imageType,
      now: now,
    );
    return file;
  }

  static bool isCacheableTmdbUrl(String remoteUrl) {
    final uri = Uri.tryParse(remoteUrl);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host == _tmdbImageHost &&
        uri.pathSegments.length >= 3 &&
        uri.pathSegments[0] == 't' &&
        uri.pathSegments[1] == 'p';
  }

  static String normalizeTmdbImageUrl(String remoteUrl, String imageType) {
    final uri = Uri.tryParse(remoteUrl);
    if (uri == null || uri.host != _tmdbImageHost) {
      return remoteUrl;
    }
    final segments = uri.pathSegments;
    if (segments.length < 3 || segments[0] != 't' || segments[1] != 'p') {
      return remoteUrl;
    }

    final normalizedSegments = [...segments];
    normalizedSegments[2] = _preferredTmdbSize(imageType);
    return uri.replace(pathSegments: normalizedSegments).toString();
  }

  static String imageTypeForUrl(String remoteUrl) {
    final uri = Uri.tryParse(remoteUrl);
    final size = (uri?.pathSegments.length ?? 0) >= 3
        ? uri!.pathSegments[2]
        : '';
    return switch (size) {
      'w342' || 'w500' => imageTypePoster,
      'w780' || 'w1280' => imageTypeBackdrop,
      _ => imageTypeOther,
    };
  }

  static String _preferredTmdbSize(String imageType) {
    return switch (imageType) {
      imageTypeBackdrop => 'w1280',
      imageTypeProfile => 'w342',
      imageTypePoster => 'w500',
      _ => 'w500',
    };
  }

  static String _fileNameFor(Uri uri) {
    final digest = sha1.convert(utf8.encode(uri.toString())).toString();
    final extension = path.extension(uri.path).toLowerCase();
    final safeExtension = switch (extension) {
      '.jpg' || '.jpeg' || '.png' || '.webp' => extension,
      _ => '.img',
    };
    return '$digest$safeExtension';
  }

  static Future<Uint8List> _defaultDownloader(Uri uri) async {
    final response = await http.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'Image download failed with status ${response.statusCode}',
        uri: uri,
      );
    }
    return response.bodyBytes;
  }

  static Future<Directory> _defaultCacheDirectoryProvider() async {
    final cacheDirectory = await getTemporaryDirectory();
    return Directory(path.join(cacheDirectory.path, _cacheFolderName));
  }
}
