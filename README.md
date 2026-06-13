# MovieApp Flutter

Flutter mobile application for discovering movies and TV series using a modern dark-themed interface and TMDB API integration.

## Project Overview

MovieApp is a Flutter-based movie discovery application built from a Figma-inspired mobile UI. The app allows users to browse trending movies, trending TV series, latest movies, latest TV series, cast details, search results, detail pages, and watch screens.

The project uses a modular Flutter structure with separate layers for app routing, theme configuration, core services, models, reusable widgets, and feature-based screens.

## Key Features

- Dark-themed responsive Flutter UI
- Trending movies and trending TV series
- Latest movies and latest TV series
- Movie and series detail pages
- Cast detail pages
- Search functionality
- Genre, country, and production browsing
- Watch screens for movies and series
- TMDB API integration
- Environment-based API configuration
- Reusable widgets and modular project structure

## Tech Stack

- Flutter
- Dart
- TMDB API
- REST API
- HTTP
- flutter_dotenv
- Material UI
- Git
- GitHub

## Project Structure

- `lib/app/` contains app bootstrap, routes, and theme configuration.
- `lib/core/` contains config, constants, models, navigation, and services.
- `lib/features/` contains feature screens such as home, catalog, details, search, watch, and auth.
- `lib/widgets/` contains reusable UI components.
- `assets/images/` contains local image assets.

## Commands

```sh
flutter analyze
flutter test
flutter build apk --debug
