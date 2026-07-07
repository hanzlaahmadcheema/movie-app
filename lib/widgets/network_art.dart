import 'package:flutter/material.dart';

import '../core/services/local_image_cache_service.dart';
import 'cached_tmdb_image.dart';

class NetworkArt extends StatelessWidget {
  const NetworkArt({
    required this.url,
    this.imageType,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    super.key,
  });

  final String url;
  final String? imageType;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      width: width,
      height: height,
      color: const Color(0xFF242426),
      alignment: Alignment.center,
      child: const Icon(Icons.movie_creation_outlined),
    );
    final effectiveImageType =
        imageType ?? LocalImageCacheService.imageTypeForUrl(url);
    final image = url.startsWith('http')
        ? CachedTmdbImage(
            url: url,
            imageType: effectiveImageType,
            fit: fit,
            width: width,
            height: height,
            fallback: fallback,
          )
        : Image.asset(
            url,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) => fallback,
          );

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}
