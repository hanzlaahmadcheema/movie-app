import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/jellyfin/jellyfin_config.dart';
import '../../../core/streaming/streaming_embed_request.dart';
import 'jellyfin_native_player_view.dart';

class JellyfinNativePlayerRequest {
  const JellyfinNativePlayerRequest({
    required this.itemId,
    required this.title,
    required this.sourceRequest,
    required this.mode,
  });

  final String itemId;
  final String title;
  final StreamingEmbedRequest sourceRequest;
  final JellyfinPlaybackMode mode;

  static JellyfinNativePlayerRequest? fromRouteArguments(Object? arguments) {
    if (arguments is JellyfinNativePlayerRequest) return arguments;
    if (arguments is! Map) return null;
    final itemId = arguments['itemId']?.toString().trim() ?? '';
    final sourceRequest = StreamingEmbedRequest.fromRouteArguments(
      arguments['sourceRequest'],
    );
    if (itemId.isEmpty || sourceRequest == null) return null;
    return JellyfinNativePlayerRequest(
      itemId: itemId,
      title: arguments['title']?.toString() ?? sourceRequest.title,
      sourceRequest: sourceRequest,
      mode: JellyfinPlaybackMode.fromName(
        arguments['playbackMode']?.toString(),
      ),
    );
  }

  Map<String, Object?> toRouteArguments() {
    return {
      'itemId': itemId,
      'title': title,
      'playbackMode': mode.name,
      'sourceRequest': sourceRequest.toRouteArguments(),
    };
  }
}

class JellyfinNativePlayerScreen extends StatefulWidget {
  const JellyfinNativePlayerScreen({required this.request, super.key});

  final JellyfinNativePlayerRequest? request;

  @override
  State<JellyfinNativePlayerScreen> createState() =>
      _JellyfinNativePlayerScreenState();
}

class _JellyfinNativePlayerScreenState
    extends State<JellyfinNativePlayerScreen> {

  @override
  void initState() {
    super.initState();
    unawaited(SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]));
  }

  @override
  void dispose() {
    unawaited(SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = widget.request;
    if (request == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Missing Jellyfin playback request.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: JellyfinNativePlayerView(
          itemId: request.itemId,
          request: request.sourceRequest,
          title: request.title,
          isFullscreen: true,
        ),
      ),
    );
  }
}
