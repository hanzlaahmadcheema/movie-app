import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../core/models/movie_item.dart';
import '../core/services/auth_service.dart';
import '../core/services/user_activity_repository.dart';
import 'poster_widgets.dart';

class FirebasePosterGrid extends StatelessWidget {
  const FirebasePosterGrid({
    required this.items,
    this.itemCount,
    this.onItemTap,
    super.key,
  });

  final List<MovieItem> items;
  final int? itemCount;
  final ValueChanged<MovieItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return _WatchlistState(
      builder: (user, watchlistKeys) => PosterGrid(
        items: items,
        itemCount: itemCount,
        onItemTap: onItemTap,
        isWatchlisted: (item) => watchlistKeys.contains(contentKeyFor(item)),
        onWatchlistChanged: (item, active) =>
            _setWatchlisted(context, user, item, active),
      ),
    );
  }
}

class FirebaseHorizontalPosterSection extends StatelessWidget {
  const FirebaseHorizontalPosterSection({
    required this.title,
    required this.items,
    this.itemCount,
    this.onMore,
    this.onItemTap,
    super.key,
  });

  final String title;
  final List<MovieItem> items;
  final int? itemCount;
  final VoidCallback? onMore;
  final ValueChanged<MovieItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return _WatchlistState(
      builder: (user, watchlistKeys) => HorizontalPosterSection(
        title: title,
        items: items,
        itemCount: itemCount,
        onMore: onMore,
        onItemTap: onItemTap,
        isWatchlisted: (item) => watchlistKeys.contains(contentKeyFor(item)),
        onWatchlistChanged: (item, active) =>
            _setWatchlisted(context, user, item, active),
      ),
    );
  }
}

class _WatchlistState extends StatelessWidget {
  const _WatchlistState({required this.builder});

  final Widget Function(User? user, Set<String> watchlistKeys) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.instance.authStateChanges,
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;
        return StreamBuilder<Set<String>>(
          stream: UserActivityRepository.instance.watchlistKeysStream(user),
          builder: (context, watchlistSnapshot) {
            return builder(user, watchlistSnapshot.data ?? const <String>{});
          },
        );
      },
    );
  }
}

Future<void> _setWatchlisted(
  BuildContext context,
  User? user,
  MovieItem item,
  bool active,
) async {
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login to use your watchlist')),
    );
    await Navigator.pushNamed(context, AppRoutes.login);
    return;
  }

  try {
    await UserActivityRepository.instance.setWatchlisted(
      user: user,
      item: item,
      active: active,
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(active ? 'Added to watchlist' : 'Removed from watchlist'),
      ),
    );
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Could not save. Try again.')));
  }
}
