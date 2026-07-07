import 'package:flutter/material.dart';

class WebVideoPlayer extends StatelessWidget {
  const WebVideoPlayer({required this.url, super.key});

  final Uri url;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Browser playback is unavailable on this platform.'),
    );
  }
}
