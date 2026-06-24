# Final Publication Audit - Remediation Update

Updated on 2026-06-24 after blocker remediation.

## Current Verdict

Ready after minor fixes.

The critical code and security blockers from the original audit are fixed:

- The app compiles.
- `flutter analyze` passes.
- `flutter test` passes.
- Debug APK build passes.
- `.env` is no longer bundled as a Flutter asset.
- The Flutter client no longer sends a TMDB bearer token.
- Firestore activity payload fields now match the local rules schema.
- The admin security screen no longer displays fake all-green security claims.
- Release builds no longer fall back to debug signing.
- The Android manifest no longer enables global cleartext traffic.
- The hardcoded private Jellyfin server URL was removed.

The app is not yet proven production-ready because runtime/device flows, live
Firestore deployed rules, a real TMDB backend/proxy, and signed release output
were not verified in this remediation pass.

## Commands Run

| Command | Result |
| --- | --- |
| `flutter clean` | Passed |
| `flutter pub get` | Passed; dependency update notices remain |
| `flutter analyze` | Passed, no issues found |
| `flutter test` | Passed, 97 tests |
| `flutter build apk --debug` | Passed, built `build/app/outputs/flutter-apk/app-debug.apk` |
| `flutter build apk --release` | Skipped because `android/key.properties` is absent, so local release signing is not configured |

Notes:

- Flutter/Gradle commands required elevated filesystem access because the SDK and caches live outside the workspace.
- Gradle emitted dependency/compiler warnings about obsolete Java source/target and deprecated/unchecked dependency APIs, but the debug build succeeded.
- No live Firestore REST inspection was performed in this remediation pass.
- No runtime UI/device/WebView/Jellyfin playback testing was performed.

## What Was Fixed

| Area | Files | Fix |
| --- | --- | --- |
| Compile blocker | `lib/widgets/network_art.dart` | Removed malformed unused `animation` class that broke Dart parsing |
| Secret exposure | `pubspec.yaml` | Removed `.env` from Flutter assets |
| TMDB security | `lib/core/config/app_config.dart`, `lib/core/services/tmdb_api_client.dart`, `.env.example`, `README.md` | Replaced client bearer-token path with `TMDB_PROXY_BASE_URL`; TMDB token is documented as server-only |
| Firestore rules mismatch | `firestore.rules`, `test/user_activity_repository_test.dart` | Allowed only the actual validated activity metadata fields: `durationSeconds`, `providerId`, `jellyfinItemId`, `playbackMode`, `mediaSourceId` |
| Admin security UI | `lib/features/admin/admin_screens.dart` | Replaced hardcoded all-green checks with `Verified`, `Warning`, `Not configured`, and `Unable to verify` states |
| Auth placeholder actions | `lib/widgets/auth_widgets.dart` | Disabled social buttons when callbacks are unavailable instead of showing fake snackbars |
| Demo route | `lib/app/app_routes.dart`, `lib/features/auth/auth_screens.dart` | Removed hidden `/snackbars` demo route and screen |
| Android signing | `android/app/build.gradle.kts`, `.gitignore`, `README.md` | Added release keystore pattern through ignored `android/key.properties`; removed debug signing fallback |
| Android network security | `android/app/src/main/AndroidManifest.xml`, `README.md` | Removed global `usesCleartextTraffic`; documented HTTPS/private-build boundary for Jellyfin |
| Jellyfin privacy | `lib/core/jellyfin/jellyfin_config.dart`, settings screens, Jellyfin tests | Removed hardcoded private default server URL and replaced it with a blank default plus generic hint |
| GitHub docs | `README.md`, `LICENSE`, `web/index.html`, `web/manifest.json` | Added publication README, MIT license, and non-default web metadata |
| Scratch/stale artifacts | `final-audit-gap-analysis.md`, `MASTER_AUDIT_REPORT.md` | Removed stale generated audit artifacts that should not be published |

## Remaining Gaps

| Area | Current Status | Gap / Issue | Severity | Recommended Fix | Effort | Must Fix Before GitHub? |
| --- | --- | --- | --- | --- | --- | --- |
| TMDB backend | Client supports a proxy URL | No backend/proxy implementation exists in this repo | High | Add a small backend/proxy or document the exact external service used | Medium | Yes, unless publishing as client-only template |
| Runtime verification | Not performed | Android UI, auth, WebView provider playback, Jellyfin playback, and responsive behavior were not manually tested | High | Run the manual Android test matrix on a real device/emulator | Medium | Yes before calling final complete |
| Firestore deployment | Static rules updated | Deployed Firestore rules were not verified live | High | Use read-only Firebase CLI authenticated REST inspection and deploy/verify rules separately | Medium | Yes before production use |
| Android release | Debug build passes | `android/key.properties` is absent; release APK was not built or signed | High | Create local release keystore config and run `flutter build apk --release` | Small | Yes before app distribution |
| Git state | Still dirty with many modified/untracked files | Publication requires an intentional staging/commit review | High | Review `git status`, stage intended source/config/docs/tests only, exclude private/local files | Medium | Yes |
| Firebase App Check | Not configured | Firebase client config is public, so rules and App Check remain important | Medium | Configure App Check for Android and enforce it on Firebase services | Medium | No for source publication, yes for production |
| Legal content | Present but not legally reviewed | Terms/privacy/support text may still need final legal wording | Medium | Finalize legal copy and support contact ownership | Medium | No for portfolio source, yes for production |
| Dependencies | Build passes | Several packages have newer versions outside current constraints | Medium | Upgrade in a separate dependency pass and rerun regression tests | Medium | No |
| Device accessibility | Not verified | Screen reader, focus order, text scaling, contrast, and keyboard behavior were not tested | Medium | Run accessibility pass after runtime smoke testing | Medium | No |
| Screenshots/demo | Not included | README has a placeholder, not actual screenshots | Low | Add current Android screenshots or demo GIF | Small | No |

## Updated Release Checklist

### Must Fix Before Publishing As Final Complete

- Provide or implement the TMDB backend/proxy used by `TMDB_PROXY_BASE_URL`.
- Run a real Android device/emulator smoke test for auth, catalog, search, details, watchlist, watched, continue watching, provider WebView, Jellyfin settings, and logout.
- Verify deployed Firestore rules with the approved read-only Firebase CLI REST approach.
- Configure `android/key.properties` locally and run a signed release build before distributing APKs.
- Review and intentionally stage/commit the currently dirty working tree.

### Should Fix Soon

- Add Firebase App Check.
- Add Firestore emulator rules tests for user/admin allowed and denied writes.
- Add CI for `flutter analyze`, `flutter test`, and Android debug build.
- Upgrade dependencies in a controlled pass.
- Add screenshots/demo media to README.
- Finalize legal/support text.

### Already Good / Ready

- Static analysis passes.
- Automated tests pass.
- Debug APK builds from a clean state.
- `.env` is ignored and not bundled.
- TMDB bearer token is no longer read or sent by the Flutter client.
- Admin security UI is no longer misleading.
- Firestore activity schema is tighter and covered by a guard test.
- Android release no longer uses debug signing.
- Global cleartext traffic is removed.
- Private Jellyfin URL is removed from app defaults.
- README, `.env.example`, `.gitignore`, and `LICENSE` are publication-ready at source level.

## Final Notes

This remediation pass fixed the critical and high code/security blockers without
weakening security rules or hiding failures. The remaining work is mostly
release operation and runtime verification: configure the real TMDB proxy,
verify Firebase deployment state, create a signed release build, and test the
actual Android flows before declaring the app fully complete.
