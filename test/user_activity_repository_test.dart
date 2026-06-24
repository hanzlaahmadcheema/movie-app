import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/models/movie_item.dart';
import 'package:movie_app/core/navigation/content_navigation.dart';
import 'package:movie_app/core/navigation/watch_page_request.dart';
import 'package:movie_app/core/services/user_activity_repository.dart';

void main() {
  test('contentKeyFor uses media type and TMDB id', () {
    const movie = MovieItem(
      id: 12,
      title: 'Movie',
      type: 'Movie',
      year: '2026',
      quality: 'HD',
      posterUrl: 'poster',
    );
    const series = MovieItem(
      id: 34,
      title: 'Series',
      type: 'Series',
      year: '2026',
      quality: 'HD',
      posterUrl: 'poster',
      mediaType: MediaType.tv,
    );

    expect(contentKeyFor(movie), 'movie_12');
    expect(contentKeyFor(series), 'tv_34');
  });

  test('UserContentRecord parses Firestore content snapshot', () {
    final startedAt = DateTime.utc(2026, 6, 13, 12);
    final record = UserContentRecord.fromJson({
      'contentKey': 'tv_34',
      'tmdbId': 34,
      'mediaType': 'tv',
      'title': 'Series',
      'year': '2026',
      'posterUrl': 'poster',
      'backdropUrl': 'backdrop',
      'voteAverage': 8.2,
      'reaction': 'like',
      'selectedServer': 'Server 2',
      'providerId': 'jellyfin_private',
      'jellyfinItemId': 'jf-1',
      'durationSeconds': 120,
      'playbackMode': 'native',
      'mediaSourceId': 'source-1',
      'seasonNumber': 1,
      'episodeNumber': 3,
      'episodeTitle': 'Pilot',
      'positionSeconds': 0,
      'lastAction': 'episodeSelected',
      'startedAt': Timestamp.fromDate(startedAt),
    });

    expect(record.contentKey, 'tv_34');
    expect(record.item.mediaType, MediaType.tv);
    expect(record.item.title, 'Series');
    expect(record.activity.reaction, UserReaction.like);
    expect(record.activity.selectedServer, 'Server 2');
    expect(record.activity.providerId, 'jellyfin_private');
    expect(record.activity.jellyfinItemId, 'jf-1');
    expect(record.activity.durationSeconds, 120);
    expect(record.activity.playbackMode, 'native');
    expect(record.activity.mediaSourceId, 'source-1');
    expect(record.activity.episodeNumber, 3);
    expect(
      record.startedAt?.millisecondsSinceEpoch,
      startedAt.millisecondsSinceEpoch,
    );
  });

  test('UserContentRecord parses watched timestamp', () {
    final watchedAt = DateTime.utc(2026, 6, 14, 18);
    final record = UserContentRecord.fromJson({
      'contentKey': 'movie_12',
      'tmdbId': 12,
      'mediaType': 'movie',
      'title': 'Movie',
      'year': '2026',
      'posterUrl': 'poster',
      'backdropUrl': 'backdrop',
      'voteAverage': 7.4,
      'watchedAt': Timestamp.fromDate(watchedAt),
    });

    expect(
      record.watchedAt?.millisecondsSinceEpoch,
      watchedAt.millisecondsSinceEpoch,
    );
  });

  test('Continue Watching movie record reopens movie stream', () {
    final record = UserContentRecord.fromJson({
      'contentKey': 'movie_12',
      'tmdbId': 12,
      'mediaType': 'movie',
      'title': 'Movie',
      'year': '2026',
      'posterUrl': 'poster',
      'backdropUrl': 'backdrop',
      'voteAverage': 7.0,
      'positionSeconds': 54,
      'durationSeconds': 120,
    });

    expect(
      continueWatchingDestinationForRecord(record),
      ContinueWatchingDestination.movieWatch,
    );
    final request = watchPageRequestForRecord(record);
    expect(request, isA<WatchPageRequest>());
    expect(request.autoPlay, isTrue);
    expect(request.seasonNumber, isNull);
    expect(request.resumePositionSeconds, 54);
    expect(request.resumeDurationSeconds, 120);
  });

  test('Continue Watching episode record reopens episode stream', () {
    final record = UserContentRecord.fromJson({
      'contentKey': 'tv_34',
      'tmdbId': 34,
      'mediaType': 'tv',
      'title': 'Series',
      'year': '2026',
      'posterUrl': 'poster',
      'backdropUrl': 'backdrop',
      'voteAverage': 8.0,
      'seasonNumber': 2,
      'episodeNumber': 5,
      'positionSeconds': 87,
    });

    expect(
      continueWatchingDestinationForRecord(record),
      ContinueWatchingDestination.episodeStream,
    );
    final request = watchPageRequestForRecord(record);
    expect(request.seasonNumber, 2);
    expect(request.episodeNumber, 5);
    expect(request.autoPlay, isTrue);
    expect(request.resumePositionSeconds, 87);
  });

  test('TV record without episode opens series selection safely', () {
    final record = UserContentRecord.fromJson({
      'contentKey': 'tv_34',
      'tmdbId': 34,
      'mediaType': 'tv',
      'title': 'Series',
      'year': '2026',
      'posterUrl': 'poster',
      'backdropUrl': 'backdrop',
      'voteAverage': 8.0,
      'seasonNumber': 2,
    });

    expect(
      continueWatchingDestinationForRecord(record),
      ContinueWatchingDestination.seriesSelection,
    );
    final request = watchPageRequestForRecord(record);
    expect(request.seasonNumber, 2);
    expect(request.episodeNumber, isNull);
    expect(request.autoPlay, isFalse);
  });

  test('streaming activity payload is honest and rules-compatible', () {
    final payload = streamingActivityData(
      server: 'VidSrc',
      seasonNumber: 1,
      episodeNumber: 3,
      episodeTitle: ' Pilot ',
    );

    expect(payload.containsKey('positionSeconds'), isFalse);
    expect(payload['selectedServer'], 'VidSrc');
    expect(payload['episodeTitle'], 'Pilot');
    expect(payload.containsKey('startedAt'), isFalse);
    expect(payload.containsKey('durationSeconds'), isFalse);
    expect(payload.containsKey('progressPercent'), isFalse);
  });

  test('native Jellyfin activity payload stores real progress fields', () {
    final payload = streamingActivityData(
      server: 'Jellyfin',
      providerId: 'jellyfin_private',
      jellyfinItemId: 'jf-1',
      positionSeconds: 31,
      durationSeconds: 99,
      playbackMode: 'native',
      mediaSourceId: 'source-1',
    );

    expect(payload['positionSeconds'], 31);
    expect(payload['durationSeconds'], 99);
    expect(payload['playbackMode'], 'native');
    expect(payload['mediaSourceId'], 'source-1');
    expect(payload.containsKey('progressPercent'), isFalse);
  });

  test('activity playback metadata fields are allowed by Firestore rules', () {
    final rules = File('firestore.rules').readAsStringSync();

    for (final field in const [
      'durationSeconds',
      'providerId',
      'jellyfinItemId',
      'playbackMode',
      'mediaSourceId',
    ]) {
      expect(rules, contains("'$field'"));
    }
    expect(rules, contains("data.playbackMode in ['native', 'web']"));
    expect(rules, contains('data.durationSeconds <= 86400'));
  });
}
