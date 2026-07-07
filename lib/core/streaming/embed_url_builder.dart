import 'streaming_content_type.dart';
import 'streaming_embed_request.dart';
import 'streaming_server.dart';

class EmbedUrlBuilder {
  const EmbedUrlBuilder();

  Uri? build(StreamingServer server, StreamingEmbedRequest request) {
    if (!server.enabled || !server.supports(request.contentType)) {
      return null;
    }
    if (request.validate() != null) {
      return null;
    }

    return buildEndpoint(
      server,
      StreamingEndpoint(
        endpointId: server.id,
        url: server.baseUri,
        priority: server.priority,
        enabled: server.enabled,
      ),
      request,
    );
  }

  Uri? buildEndpoint(
    StreamingServer server,
    StreamingEndpoint endpoint,
    StreamingEmbedRequest request,
  ) {
    if (!endpoint.enabled ||
        !server.enabled ||
        !server.supports(request.contentType)) {
      return null;
    }
    if (request.validate() != null) {
      return null;
    }

    return switch (server.urlBuilderStrategy) {
      StreamingUrlBuilderStrategy.vidSrc => _buildVidSrc(endpoint.url, request),
      StreamingUrlBuilderStrategy.template => _buildTemplate(
        server,
        endpoint.url,
        request,
      ),
      StreamingUrlBuilderStrategy.indStream => _buildIndStream(request),
      StreamingUrlBuilderStrategy.jellyfinWeb => null,
    };
  }

  Uri _buildVidSrc(Uri baseUri, StreamingEmbedRequest request) {
    final identifier = request.tmdbId != null
        ? MapEntry('tmdb', request.tmdbId.toString())
        : MapEntry('imdb', request.normalizedImdbId!);
    final path = request.contentType == StreamingContentType.movie
        ? '/embed/movie'
        : '/embed/tv';
    final query = <String, String>{
      identifier.key: identifier.value,
      if (request.contentType == StreamingContentType.episode) ...{
        'season': request.seasonNumber.toString(),
        'episode': request.episodeNumber.toString(),
      },
      'autoplay': '1',
      if (request.contentType == StreamingContentType.episode) 'autonext': '1',
    };

    return baseUri.resolve(path).replace(queryParameters: query);
  }

  Uri? _buildTemplate(
    StreamingServer server,
    Uri baseUri,
    StreamingEmbedRequest request,
  ) {
    final template = request.contentType == StreamingContentType.movie
        ? server.movieTemplate
        : server.episodeTemplate;
    if (template == null || template.trim().isEmpty) {
      return null;
    }

    final domain = baseUri.toString().replaceFirst(RegExp(r'/$'), '');
    var value = template
        .replaceAll('{domain}', domain)
        .replaceAll('{id}', request.preferredId!)
        .replaceAll('{tmdbId}', request.tmdbId?.toString() ?? '')
        .replaceAll('{imdbId}', request.normalizedImdbId ?? '')
        .replaceAll('{season}', request.seasonNumber?.toString() ?? '')
        .replaceAll('{episode}', request.episodeNumber?.toString() ?? '');
    if (!value.startsWith('http://') && !value.startsWith('https://')) {
      value = '$domain/${value.replaceFirst(RegExp(r'^/'), '')}';
    }

    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return null;
    }
    return uri;
  }

  Uri? _buildIndStream(StreamingEmbedRequest request) {
    final sourceId = request.normalizedImdbId;
    if (sourceId == null || sourceId.trim().isEmpty) {
      return null;
    }
    final escapedSourceId = _escapeJavaScriptString(sourceId.trim());
    const scriptUrl = 'https://allmovieland.link/player.js?v=401';
    final html =
        '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hindi Player</title>
  <style>
    html, body, #player-container, #IndStreamPlayer {
      width: 100%;
      height: 100%;
      margin: 0;
      padding: 0;
      overflow: hidden;
      background: #000;
    }
    iframe {
      width: 100%;
      height: 100%;
      border: 0;
      background: #000;
    }
  </style>
</head>
<body>
  <div id="player-container">
    <div id="IndStreamPlayer"></div>
  </div>
  <script>
    const IndStreamPlayerConfigs = {
      width: '100%',
      height: '100%',
      id: 'IndStreamPlayer',
      src: '$escapedSourceId',
      tr: false
    };
  </script>
  <script src="$scriptUrl"></script>
</body>
</html>
''';

    return Uri.dataFromString(html, mimeType: 'text/html');
  }

  String _escapeJavaScriptString(String value) {
    return value
        .replaceAll(r'\', r'\\')
        .replaceAll("'", r"\'")
        .replaceAll('\n', r'\n')
        .replaceAll('\r', r'\r');
  }
}
