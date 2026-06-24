import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:movie_app/core/jellyfin/jellyfin_client.dart';
import 'package:movie_app/core/jellyfin/jellyfin_config.dart';
import 'package:movie_app/core/jellyfin/jellyfin_repository.dart';
import 'package:movie_app/features/settings/jellyfin_settings_screen.dart';

void main() {
  testWidgets('settings prefill default server URL and not logged in status', (
    tester,
  ) async {
    final repository = JellyfinRepository(
      configStore: MemoryJellyfinConfigStore(),
    );

    await tester.pumpWidget(
      MaterialApp(home: JellyfinSettingsScreen(repository: repository)),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login status: Not logged in'), findsOneWidget);
    expect(find.text(kJellyfinServerUrlHint), findsWidgets);
  });

  testWidgets('settings show logged in username', (tester) async {
    final repository = JellyfinRepository(
      configStore: MemoryJellyfinConfigStore(
        const JellyfinConfig(
          enabled: true,
          serverUrl: 'https://jellyfin.example.test',
          accessToken: 'token-123',
          userId: 'user-1',
          userName: 'hanzla',
        ),
      ),
      clientFactory: (config) => JellyfinClient(
        config: config,
        httpClient: MockClient(
          (request) async =>
              http.Response('{"Id":"user-1","Name":"hanzla"}', 200),
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(home: JellyfinSettingsScreen(repository: repository)),
    );

    await tester.pumpAndSettle();

    expect(find.text('Login status: Logged in as hanzla'), findsOneWidget);
  });
}
