# MovieApp Flutter

MovieApp is an Android-first Flutter movie and series discovery app. It uses
Firebase for accounts and user state, direct TMDB API access for catalog data,
and optional Jellyfin settings for private playback.

## Features

- Email/password, Google, and phone authentication through Firebase Auth.
- TMDB-backed home, catalog, search, filters, detail, cast, and trailer flows.
- User watchlist, watched list, reactions, episode selection, and continue watching.
- Public streaming provider handoff through controlled WebView navigation.
- Optional Jellyfin setup with local secure-token storage.
- Admin screens for app config, providers, featured content, banners, notices,
  users, requests, and playback issue logs.
- Route validation, not-found screens, empty/loading/error states, and local
  recent-search persistence.

## Tech Stack

- Flutter 3 / Dart
- Firebase Auth, Cloud Firestore, Firebase Core
- Android native platform channel for sharing
- WebView Flutter for provider/trailer pages
- sqflite for local recent searches
- flutter_secure_storage and shared_preferences for local Jellyfin settings

## Supported Platform

The current release target is Android. Other Flutter platform folders may exist
in the repository, but Firebase options and runtime behavior are only prepared
for Android.

## Required Configuration

Do not bundle `.env` into Flutter assets. The app calls TMDB directly and reads
the TMDB v4 read access token from a dart-define:

```sh
flutter run --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

The token must not be hardcoded, committed, logged, displayed in UI, or stored in
Firestore. Because this app is distributed as an APK and uses direct TMDB access,
the dart-defined token is still present in the built client and should be treated
as extractable from distributed APKs.

`.env.example` documents safe placeholder values only. A local `.env` file may
exist for notes or backend setup, but it is gitignored and is not bundled by
`pubspec.yaml`.

## Firebase Setup

1. Create or select a Firebase project.
2. Enable Firebase Auth providers needed by the app:
   - Email/Password
   - Google
   - Phone
3. Add the Android app package:

```text
com.hanzlaahmad.movie_app
```

4. Place the Android Firebase config at:

```text
android/app/google-services.json
```

5. Review `firestore.rules`, then deploy rules from an authenticated Firebase CLI:

```sh
firebase deploy --only firestore:rules --project movie-app-cc2c1
```

For debugging Firestore data, use read-only Firebase CLI authenticated REST
inspection. Do not print tokens or commit auth helper scripts.

## Android Release Signing

Release builds must not use debug signing. Create `android/key.properties`
locally when preparing a signed release:

```properties
storePassword=your-store-password
keyPassword=your-key-password
keyAlias=your-key-alias
storeFile=/absolute/path/to/upload-keystore.jks
```

`android/key.properties`, `*.jks`, and `*.keystore` are ignored by Git.

## GitHub Releases

This app is distributed through GitHub Releases as an Android APK. Normal
commits and pull requests run CI only. Public downloadable APKs are published
only when maintainers push version tags such as `v0.1.0` or `v1.0.0`.

Users can download APK files from the repository's Releases page. Android may
warn before installing APKs from outside the Play Store.

The app requires a configured `TMDB_READ_ACCESS_TOKEN` secret for catalog data.
Normal commits run CI only; version tags create public APK releases.

## Required GitHub Actions configuration

Repository secrets:

- `TMDB_READ_ACCESS_TOKEN`
- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

Generate a release keystore locally:

```bash
keytool -genkey -v \
  -keystore release-keystore.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias movieapp
```

Create the base64 value:

```bash
base64 -w 0 release-keystore.jks
```

On macOS:

```bash
base64 -i release-keystore.jks
```

Add the output as the `ANDROID_KEYSTORE_BASE64` GitHub Actions secret.
Never commit the keystore file.

## Maintainer release process

1. Make sure the working tree is clean.

   ```bash
   git status
   ```

2. Run local verification.

   ```bash
   flutter clean
   flutter pub get
   flutter analyze
   flutter test
   flutter build apk --debug
   ```

3. Update `pubspec.yaml`.

   ```yaml
   version: 0.1.0+1
   ```

4. Commit the version bump.

   ```bash
   git add pubspec.yaml
   git commit -m "Release v0.1.0"
   git push origin main
   ```

5. Create and push the version tag.

   ```bash
   git tag -a v0.1.0 -m "Movie App v0.1.0"
   git push origin v0.1.0
   ```

6. GitHub Actions will build the signed release APK and publish it to GitHub
   Releases.

## Network Security

The production Android manifest does not enable global cleartext traffic.
Prefer HTTPS for Jellyfin. If you need private HTTP Jellyfin access for a local
or Tailscale-only setup, treat that as a private build/network-security decision
and do not enable broad cleartext traffic for public releases.

## Install And Run

```sh
flutter pub get
flutter run --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

## Verification Commands

```sh
flutter analyze
flutter test
flutter build apk --debug --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

For release builds, configure Android release signing first:

```sh
flutter build apk --release --dart-define=TMDB_READ_ACCESS_TOKEN=xxxxx
```

## Screenshots / Demo

Screenshots and a demo link are not included yet. Add current Android screenshots
before using the repository as a polished public portfolio project.

## Repository Notes

- `.env` is ignored and must not be published.
- `android/app/google-services.json` is intentionally allowed because Firebase
  client config is required by the Android app. Firestore rules and App Check
  still matter for security.
- Generated build output, Flutter caches, local IDE files, signing keys, and
  private documentation folders are ignored.
- Runtime WebView/provider playback and Jellyfin playback should be manually
  verified on a real Android device before a production release.

## License

This project is licensed under the MIT License. See `LICENSE`.
