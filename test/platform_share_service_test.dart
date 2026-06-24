import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/share/platform_share_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('movie_app/share');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('returns true when platform share succeeds', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          expect(call.method, 'shareText');
          expect(call.arguments, containsPair('text', 'hello'));
          return true;
        });

    expect(await const PlatformShareService().shareText('hello'), isTrue);
  });

  test('returns false when platform share is unavailable', () async {
    expect(await const PlatformShareService().shareText('hello'), isFalse);
  });
}
