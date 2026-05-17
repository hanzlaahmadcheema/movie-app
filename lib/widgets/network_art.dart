import 'package:flutter/material.dart';

class NetworkArt extends StatelessWidget {
  const NetworkArt({
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    super.key,
  });

  final String url;
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
    final image = url.startsWith('http')
        ? Image.network(
            url,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (context, error, stackTrace) => fallback,
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
