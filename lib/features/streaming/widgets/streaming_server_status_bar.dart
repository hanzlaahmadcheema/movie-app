import 'package:flutter/material.dart';

import '../../../core/streaming/streaming_embed_result.dart';

class StreamingServerStatusBar extends StatelessWidget {
  const StreamingServerStatusBar({
    required this.title,
    required this.candidates,
    required this.currentIndex,
    required this.onBack,
    required this.onServerSelected,
    super.key,
  });

  final String title;
  final List<StreamingEmbedResult> candidates;
  final int currentIndex;
  final VoidCallback onBack;
  final ValueChanged<int> onServerSelected;

  @override
  Widget build(BuildContext context) {
    final current = currentIndex >= 0 && currentIndex < candidates.length
        ? candidates[currentIndex]
        : null;
    return Material(
      color: const Color(0xFF101010),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Row(
          children: [
            IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    current == null
                        ? 'Stream unavailable'
                        : '${current.server.displayName} - Server ${currentIndex + 1}',
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (candidates.isNotEmpty)
              PopupMenuButton<int>(
                tooltip: 'Switch server',
                initialValue: currentIndex >= 0 ? currentIndex : null,
                onSelected: onServerSelected,
                itemBuilder: (context) => [
                  for (var index = 0; index < candidates.length; index++)
                    PopupMenuItem<int>(
                      value: index,
                      child: Text(
                        '${candidates[index].server.displayName} - Server ${index + 1}',
                      ),
                    ),
                ],
                icon: const Icon(Icons.dns_outlined),
              ),
          ],
        ),
      ),
    );
  }
}
