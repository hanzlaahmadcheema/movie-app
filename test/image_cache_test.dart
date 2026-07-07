import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/local_db/app_database.dart';
import 'package:movie_app/core/local_db/image_cache_dao.dart';
import 'package:movie_app/core/services/local_image_cache_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(sqfliteFfiInit);

  Future<(ImageCacheDao, AppDatabase)> createDao() async {
    final database = AppDatabase(
      databaseFactory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
    );
    addTearDown(database.close);
    return (ImageCacheDao(database: database), database);
  }

  test('image cache row insert/read works', () async {
    final (dao, _) = await createDao();
    final now = DateTime(2026, 1, 1);

    await dao.upsert(
      remoteUrl: 'https://image.tmdb.org/t/p/w500/poster.jpg',
      localPath: '/tmp/poster.jpg',
      imageType: LocalImageCacheService.imageTypePoster,
      now: now,
    );

    final entry = await dao.findByRemoteUrl(
      'https://image.tmdb.org/t/p/w500/poster.jpg',
    );

    expect(entry, isNotNull);
    expect(entry!.remoteUrl, 'https://image.tmdb.org/t/p/w500/poster.jpg');
    expect(entry.localPath, '/tmp/poster.jpg');
    expect(entry.imageType, LocalImageCacheService.imageTypePoster);
    expect(entry.createdAt, now);
    expect(entry.lastAccessedAt, now);
  });

  test(
    'duplicate URL updates lastAccessedAt without resetting createdAt',
    () async {
      final (dao, _) = await createDao();
      final createdAt = DateTime(2026, 1, 1);
      final accessedAt = DateTime(2026, 1, 2);
      const remoteUrl = 'https://image.tmdb.org/t/p/w500/poster.jpg';

      await dao.upsert(
        remoteUrl: remoteUrl,
        localPath: '/tmp/poster-old.jpg',
        imageType: LocalImageCacheService.imageTypePoster,
        now: createdAt,
      );
      await dao.upsert(
        remoteUrl: remoteUrl,
        localPath: '/tmp/poster-new.jpg',
        imageType: LocalImageCacheService.imageTypePoster,
        now: accessedAt,
      );

      final entry = await dao.findByRemoteUrl(remoteUrl);

      expect(entry, isNotNull);
      expect(entry!.localPath, '/tmp/poster-new.jpg');
      expect(entry.createdAt, createdAt);
      expect(entry.lastAccessedAt, accessedAt);
    },
  );

  test('missing file triggers re-download path', () async {
    final (dao, _) = await createDao();
    final cacheDir = await Directory.systemTemp.createTemp('tmdb-cache-test-');
    addTearDown(() async {
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }
    });
    var now = DateTime(2026, 1, 1);
    var downloadCount = 0;
    final service = LocalImageCacheService(
      dao: dao,
      cacheDirectoryProvider: () async => cacheDir,
      nowProvider: () => now,
      downloader: (_) async {
        downloadCount += 1;
        return Uint8List.fromList([1, 2, 3]);
      },
    );

    const remoteUrl = 'https://image.tmdb.org/t/p/w500/poster.jpg';
    final firstFile = await service.cachedFileFor(
      remoteUrl: remoteUrl,
      imageType: LocalImageCacheService.imageTypePoster,
    );
    await firstFile!.delete();
    now = DateTime(2026, 1, 2);

    final secondFile = await service.cachedFileFor(
      remoteUrl: remoteUrl,
      imageType: LocalImageCacheService.imageTypePoster,
    );

    expect(downloadCount, 2);
    expect(await secondFile!.exists(), isTrue);
    final entry = await dao.findByRemoteUrl(remoteUrl);
    expect(entry!.lastAccessedAt, now);
  });

  test('cache cleanup removes old rows/files', () async {
    final (dao, _) = await createDao();
    final cacheDir = await Directory.systemTemp.createTemp('tmdb-cache-test-');
    addTearDown(() async {
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }
    });
    final oldFile = File('${cacheDir.path}/old.jpg');
    await oldFile.writeAsBytes([1, 2, 3]);
    const oldUrl = 'https://image.tmdb.org/t/p/w500/old.jpg';
    const freshUrl = 'https://image.tmdb.org/t/p/w500/fresh.jpg';

    await dao.upsert(
      remoteUrl: oldUrl,
      localPath: oldFile.path,
      imageType: LocalImageCacheService.imageTypePoster,
      now: DateTime(2026, 1, 1),
    );
    await dao.upsert(
      remoteUrl: freshUrl,
      localPath: '${cacheDir.path}/fresh.jpg',
      imageType: LocalImageCacheService.imageTypePoster,
      now: DateTime(2026, 2, 1),
    );
    final service = LocalImageCacheService(
      dao: dao,
      cacheDirectoryProvider: () async => cacheDir,
      nowProvider: () => DateTime(2026, 2, 1),
      downloader: (_) async => Uint8List.fromList([1]),
    );

    await service.cleanupOldCacheFiles(maxAge: const Duration(days: 7));

    expect(await oldFile.exists(), isFalse);
    expect(await dao.findByRemoteUrl(oldUrl), isNull);
    expect(await dao.findByRemoteUrl(freshUrl), isNotNull);
  });
}
