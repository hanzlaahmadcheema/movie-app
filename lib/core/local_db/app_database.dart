import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;

class AppDatabase {
  AppDatabase({sqflite.DatabaseFactory? databaseFactory, String? databasePath})
    : _databaseFactory = databaseFactory,
      _databasePathOverride = databasePath;

  static final AppDatabase instance = AppDatabase();

  static const recentSearchesTable = 'recent_searches';
  static const imageCacheTable = 'image_cache';

  final sqflite.DatabaseFactory? _databaseFactory;
  final String? _databasePathOverride;
  sqflite.Database? _database;

  Future<sqflite.Database> get database async {
    final existing = _database;
    if (existing != null && existing.isOpen) {
      return existing;
    }
    final dbPath = _databasePathOverride ?? await _defaultDatabasePath();
    final factory = _databaseFactory ?? sqflite.databaseFactory;
    _database = await factory.openDatabase(
      dbPath,
      options: sqflite.OpenDatabaseOptions(
        version: 2,
        onCreate: _createSchema,
        onUpgrade: _upgradeSchema,
      ),
    );
    return _database!;
  }

  Future<void> close() async {
    final existing = _database;
    _database = null;
    if (existing != null && existing.isOpen) {
      await existing.close();
    }
  }

  Future<String> _defaultDatabasePath() async {
    final databasesPath = await sqflite.getDatabasesPath();
    return path.join(databasesPath, 'movie_app.db');
  }

  Future<void> _createSchema(sqflite.Database db, int version) async {
    await _createRecentSearchesTable(db);
    await _createImageCacheTable(db);
  }

  Future<void> _upgradeSchema(
    sqflite.Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await _createImageCacheTable(db);
    }
  }

  Future<void> _createRecentSearchesTable(sqflite.Database db) async {
    await db.execute('''
CREATE TABLE $recentSearchesTable (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  query TEXT NOT NULL,
  createdAt INTEGER NOT NULL
)
''');
    await db.execute(
      'CREATE INDEX idx_recent_searches_createdAt '
      'ON $recentSearchesTable(createdAt DESC)',
    );
  }

  Future<void> _createImageCacheTable(sqflite.Database db) async {
    await db.execute('''
CREATE TABLE $imageCacheTable (
  remoteUrl TEXT PRIMARY KEY,
  localPath TEXT NOT NULL,
  imageType TEXT NOT NULL,
  createdAt INTEGER NOT NULL,
  lastAccessedAt INTEGER NOT NULL
)
''');
    await db.execute(
      'CREATE INDEX idx_image_cache_lastAccessedAt '
      'ON $imageCacheTable(lastAccessedAt DESC)',
    );
  }
}
