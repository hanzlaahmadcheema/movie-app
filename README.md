# MovieApp Flutter

Flutter mobile implementation of the MovieApp Figma design.

## Structure

- `lib/app/` contains theme, routes, and app bootstrap.
- `lib/core/` contains design constants, models, and mock data.
- `lib/widgets/` contains reusable UI widgets.
- `lib/features/` contains screens composed from shared widgets.
- `assets/images/` contains local image assets exported from Figma.

## Commands

```sh
flutter analyze
flutter test
flutter build apk --debug
```

The current build is UI-first with local mock data. Firebase integration points can be added next for auth, watchlist, likes, and catalog data.
