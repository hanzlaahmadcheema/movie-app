# Final Publication Audit - Direct TMDB Migration

Updated on 2026-06-25 after removing the TMDB proxy architecture.

## Current Verdict

Ready for source publication after CI secrets are configured. Runtime completion
still depends on Android device verification and valid Firebase/TMDB credentials.

## Architecture Changes

- Removed `TMDB_PROXY_BASE_URL` from Flutter configuration, CI, and docs.
- Added direct TMDB API calls to `https://api.themoviedb.org/3`.
- Added `Authorization: Bearer <TMDB_READ_ACCESS_TOKEN>` to TMDB requests.
- Kept `TMDB_IMAGE_BASE_URL` support for image URL generation.
- Kept `TmdbRepository` public methods unchanged so Home, Search, Catalog,
  Details, trailers, seasons, recommendations, and similar-content callers do
  not need route/UI changes.

## Files Changed

| File | Purpose |
| --- | --- |
| `lib/core/config/app_config.dart` | Reads `TMDB_READ_ACCESS_TOKEN` from dart-define or local `.env`; removes proxy config |
| `lib/core/services/tmdb_api_client.dart` | Calls direct TMDB API with bearer auth and existing response validation |
| `lib/features/admin/admin_screens.dart` | Updates security copy for direct-client token handling |
| `.github/workflows/flutter-ci.yml` | Injects `TMDB_READ_ACCESS_TOKEN` secret into debug APK builds |
| `.github/workflows/release-android.yml` | Validates and injects `TMDB_READ_ACCESS_TOKEN` for signed release builds |
| `.env.example` | Removes proxy setting and keeps token as commented local placeholder only |
| `README.md` | Documents direct TMDB setup, GitHub secret requirements, and build commands |
| `test/tmdb_api_client_test.dart` | Verifies direct TMDB URL, bearer header, and missing-token failure |

## Removed Proxy Components

- Removed `TMDB_PROXY_BASE_URL` dependency.
- Removed proxy-not-configured failure path.
- Removed proxy setup instructions from README and `.env.example`.
- Removed GitHub Actions repository variable requirement for TMDB proxy URL.

## Security Implications

- No TMDB token is hardcoded in source.
- No real TMDB token is committed in `.env.example`.
- GitHub Actions expects `TMDB_READ_ACCESS_TOKEN` as a repository secret.
- Local development should pass the token with:

```bash
flutter run --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

- Direct TMDB access means release APKs contain the dart-defined token and the
  token should be considered extractable from distributed clients.
- Do not log, display, store in Firestore, or commit the TMDB token.

## Validation Status

| Check | Status |
| --- | --- |
| `flutter analyze` | Passed |
| `flutter test` | Passed, 100 tests |
| `flutter build apk --debug --dart-define=TMDB_READ_ACCESS_TOKEN=...` | Passed |
| `git diff --check` | Passed |
| `flutter build apk --release --dart-define=TMDB_READ_ACCESS_TOKEN=...` | Not run; local `android/key.properties` is absent |
| Android runtime auth/catalog/streaming/admin smoke test | Not performed in this pass |

## Remaining Risks

- Direct-client TMDB token exposure is inherent to this architecture.
- GitHub pull requests from forks may not receive repository secrets, so CI debug
  builds may need a maintainer-controlled branch or adjusted policy for forks.
- Android release builds still require a valid keystore and matching alias.
- Firebase Auth, Firestore rules, App Check, Jellyfin, streaming providers, and
  continue-watching behavior still need real Android runtime verification.
