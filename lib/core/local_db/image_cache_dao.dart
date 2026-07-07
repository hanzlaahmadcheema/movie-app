import 'app_database.dart';

class ImageCacheEntry {
  const ImageCacheEntry({
    required this.remoteUrl,
    required this.localPath,
    required this.imageType,
    required this.createdAt,
    required this.lastAccessedAt,
  });

  final String remoteUrl;
  final String localPath;
  final String imageType;
  final DateTime createdAt;
  final DateTime lastAccessedAt;

  factory ImageCacheEntry.fromMap(Map<String, Object?> map) {
    return ImageCacheEntry(
      remoteUrl: map['remoteUrl']?.toString() ?? '',
      localPath: map['localPath']?.toString() ?? '',
      imageType: map['imageType']?.toString() ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (map['createdAt'] as num?)?.toInt() ?? 0,
      ),
      lastAccessedAt: DateTime.fromMillisecondsSinceEpoch(
        (map['lastAccessedAt'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}

class ImageCacheDao {
  ImageCacheDao({AppDatabase? database})
    : _database = database ?? AppDatabase.instance;

  final AppDatabase _database;

  Future<ImageCacheEntry?> findByRemoteUrl(String remoteUrl) async {
    final normalized = remoteUrl.trim();
    if (normalized.isEmpty) {
      return null;
    }
    final db = await _database.database;
    final rows = await db.query(
      AppDatabase.imageCacheTable,
      where: 'remoteUrl = ?',
      whereArgs: [normalized],
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }
    return ImageCacheEntry.fromMap(rows.first);
  }

  Future<void> upsert({
    required String remoteUrl,
    required String localPath,
    required String imageType,
    required DateTime now,
  }) async {
    final normalized = remoteUrl.trim();
    if (normalized.isEmpty || localPath.trim().isEmpty) {
      return;
    }
    final db = await _database.database;
    final timestamp = now.millisecondsSinceEpoch;
    await db.transaction((txn) async {
      final existing = await txn.query(
        AppDatabase.imageCacheTable,
        columns: const ['remoteUrl'],
        where: 'remoteUrl = ?',
        whereArgs: [normalized],
        limit: 1,
      );
      if (existing.isEmpty) {
        await txn.insert(AppDatabase.imageCacheTable, {
          'remoteUrl': normalized,
          'localPath': localPath,
          'imageType': imageType,
          'createdAt': timestamp,
          'lastAccessedAt': timestamp,
        });
        return;
      }

      await txn.update(
        AppDatabase.imageCacheTable,
        {
          'localPath': localPath,
          'imageType': imageType,
          'lastAccessedAt': timestamp,
        },
        where: 'remoteUrl = ?',
        whereArgs: [normalized],
      );
    });
  }

  Future<void> touch(String remoteUrl, DateTime now) async {
    final normalized = remoteUrl.trim();
    if (normalized.isEmpty) {
      return;
    }
    final db = await _database.database;
    await db.update(
      AppDatabase.imageCacheTable,
      {'lastAccessedAt': now.millisecondsSinceEpoch},
      where: 'remoteUrl = ?',
      whereArgs: [normalized],
    );
  }

  Future<List<ImageCacheEntry>> entriesLastAccessedBefore(
    DateTime cutoff,
  ) async {
    final db = await _database.database;
    final rows = await db.query(
      AppDatabase.imageCacheTable,
      where: 'lastAccessedAt < ?',
      whereArgs: [cutoff.millisecondsSinceEpoch],
      orderBy: 'lastAccessedAt ASC',
    );
    return rows.map(ImageCacheEntry.fromMap).toList();
  }

  Future<void> deleteByRemoteUrls(List<String> remoteUrls) async {
    if (remoteUrls.isEmpty) {
      return;
    }
    final db = await _database.database;
    final placeholders = List.filled(remoteUrls.length, '?').join(', ');
    await db.delete(
      AppDatabase.imageCacheTable,
      where: 'remoteUrl IN ($placeholders)',
      whereArgs: remoteUrls,
    );
  }
}
