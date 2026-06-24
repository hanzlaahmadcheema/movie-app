import 'dart:async';
import 'dart:io';

class NetworkStatusService {
  const NetworkStatusService();

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup(
        'example.com',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on Object {
      return false;
    }
  }
}
