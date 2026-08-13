import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';

const _tmdbApiBaseUrl = 'https://api.themoviedb.org/3';

class TmdbApiException implements Exception {
  const TmdbApiException(this.message, [this.statusCode]);

  final String message;
  final int? statusCode;

  @override
  String toString() => 'TmdbApiException($statusCode): $message';
}

class TmdbApiClient {
  TmdbApiClient({required AppConfig config, http.Client? httpClient})
    : _config = config,
      _httpClient = httpClient ?? _sharedClient;

  static final http.Client _sharedClient = http.Client();

  final AppConfig _config;
  final http.Client _httpClient;

  Future<dynamic> get(
    String path, {
    Map<String, String?> query = const {},
  }) async {
    if (!_config.hasTmdbReadAccessToken) {
      throw const TmdbApiException('TMDB read access token is not configured');
    }

    final uri = Uri.parse('$_tmdbApiBaseUrl$path').replace(
      queryParameters: {
        for (final entry in query.entries)
          if (entry.value != null && entry.value!.trim().isNotEmpty)
            entry.key: entry.value!,
      },
    );

    final response = await _httpClient
        .get(
          uri,
          headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer ${_config.tmdbReadAccessToken}',
          },
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw TmdbApiException(response.body, response.statusCode);
    }

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic> || decoded is List<dynamic>) {
        return decoded;
      }
    } on FormatException {
      throw const TmdbApiException('Invalid TMDB response');
    }

    throw const TmdbApiException('Unexpected TMDB response shape');
  }
}
