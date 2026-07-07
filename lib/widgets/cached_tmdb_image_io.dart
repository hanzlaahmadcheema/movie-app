import 'dart:io';

import 'package:flutter/material.dart';

import '../core/services/local_image_cache_service.dart';

class CachedTmdbImage extends StatelessWidget {
  const CachedTmdbImage({
    required this.url,
    this.imageType = LocalImageCacheService.imageTypeOther,
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

    final normalizedUrl = LocalImageCacheService.normalizeTmdbImageUrl(
      url,
      imageType,
    );
    if (!LocalImageCacheService.isCacheableTmdbUrl(normalizedUrl)) {
      return _networkImage(normalizedUrl, fallbackWidget);
    }

    return FutureBuilder<File?>(
      future: LocalImageCacheService.instance.cachedFileFor(
        remoteUrl: normalizedUrl,
        imageType: imageType,
      ),
      builder: (context, snapshot) {
        final file = snapshot.data;
        if (file != null) {
          return Image.file(
            file,
            fit: fit,
            width: width,
            height: height,
            filterQuality: filterQuality,
            errorBuilder: (context, error, stackTrace) =>
                _networkImage(normalizedUrl, fallbackWidget),
          );
        }

        if (snapshot.hasError) {
          return _networkImage(normalizedUrl, fallbackWidget);
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            fallbackWidget,
            const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ],
        );
      },
    );
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
