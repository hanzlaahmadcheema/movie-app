import 'package:flutter/services.dart';

class PlatformShareService {
  const PlatformShareService();

  static const MethodChannel _channel = MethodChannel('movie_app/share');

  Future<bool> shareText(String text) async {
    try {
      final shared = await _channel.invokeMethod<bool>('shareText', {
        'text': text,
      });
      return shared == true;
    } on MissingPluginException {
      return false;
    } on PlatformException {
      return false;
    }
  }
}
