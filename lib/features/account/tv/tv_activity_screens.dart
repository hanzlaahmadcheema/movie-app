import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/user_activity_repository.dart';
import '../../../core/models/movie_item.dart';
import '../../../widgets/state_views.dart';
import '../../../widgets/firebase_posters.dart';
import '../../catalog/tv/tv_catalog_screen.dart'; // we can reuse _TvGridPoster if we want, wait no it's private.

class TvWatchlistScreen extends StatelessWidget {
  const TvWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<User?>(
        stream: AuthService.instance.authStateChanges,
        builder: (context, authSnapshot) {
          final user = authSnapshot.data;
          if (user == null) {
            return const AppErrorView(title: 'Not signed in', message: 'Please sign in.');
          }

          return StreamBuilder<List<UserContentRecord>>(
            stream: UserActivityRepository.instance.watchlistStream(user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final records = snapshot.data ?? [];
              if (records.isEmpty) {
                return const AppEmptyState(title: 'Watchlist Empty', message: 'Add movies or series to your watchlist.');
              }

              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Watchlist', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          return _TvActivityPoster(item: records[index].item);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TvContinueWatchingScreen extends StatelessWidget {
  const TvContinueWatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<User?>(
        stream: AuthService.instance.authStateChanges,
        builder: (context, authSnapshot) {
          final user = authSnapshot.data;
          if (user == null) {
            return const AppErrorView(title: 'Not signed in', message: 'Please sign in.');
          }

          return StreamBuilder<List<UserContentRecord>>(
            stream: UserActivityRepository.instance.watchedStream(user),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final records = snapshot.data ?? [];
              // Filter to show only items that are not fully watched (e.g. continue watching)
              // Since logic is in ContinueWatching list, we just display records for now.
              if (records.isEmpty) {
                return const AppEmptyState(title: 'Nothing here', message: 'Start watching movies or series.');
              }

              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Continue Watching', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          return _TvActivityPoster(item: records[index].item);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _TvActivityPoster extends StatefulWidget {
  final MovieItem item;

  const _TvActivityPoster({required this.item});

  @override
  State<_TvActivityPoster> createState() => _TvActivityPosterState();
}

class _TvActivityPosterState extends State<_TvActivityPoster> {
  bool _isFocused = false;

  void _scrollToCenter(BuildContext context) {
    Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (focused) _scrollToCenter(context);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.detailPathForItem(widget.item), arguments: widget.item);
        },
        child: AnimatedScale(
          scale: _isFocused ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isFocused ? Colors.white : Colors.transparent,
                width: 4,
              ),
              boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)] : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FirebasePoster(item: widget.item, heroTag: 'tv_activity_${widget.item.id}'),
            ),
          ),
        ),
      ),
    );
  }
}
