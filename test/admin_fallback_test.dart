import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/models/movie_item.dart';
import 'package:movie_app/core/services/admin_repository.dart';
import 'package:movie_app/features/admin/admin_screens.dart';
import 'package:movie_app/features/home/home_screen.dart';
import 'package:movie_app/widgets/state_views.dart';

void main() {
  test('missing appConfig uses defaults', () async {
    final repository = AdminRepository.test(
      appConfigLoader: () async =>
          throw FirebaseException(plugin: 'cloud_firestore', code: 'not-found'),
    );

    final config = await repository.loadPublicAppConfig();

    expect(config.maintenanceMode, isFalse);
    expect(config.signupEnabled, isTrue);
    expect(config.googleLoginEnabled, isTrue);
    expect(config.phoneLoginEnabled, isTrue);
    expect(config.jellyfinEnabled, isTrue);
  });

  test('empty providers uses default provider order', () async {
    final providers = await AdminRepository.test(
      providersLoader: () async => _FakeQuerySnapshot(const []),
    ).loadProviders();

    expect(providers.map((provider) => provider.providerId), [
      'jellyfin_native',
      'jellyfin_web',
      'videasy',
      'streamvault',
      '111movies',
      'vidsrc',
      '2embed',
    ]);
  });

  test(
    'admin dashboard partial query failure does not fail stats loading',
    () async {
      final stats = await AdminRepository.test(
        usersSnapshotLoader: () async => throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'permission-denied',
        ),
        logsSnapshotLoader: () async => throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'unavailable',
        ),
        requestsSnapshotLoader: () async => throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'failed-precondition',
        ),
        providersLoader: () async => _FakeQuerySnapshot(const []),
        appConfigLoader: () async => throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
        ),
      ).loadDashboardStats();

      expect(stats.totalUsers, 'Unavailable');
      expect(stats.playbackErrors, 'Unavailable');
      expect(stats.providerStatuses, '7');
      expect(stats.jellyfinStatus, 'Enabled');
    },
  );

  testWidgets('empty banners, featured, and notices do not break Home', (
    tester,
  ) async {
    final items = List<MovieItem>.generate(
      3,
      (index) => MovieItem(
        id: index + 1,
        title: 'Item ${index + 1}',
        type: 'Movie',
        year: '2026',
        quality: 'HD',
        posterUrl: 'https://example.com/$index.jpg',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(
          dataLoader: () async => HomeContentData(
            heroItems: const [],
            featuredItems: const [],
            trendingMovies: items,
            trendingSeries: items,
            latestMovies: items,
            latestSeries: items,
            notices: const [],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AppErrorView), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('admin dashboard can render unavailable cards without failing', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AdminDashboardScreen(
          statsLoader: () async => const AdminDashboardStats(
            totalUsers: 'Unavailable',
            activeUsers: '5',
            newUsersToday: 'Unavailable',
            watchlistRecords: '12',
            continueWatchingRecords: 'Unavailable',
            playbackErrors: 'Unavailable',
            providerStatuses: '4',
            jellyfinStatus: 'Disabled',
            latestReports: '2',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(AppErrorView), findsNothing);
    expect(find.text('Admin Panel'), findsOneWidget);
    expect(find.text('Unavailable'), findsWidgets);
  });

  test('firestore rules allow public config reads and admin-only writes', () {
    final rules = _rulesText();

    expect(rules, contains('match /appConfig/main {'));
    expect(rules, contains('allow read: if true;'));
    expect(
      rules,
      contains(
        'allow write: if isAdmin() && validAppConfigWrite(request.resource.data);',
      ),
    );
    expect(rules, contains('match /providers/{providerId} {'));
    expect(rules, contains('allow read: if true;'));
  });

  test('firestore rules protect admin collections from normal-user writes', () {
    final rules = _rulesText();

    expect(rules, contains('match /banners/{bannerId} {'));
    expect(
      rules,
      contains(
        'allow write: if isAdmin() && validBannerWrite(request.resource.data);',
      ),
    );
    expect(rules, contains('match /featuredContent/{itemId} {'));
    expect(
      rules,
      contains(
        'allow write: if isAdmin() && validFeaturedWrite(request.resource.data);',
      ),
    );
    expect(rules, contains('match /notices/{noticeId} {'));
    expect(
      rules,
      contains(
        'allow write: if isAdmin() && validNoticeWrite(request.resource.data);',
      ),
    );
  });

  test(
    'firestore rules allow admin reads for users, playback logs, and content requests',
    () {
      final rules = _rulesText();

      expect(rules, contains('allow read: if isOwner(uid) || isAdmin();'));
      expect(rules, contains('match /playbackLogs/{logId} {'));
      expect(rules, contains('allow read, update, delete: if isAdmin();'));
      expect(rules, contains('match /contentRequests/{requestId} {'));
      expect(
        rules,
        contains(
          'allow read: if isAdmin() || (isSignedIn() && resource.data.userId == request.auth.uid);',
        ),
      );
    },
  );
}

String _rulesText() {
  return File('firestore.rules').readAsStringSync();
}

class _FakeQuerySnapshot extends Fake
    implements QuerySnapshot<Map<String, dynamic>> {
  _FakeQuerySnapshot(this._docs);

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs;

  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs => _docs;

  @override
  int get size => _docs.length;
}
