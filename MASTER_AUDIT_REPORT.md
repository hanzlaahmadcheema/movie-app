# Master Audit Report - Direct TMDB Migration

Updated on 2026-06-25.

## Migration Summary

The app was migrated from a proxy-based TMDB architecture to direct TMDB API
access. Flutter now calls `https://api.themoviedb.org/3` directly and authenticates
TMDB requests with `Authorization: Bearer <TMDB_READ_ACCESS_TOKEN>`.

## Files Changed

- `lib/core/config/app_config.dart`
- `lib/core/services/tmdb_api_client.dart`
- `lib/features/admin/admin_screens.dart`
- `.github/workflows/flutter-ci.yml`
- `.github/workflows/release-android.yml`
- `.env.example`
- `README.md`
- `FINAL_PUBLICATION_AUDIT.md`
- `test/tmdb_api_client_test.dart`

## Architecture Changes

- Removed `TMDB_PROXY_BASE_URL`.
- Removed proxy validation logic.
- Added `TMDB_READ_ACCESS_TOKEN` config.
- Added direct TMDB base URL: `https://api.themoviedb.org/3`.
- Added TMDB bearer Authorization header.
- Preserved existing repository method names and screen integrations.

## Security Implications

- Token is not hardcoded in source.
- Token is not present in `.env.example`.
- Token is passed locally with `--dart-define`.
- Token is passed in GitHub Actions from the `TMDB_READ_ACCESS_TOKEN` secret.
- Direct TMDB in a Flutter APK means the token can be extracted from distributed
  client binaries. This is the accepted tradeoff for the requested no-backend
  architecture.

## Validation Plan

Local checks run in this migration pass:

```bash
flutter analyze # passed
flutter test # passed, 100 tests
flutter build apk --debug --dart-define=TMDB_READ_ACCESS_TOKEN=test-token # passed
git diff --check # passed
```

`flutter build apk --release --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx` was
not run because local `android/key.properties` is absent. Release builds still
require `android/key.properties` and the matching keystore.

## Runtime Verification Matrix

Not yet manually verified in this migration pass:

- Email Login
- Google Login
- Phone Login
- Home screen loads
- Movies screen loads
- Series screen loads
- Search works
- Details pages load
- Recommendations load
- Trailers load
- VidSrc
- 2Embed
- Jellyfin Native
- Jellyfin Web
- Continue Watching for movies and episodes
- Admin dashboard, featured content, notices, providers, and requests

## Remaining Risks

- Direct-client token extraction risk remains.
- Forked PR workflows may not receive GitHub secrets.
- Runtime behavior depends on valid Firebase configuration and deployed rules.
- Streaming and Jellyfin provider behavior must be tested on Android hardware or
  an emulator before claiming production readiness.
