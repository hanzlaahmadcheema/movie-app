# MovieApp Flutter

MovieApp is an Android-focused Flutter app for discovering movies and TV series.
It uses Firebase for authentication and user data, TMDB for catalog metadata,
and optional Jellyfin settings for private playback.

The project is intended for source publication and APK distribution through
GitHub Releases. It is not configured for Play Store publishing.

## Features

- Email/password, Google, and phone authentication with Firebase Auth.
- TMDB-powered home, catalog, search, filters, detail, cast, trailer, season,
  episode, recommendation, and similar-content flows.
- Watchlist, watched status, reactions, and continue-watching state.
- Public streaming provider handoff through controlled WebView navigation.
- Optional Jellyfin native/web playback settings with local secure-token storage.
- Admin screens for app config, providers, featured content, banners, notices,
  users, requests, and playback issue logs.
- Local recent-search persistence with sqflite.

## Tech Stack

- Flutter / Dart
- Firebase Auth, Cloud Firestore, Firebase Core
- TMDB API
- WebView Flutter
- sqflite
- flutter_secure_storage
- shared_preferences

## Android Support

Android is the primary supported platform. Other Flutter platform folders may be
present, but Firebase configuration and runtime behavior should be verified on
Android before publishing a release.

## Required Configuration

The app calls TMDB directly and reads the TMDB v4 read access token from a
dart-define:

```bash
flutter run --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

Do not hardcode the token in source code, commit it to Git, log it, display it
in the UI, or store it in Firestore. Direct TMDB access means the token is
included in distributed APK builds and should be treated as extractable from the
client.

`.env` is ignored and is not bundled as a Flutter asset. Prefer dart-defines for
local runs and GitHub Actions secrets for CI/release builds.

## Firebase Setup

1. Create or select a Firebase project.
2. Enable the Firebase Auth providers you want to support:
   - Email/Password
   - Google
   - Phone
3. Add an Android app in Firebase with this package name:

```text
com.hanzlaahmad.movie_app
```

4. Download the Android Firebase config and place it at:

```text
android/app/google-services.json
```

5. Review `firestore.rules`, then deploy rules with your Firebase project ID:

```bash
firebase deploy --only firestore:rules --project YOUR_FIREBASE_PROJECT_ID
```

6. For Google Sign-In on release APKs, add the release keystore SHA-1 and
   SHA-256 fingerprints in Firebase project settings, then download the updated
   `google-services.json`.

Get release keystore fingerprints with:

```bash
keytool -list -v -keystore release-keystore.jks
```

For Firestore debugging, use read-only Firebase CLI authenticated REST
inspection. Do not print tokens or commit auth helper scripts.

## Install And Run Locally

```bash
flutter pub get
flutter run --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

Run on a specific device:

```bash
flutter devices
flutter run -d DEVICE_ID --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

## Verification

```bash
flutter analyze
flutter test
flutter build apk --debug --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

For release builds, configure Android signing first:

```bash
flutter build apk --release --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

## Android Release Signing

Release builds must not use debug signing. Create `android/key.properties`
locally when preparing a signed release:

```properties
storePassword=your-store-password
keyPassword=your-key-password
keyAlias=your-key-alias
storeFile=/absolute/path/to/release-keystore.jks
```

Ignored signing files:

- `android/key.properties`
- `*.jks`
- `*.keystore`

Never commit keystores or signing passwords. Back up the release keystore safely;
future APK updates must use the same signing key.

## GitHub Actions Configuration

Repository secrets:

- `TMDB_READ_ACCESS_TOKEN`
- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

Generate a release keystore:

```bash
keytool -genkey -v \
  -keystore release-keystore.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias movieapp
```

Create the base64 value for GitHub Actions.

Linux:

```bash
base64 -w 0 release-keystore.jks
```

macOS:

```bash
base64 -i release-keystore.jks
```

Add the output as the `ANDROID_KEYSTORE_BASE64` secret.

## GitHub Releases

Normal commits and pull requests run CI only. Public APKs are published only
when a maintainer pushes a version tag such as `v0.1.0`.

Release process:

1. Verify the working tree and local checks.

   ```bash
   git status
   flutter clean
   flutter pub get
   flutter analyze
   flutter test
   flutter build apk --debug --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
   ```

2. Update `pubspec.yaml`.

   ```yaml
   version: 0.1.0+1
   ```

3. Commit and push the version bump.

   ```bash
   git add pubspec.yaml
   git commit -m "Release v0.1.0"
   git push origin main
   ```

4. Create and push the version tag.

   ```bash
   git tag -a v0.1.0 -m "Movie App v0.1.0"
   git push origin v0.1.0
   ```

GitHub Actions will build the signed release APK, generate a SHA256 checksum,
and publish both files to GitHub Releases.

## Troubleshooting

If catalog screens show no movie data, confirm the APK was built with a valid
`TMDB_READ_ACCESS_TOKEN`.

If Google Sign-In works in debug but fails in the downloaded release APK, add
the release keystore SHA-1 and SHA-256 fingerprints to Firebase and refresh
`android/app/google-services.json`.

If the release workflow fails with a keystore alias error, make sure
`ANDROID_KEY_ALIAS` exactly matches the alias inside the uploaded keystore:

```bash
keytool -list -v -keystore release-keystore.jks
```

## Security Notes

- Do not commit `.env`, real tokens, keystores, `android/key.properties`, APKs,
  or generated build output.
- Firebase client config is not a server secret, but Firestore rules and App
  Check still matter for production security.
- Direct TMDB access exposes the TMDB token to distributed clients. Use a backend
  proxy instead if token confidentiality is required.
- Verify Firebase rules, auth providers, TMDB data loading, streaming providers,
  Jellyfin flows, and continue-watching behavior on a real Android device before
  calling a release production-ready.

## License

This project is licensed under the MIT License. See `LICENSE`.
