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

    return switch (server.urlBuilderStrategy) {
      StreamingUrlBuilderStrategy.vidSrc => _buildVidSrc(server, request),
      StreamingUrlBuilderStrategy.template => _buildTemplate(server, request),
      StreamingUrlBuilderStrategy.jellyfinWeb => null,
    };
  }

  Uri _buildVidSrc(StreamingServer server, StreamingEmbedRequest request) {
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

    return server.baseUri.resolve(path).replace(queryParameters: query);
  }

  Uri? _buildTemplate(StreamingServer server, StreamingEmbedRequest request) {
    final template = request.contentType == StreamingContentType.movie
        ? server.movieTemplate
        : server.episodeTemplate;
    if (template == null || template.trim().isEmpty) {
      return null;
    }

    final domain = server.baseUri.toString().replaceFirst(RegExp(r'/$'), '');
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
}
