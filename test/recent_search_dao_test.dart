import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/local_db/app_database.dart';
import 'package:movie_app/core/local_db/recent_search_dao.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(sqfliteFfiInit);

  Future<RecentSearchDao> createDao() async {
    final database = AppDatabase(
      databaseFactory: databaseFactoryFfi,
      databasePath: inMemoryDatabasePath,
    );
    addTearDown(database.close);
    return RecentSearchDao(database: database);
  }

  test('recent search saves', () async {
    final dao = await createDao();

    await dao.save('Batman');
    final searches = await dao.list();

    expect(searches, hasLength(1));
    expect(searches.first.query, 'Batman');
  });

  test('duplicate search moves to top', () async {
    final dao = await createDao();

    await dao.save('Batman');
    await dao.save('Superman');
    await dao.save('batman');
    final searches = await dao.list();

    expect(searches.map((search) => search.query), ['batman', 'Superman']);
  });

  test('clear recent searches works', () async {
    final dao = await createDao();

    await dao.save('Alien');
    await dao.save('Predator');
    await dao.clear();

    expect(await dao.list(), isEmpty);
  });
}
