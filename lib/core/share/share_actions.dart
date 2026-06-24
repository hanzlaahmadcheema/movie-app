import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/movie_item.dart';
import 'platform_share_service.dart';
import 'share_text_builder.dart';

Future<void> shareMovieItem(BuildContext context, MovieItem item) async {
  final text = ShareTextBuilder.forItem(item);
  final usedPlatformShare = await const PlatformShareService().shareText(text);
  if (usedPlatformShare) {
    return;
  }

  await Clipboard.setData(ClipboardData(text: text));
  if (!context.mounted) return;
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Copied share text')));
}
