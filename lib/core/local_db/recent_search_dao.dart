import 'app_database.dart';

class RecentSearch {
  const RecentSearch({
    required this.id,
    required this.query,
    required this.createdAt,
  });

  final int id;
  final String query;
  final DateTime createdAt;

  factory RecentSearch.fromMap(Map<String, Object?> map) {
    return RecentSearch(
      id: map['id'] as int,
      query: map['query']?.toString() ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        (map['createdAt'] as num?)?.toInt() ?? 0,
      ),
    );
  }
}

class RecentSearchDao {
  RecentSearchDao({AppDatabase? database})
    : _database = database ?? AppDatabase.instance;

  static const _maxStoredSearches = 20;

  final AppDatabase _database;

  Future<List<RecentSearch>> list({int limit = 8}) async {
    final db = await _database.database;
    final rows = await db.query(
      AppDatabase.recentSearchesTable,
      orderBy: 'createdAt DESC, id DESC',
      limit: limit,
    );
    return rows.map(RecentSearch.fromMap).toList();
  }

  Future<void> save(String query) async {
    final normalized = query.trim();
    if (normalized.isEmpty) {
      return;
    }
    final db = await _database.database;
    await db.transaction((txn) async {
      await txn.delete(
        AppDatabase.recentSearchesTable,
        where: 'LOWER(query) = LOWER(?)',
        whereArgs: [normalized],
      );
      await txn.insert(AppDatabase.recentSearchesTable, {
        'query': normalized,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      });
      await txn.rawDelete(
        '''
DELETE FROM ${AppDatabase.recentSearchesTable}
WHERE id NOT IN (
  SELECT id FROM ${AppDatabase.recentSearchesTable}
  ORDER BY createdAt DESC, id DESC
  LIMIT ?
)
''',
        [_maxStoredSearches],
      );
    });
  }

  Future<void> clear() async {
    final db = await _database.database;
    await db.delete(AppDatabase.recentSearchesTable);
  }
}
