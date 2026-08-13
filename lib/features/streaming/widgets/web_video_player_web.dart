// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

class WebVideoPlayer extends StatefulWidget {
  const WebVideoPlayer({required this.url, super.key});

  final Uri url;

  @override
  State<WebVideoPlayer> createState() => _WebVideoPlayerState();
}

class _WebVideoPlayerState extends State<WebVideoPlayer> {
  late String _viewType;

  @override
  void initState() {
    super.initState();
    _registerView();
  }

  @override
  void didUpdateWidget(covariant WebVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _registerView();
    }
  }

  void _registerView() {
    _viewType =
        'movie-app-player-${identityHashCode(this)}-${widget.url.hashCode}';
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (_) {
      final iframe = html.IFrameElement()
        ..src = widget.url.toString()
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'autoplay; fullscreen; picture-in-picture; encrypted-media; gyroscope; accelerometer'
        ..allowFullscreen = true
        ..referrerPolicy = 'strict-origin-when-cross-origin';
      iframe.setAttribute('allow', 'autoplay; fullscreen; picture-in-picture; encrypted-media; gyroscope; accelerometer');
      iframe.setAttribute('allowfullscreen', 'true');
      iframe.setAttribute('webkitallowfullscreen', 'true');
      iframe.setAttribute('mozallowfullscreen', 'true');
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(key: ValueKey(_viewType), viewType: _viewType);
  }
}
