import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/app_theme.dart';
import '../../core/trailer/trailer_picker.dart';
import '../../widgets/state_views.dart';

class TrailerPlayerScreen extends StatefulWidget {
  const TrailerPlayerScreen({required this.trailer, super.key});

  final PlayableTrailer? trailer;

  @override
  State<TrailerPlayerScreen> createState() => _TrailerPlayerScreenState();
}

class _TrailerPlayerScreenState extends State<TrailerPlayerScreen> {
  WebViewController? _controller;
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    final trailer = widget.trailer;
    if (trailer == null || !trailer.isValid) {
      _errorMessage = 'Trailer route is missing a supported site or video key.';
      _loading = false;
      return;
    }

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _loading = false);
            }
          },
          onWebResourceError: (_) {
            if (mounted) {
              setState(() {
                _loading = false;
                _errorMessage = 'Unable to open trailer. Try again later.';
              });
            }
          },
          onNavigationRequest: (request) {
            final uri = Uri.tryParse(request.url);
            if (request.isMainFrame &&
                (uri == null ||
                    !uri.isScheme('https') ||
                    !_isAllowedHost(uri.host))) {
              setState(() {
                _loading = false;
                _errorMessage = 'Trailer navigation was blocked.';
              });
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    _controller = controller;
    unawaited(
      controller.loadRequest(trailer.embedUri).catchError((Object _) {
        if (mounted) {
          setState(() {
            _loading = false;
            _errorMessage = 'Unable to open trailer. Try again later.';
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final trailer = widget.trailer;
    if (trailer == null || !trailer.isValid) {
      return const InvalidRouteScreen(
        message: 'Trailer route is missing a supported site or video key.',
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: Text(trailer.title),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            if (_controller != null && _errorMessage == null)
              WebViewWidget(controller: _controller!),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null)
              AppErrorView(
                title: 'Trailer unavailable',
                message: _errorMessage!,
                onRetry: () {
                  setState(() {
                    _loading = true;
                    _errorMessage = null;
                  });
                  _initialize();
                },
                onBack: () => Navigator.maybePop(context),
              ),
          ],
        ),
      ),
    );
  }

  bool _isAllowedHost(String host) {
    final normalized = host.toLowerCase();
    return normalized == 'www.youtube.com' ||
        normalized == 'youtube.com' ||
        normalized == 'player.vimeo.com';
  }
}
