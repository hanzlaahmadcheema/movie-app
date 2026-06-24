import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/services/tmdb_api_client.dart';
import 'package:movie_app/widgets/state_views.dart';

void main() {
  test('TMDB timeout and offline errors map to user messages', () {
    expect(
      userMessageForError(TimeoutException('slow')),
      contains('timed out'),
    );
    expect(
      userMessageForError(const SocketException('offline')),
      contains('No internet'),
    );
  });

  test('TMDB status codes map to actionable messages', () {
    expect(
      userMessageForError(const TmdbApiException('unauthorized', 401)),
      contains('configured'),
    );
    expect(
      userMessageForError(const TmdbApiException('missing', 404)),
      contains('not found'),
    );
    expect(
      userMessageForError(const TmdbApiException('rate', 429)),
      contains('Too many'),
    );
  });

  test('Firestore permission denied maps correctly', () {
    expect(
      userMessageForError(
        FirebaseException(plugin: 'cloud_firestore', code: 'permission-denied'),
      ),
      contains('permission'),
    );
  });
}
