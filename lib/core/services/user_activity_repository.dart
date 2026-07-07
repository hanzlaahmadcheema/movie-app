import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/detail_item.dart';
import '../models/movie_item.dart';

enum UserReaction { like, unlike }

class UserContentRecord {
  const UserContentRecord({
    required this.contentKey,
    required this.item,
    this.addedAt,
    this.watchedAt,
    this.updatedAt,
    this.lastAction,
    this.lastWatchedAt,
    this.startedAt,
    this.activity = const UserActivity(),
  });

  final String contentKey;
  final MovieItem item;
  final DateTime? addedAt;
  final DateTime? watchedAt;
  final DateTime? updatedAt;
  final String? lastAction;
  final DateTime? lastWatchedAt;
  final DateTime? startedAt;
  final UserActivity activity;

  factory UserContentRecord.fromJson(Map<String, dynamic> json) {
    final mediaType = json['mediaType'] == 'tv'
        ? MediaType.tv
        : MediaType.movie;
    final voteAverage = json['voteAverage'] is num
        ? (json['voteAverage'] as num).toDouble()
        : 0.0;
    final item = MovieItem(
      id: json['tmdbId'] is int ? json['tmdbId'] as int : 0,
      title: (json['title'] ?? '').toString(),
      type: mediaType == MediaType.tv ? 'Series' : 'Movie',
      year: (json['year'] ?? 'N/A').toString(),
      quality: 'HD',
      posterUrl: (json['posterUrl'] ?? '').toString(),
      backdropUrl: (json['backdropUrl'] ?? '').toString(),
      posterPath: json['posterPath']?.toString(),
      backdropPath: json['backdropPath']?.toString(),
      imdbId: json['imdbId']?.toString(),
      originCountryCodes: _stringList(json['originCountryCodes']),
      mediaType: mediaType,
      voteAverage: voteAverage,
      rating: voteAverage.toStringAsFixed(1),
    );

    return UserContentRecord(
      contentKey: (json['contentKey'] ?? contentKeyFor(item)).toString(),
      item: item,
      addedAt: _timestampToDate(json['addedAt']),
      watchedAt: _timestampToDate(json['watchedAt']),
      updatedAt: _timestampToDate(json['updatedAt']),
      lastAction: json['lastAction']?.toString(),
      lastWatchedAt: _timestampToDate(json['lastWatchedAt']),
      startedAt: _timestampToDate(json['startedAt']),
      activity: UserActivity.fromJson(json),
    );
  }
}

class UserActivity {
  const UserActivity({
    this.reaction,
    this.selectedServer,
    this.seasonNumber,
    this.episodeNumber,
    this.episodeTitle,
    this.positionSeconds = 0,
    this.durationSeconds,
    this.providerId,
    this.jellyfinItemId,
    this.playbackMode,
    this.mediaSourceId,
  });

  final UserReaction? reaction;
  final String? selectedServer;
  final int? seasonNumber;
  final int? episodeNumber;
  final String? episodeTitle;
  final int positionSeconds;
  final int? durationSeconds;
  final String? providerId;
  final String? jellyfinItemId;
  final String? playbackMode;
  final String? mediaSourceId;

  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return UserActivity(
      reaction: switch (json['reaction']) {
        'like' => UserReaction.like,
        'unlike' => UserReaction.unlike,
        _ => null,
      },
      selectedServer: json['selectedServer'] as String?,
      seasonNumber: json['seasonNumber'] as int?,
      episodeNumber: json['episodeNumber'] as int?,
      episodeTitle: json['episodeTitle'] as String?,
      positionSeconds: json['positionSeconds'] is int
          ? json['positionSeconds'] as int
          : 0,
      durationSeconds: json['durationSeconds'] is int
          ? json['durationSeconds'] as int
          : null,
      providerId: json['providerId'] as String?,
      jellyfinItemId: json['jellyfinItemId'] as String?,
      playbackMode: json['playbackMode'] as String?,
      mediaSourceId: json['mediaSourceId'] as String?,
    );
  }
}

class UserActivityRepository {
  UserActivityRepository._();

  static final UserActivityRepository instance = UserActivityRepository._();

  FirebaseFirestore? get _firestore {
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseFirestore.instance;
  }

  Stream<Set<String>> watchlistKeysStream(User? user) {
    final firestore = _firestore;
    if (user == null || firestore == null) {
      return Stream<Set<String>>.value(<String>{});
    }

    return _userDoc(firestore, user)
        .collection('watchlist')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toSet());
  }

  Stream<bool> watchlistStateStream(User? user, MovieItem item) {
    final firestore = _firestore;
    if (user == null || firestore == null || item.id == 0) {
      return Stream<bool>.value(false);
    }

    return _watchlistDoc(
      firestore,
      user,
      item,
    ).snapshots().map((snapshot) => snapshot.exists);
  }

  Stream<bool> watchedStateStream(User? user, MovieItem item) {
    final firestore = _firestore;
    if (user == null || firestore == null || item.id == 0) {
      return Stream<bool>.value(false);
    }

    return _watchedDoc(
      firestore,
      user,
      item,
    ).snapshots().map((snapshot) => snapshot.exists);
  }

  Stream<UserActivity> activityStream(User? user, MovieItem item) {
    final firestore = _firestore;
    if (user == null || firestore == null || item.id == 0) {
      return Stream<UserActivity>.value(const UserActivity());
    }

    return _activityDoc(firestore, user, item).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return const UserActivity();
      }
      return UserActivity.fromJson(data);
    });
  }

  Stream<List<UserContentRecord>> watchlistStream(User? user) {
    final firestore = _firestore;
    if (user == null || firestore == null) {
      return Stream<List<UserContentRecord>>.value(const []);
    }

    return _userDoc(firestore, user)
        .collection('watchlist')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserContentRecord.fromJson(doc.data()))
              .where((record) => record.item.id != 0)
              .toList(),
        );
  }

  Stream<List<UserContentRecord>> watchedStream(User? user) {
    final firestore = _firestore;
    if (user == null || firestore == null) {
      return Stream<List<UserContentRecord>>.value(const []);
    }

    return _userDoc(firestore, user)
        .collection('watched')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserContentRecord.fromJson(doc.data()))
              .where((record) => record.item.id != 0)
              .toList(),
        );
  }

  Stream<List<UserContentRecord>> activityListStream(User? user) {
    final firestore = _firestore;
    if (user == null || firestore == null) {
      return Stream<List<UserContentRecord>>.value(const []);
    }

    return _userDoc(firestore, user)
        .collection('activity')
        .orderBy('updatedAt', descending: true)
        .limit(50)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserContentRecord.fromJson(doc.data()))
              .where((record) => record.item.id != 0)
              .toList(),
        );
  }

  Future<void> setWatchlisted({
    required User user,
    required MovieItem item,
    required bool active,
  }) async {
    final firestore = _requireFirestore();
    final doc = _watchlistDoc(firestore, user, item);
    if (!active) {
      await doc.delete();
      return;
    }

    await doc.set({
      ..._contentSnapshot(item),
      'addedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> setWatched({
    required User user,
    required MovieItem item,
    required bool active,
  }) async {
    final firestore = _requireFirestore();
    final doc = _watchedDoc(firestore, user, item);
    if (!active) {
      await doc.delete();
      return;
    }

    await doc.set({
      ..._contentSnapshot(item),
      'watchedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> removeActivity({
    required User user,
    required MovieItem item,
  }) async {
    final firestore = _requireFirestore();
    final doc = _activityDoc(firestore, user, item);
    await doc.delete();
  }

  Future<void> markOpened({required User user, required MovieItem item}) {
    return _writeActivity(
      user: user,
      item: item,
      data: {
        'lastAction': 'opened',
        'lastWatchedAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> markPlayed({required User user, required MovieItem item}) {
    return _writeActivity(
      user: user,
      item: item,
      data: {
        'positionSeconds': 0,
        'lastAction': 'played',
        'lastWatchedAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> markStreamingStarted({
    required User user,
    required MovieItem item,
    required String server,
    String? providerId,
    String? jellyfinItemId,
    int? seasonNumber,
    int? episodeNumber,
    String? episodeTitle,
    int? positionSeconds,
    int? durationSeconds,
    String? playbackMode,
    String? mediaSourceId,
  }) {
    return _writeActivity(
      user: user,
      item: item,
      data: {
        ...streamingActivityData(
          server: server,
          providerId: providerId,
          jellyfinItemId: jellyfinItemId,
          seasonNumber: seasonNumber,
          episodeNumber: episodeNumber,
          episodeTitle: episodeTitle,
          positionSeconds: positionSeconds,
          durationSeconds: durationSeconds,
          playbackMode: playbackMode,
          mediaSourceId: mediaSourceId,
        ),
        'lastWatchedAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> setReaction({
    required User user,
    required MovieItem item,
    required UserReaction? reaction,
  }) {
    return _writeActivity(
      user: user,
      item: item,
      data: {
        if (reaction == null) 'reaction': FieldValue.delete(),
        if (reaction != null) 'reaction': reaction.name,
        'lastAction': 'reactionChanged',
      },
    );
  }

  Future<void> setSelectedServer({
    required User user,
    required MovieItem item,
    required String server,
  }) {
    return _writeActivity(
      user: user,
      item: item,
      data: {'selectedServer': server, 'lastAction': 'serverSelected'},
    );
  }

  Future<void> setSelectedEpisode({
    required User user,
    required MovieItem item,
    required int seasonNumber,
    required Episode episode,
  }) {
    return _writeActivity(
      user: user,
      item: item,
      data: {
        'seasonNumber': seasonNumber,
        'episodeNumber': episode.number,
        'episodeTitle': episode.title,
        'positionSeconds': 0,
        'lastAction': 'episodeSelected',
        'lastWatchedAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> setSelectedSeason({
    required User user,
    required MovieItem item,
    required int seasonNumber,
  }) {
    return _writeActivity(
      user: user,
      item: item,
      data: {
        'seasonNumber': seasonNumber,
        'episodeNumber': FieldValue.delete(),
        'episodeTitle': FieldValue.delete(),
        'positionSeconds': 0,
        'lastAction': 'episodeSelected',
        'lastWatchedAt': FieldValue.serverTimestamp(),
      },
    );
  }

  Future<void> _writeActivity({
    required User user,
    required MovieItem item,
    required Map<String, Object?> data,
  }) {
    final firestore = _requireFirestore();
    return _activityDoc(firestore, user, item).set({
      ..._contentSnapshot(item),
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  DocumentReference<Map<String, dynamic>> _watchlistDoc(
    FirebaseFirestore firestore,
    User user,
    MovieItem item,
  ) {
    return _userDoc(
      firestore,
      user,
    ).collection('watchlist').doc(contentKeyFor(item));
  }

  DocumentReference<Map<String, dynamic>> _activityDoc(
    FirebaseFirestore firestore,
    User user,
    MovieItem item,
  ) {
    return _userDoc(
      firestore,
      user,
    ).collection('activity').doc(contentKeyFor(item));
  }

  DocumentReference<Map<String, dynamic>> _watchedDoc(
    FirebaseFirestore firestore,
    User user,
    MovieItem item,
  ) {
    return _userDoc(
      firestore,
      user,
    ).collection('watched').doc(contentKeyFor(item));
  }

  DocumentReference<Map<String, dynamic>> _userDoc(
    FirebaseFirestore firestore,
    User user,
  ) {
    return firestore.collection('users').doc(user.uid);
  }

  FirebaseFirestore _requireFirestore() {
    final firestore = _firestore;
    if (firestore == null) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        code: 'firebase-not-initialized',
        message: 'Firebase has not been initialized.',
      );
    }
    return firestore;
  }
}

String contentKeyFor(MovieItem item) {
  final mediaType = item.mediaType == MediaType.tv ? 'tv' : 'movie';
  return '${mediaType}_${item.id}';
}

Map<String, Object?> contentSnapshotFor(MovieItem item) {
  return _contentSnapshot(item);
}

Map<String, Object?> streamingActivityData({
  required String server,
  String? providerId,
  String? jellyfinItemId,
  int? seasonNumber,
  int? episodeNumber,
  String? episodeTitle,
  int? positionSeconds,
  int? durationSeconds,
  String? playbackMode,
  String? mediaSourceId,
}) {
  return {
    'lastAction': 'played',
    'selectedServer': server,
    if (positionSeconds != null && positionSeconds >= 0)
      'positionSeconds': positionSeconds,
    if (providerId?.trim().isNotEmpty == true) 'providerId': providerId!.trim(),
    if (jellyfinItemId?.trim().isNotEmpty == true)
      'jellyfinItemId': jellyfinItemId!.trim(),
    if (durationSeconds != null && durationSeconds > 0)
      'durationSeconds': durationSeconds,
    if (playbackMode?.trim().isNotEmpty == true)
      'playbackMode': playbackMode!.trim(),
    if (mediaSourceId?.trim().isNotEmpty == true)
      'mediaSourceId': mediaSourceId!.trim(),
    'seasonNumber': ?seasonNumber,
    'episodeNumber': ?episodeNumber,
    if (episodeTitle?.trim().isNotEmpty == true)
      'episodeTitle': episodeTitle!.trim(),
  };
}

Map<String, Object?> _contentSnapshot(MovieItem item) {
  return {
    'contentKey': contentKeyFor(item),
    'tmdbId': item.id,
    'mediaType': item.mediaType == MediaType.tv ? 'tv' : 'movie',
    'title': item.title,
    'year': item.year,
    'posterPath': item.posterPath,
    'backdropPath': item.backdropPath,
    if (item.imdbId?.trim().isNotEmpty == true) 'imdbId': item.imdbId!.trim(),
    if (item.originCountryCodes.isNotEmpty)
      'originCountryCodes': item.originCountryCodes,
    'posterUrl': item.posterUrl,
    'backdropUrl': item.backdropUrl,
    'voteAverage': item.voteAverage,
  };
}

DateTime? _timestampToDate(Object? value) {
  if (value is Timestamp) {
    return value.toDate();
  }
  return null;
}

List<String> _stringList(Object? value) {
  if (value is! Iterable) {
    return const [];
  }
  return value
      .map((entry) => entry?.toString().trim().toUpperCase() ?? '')
      .where((entry) => entry.isNotEmpty)
      .toList(growable: false);
}
