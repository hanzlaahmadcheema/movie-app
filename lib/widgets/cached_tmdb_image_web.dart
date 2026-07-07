import 'package:flutter/material.dart';

const _imageTypePoster = 'poster';
const _imageTypeBackdrop = 'backdrop';
const _imageTypeProfile = 'profile';
const _imageTypeOther = 'other';
const _tmdbImageHost = 'image.tmdb.org';

class CachedTmdbImage extends StatelessWidget {
  const CachedTmdbImage({
    required this.url,
    this.imageType = _imageTypeOther,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.filterQuality = FilterQuality.medium,
    this.fallback,
    super.key,
  });

  final String url;
  final String imageType;
  final BoxFit fit;
  final double? width;
  final double? height;
  final FilterQuality filterQuality;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    final fallbackWidget =
        fallback ?? _ImageFallback(width: width, height: height);
    if (!url.startsWith('http')) {
      return Image.asset(
        url,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => fallbackWidget,
      );
    }

    final normalizedUrl = _normalizeTmdbImageUrl(url, imageType);
    return _networkImage(normalizedUrl, fallbackWidget);
  }

  Widget _networkImage(String imageUrl, Widget fallbackWidget) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      filterQuality: filterQuality,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        final expected = progress.expectedTotalBytes;
        final value = expected == null
            ? null
            : progress.cumulativeBytesLoaded / expected;
        return Stack(
          fit: StackFit.expand,
          children: [
            fallbackWidget,
            Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(value: value, strokeWidth: 2),
              ),
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) => fallbackWidget,
    );
  }

  static String _normalizeTmdbImageUrl(String remoteUrl, String imageType) {
    final uri = Uri.tryParse(remoteUrl);
    if (uri == null || uri.host != _tmdbImageHost) {
      return remoteUrl;
    }
    final segments = uri.pathSegments;
    if (segments.length < 3 || segments[0] != 't' || segments[1] != 'p') {
      return remoteUrl;
    }

    final normalizedSegments = [...segments];
    normalizedSegments[2] = switch (imageType) {
      _imageTypeBackdrop => 'w1280',
      _imageTypeProfile => 'w342',
      _imageTypePoster => 'w500',
      _ => 'w500',
    };
    return uri.replace(pathSegments: normalizedSegments).toString();
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFF242426),
      alignment: Alignment.center,
      child: const Icon(Icons.movie_creation_outlined),
    );
  }
}
