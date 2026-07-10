import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../core/navigation/content_navigation.dart';
import '../core/services/auth_service.dart';
import '../core/services/local_image_cache_service.dart';
import '../core/services/user_activity_repository.dart';
import 'network_art.dart';
import 'poster_widgets.dart';

class ContinueWatchingSection extends StatefulWidget {
  const ContinueWatchingSection({super.key});

  @override
  State<ContinueWatchingSection> createState() =>
      _ContinueWatchingSectionState();
}

class _ContinueWatchingSectionState extends State<ContinueWatchingSection> {
  int refreshKey = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      key: ValueKey(refreshKey),
      stream: AuthService.instance.authStateChanges,
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SectionHeader(
                title: 'Continue Watching',
                onMore: user == null
                    ? null
                    : () => Navigator.pushNamed(
                        context,
                        AppRoutes.continueWatching,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            if (user == null)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ContinueWatchingAuthRequired(compact: true),
              )
            else
              StreamBuilder<List<UserContentRecord>>(
                stream: UserActivityRepository.instance.activityListStream(
                  user,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ContinueWatchingError(
                      compact: true,
                      onRetry: () => setState(() => refreshKey++),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const ContinueWatchingLoading(compact: true);
                  }
                  final records = snapshot.data!;
                  if (records.isEmpty) {
                    return const ContinueWatchingEmpty(compact: true);
                  }
                  return SizedBox(
                    height: 150,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: records.take(10).length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) => SizedBox(
                        width: 300,
                        child: ContinueWatchingTile(record: records[index]),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class ContinueWatchingList extends StatefulWidget {
  const ContinueWatchingList({super.key});

  @override
  State<ContinueWatchingList> createState() => _ContinueWatchingListState();
}

class _ContinueWatchingListState extends State<ContinueWatchingList> {
  int refreshKey = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      key: ValueKey(refreshKey),
      stream: AuthService.instance.authStateChanges,
      builder: (context, authSnapshot) {
        final user = authSnapshot.data;
        if (user == null) {
          return const ContinueWatchingAuthRequired();
        }

        return StreamBuilder<List<UserContentRecord>>(
          stream: UserActivityRepository.instance.activityListStream(user),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ContinueWatchingError(
                onRetry: () => setState(() => refreshKey++),
              );
            }
            if (!snapshot.hasData) {
              return const ContinueWatchingLoading();
            }
            final records = snapshot.data!;
            if (records.isEmpty) {
              return const ContinueWatchingEmpty();
            }
            return Column(
              children: records
                  .map(
                    (record) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ContinueWatchingTile(record: record),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }
}

class ContinueWatchingTile extends StatelessWidget {
  const ContinueWatchingTile({required this.record, super.key});

  final UserContentRecord record;

  @override
  Widget build(BuildContext context) {
    final item = record.item;
    final activity = record.activity;
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => openContinueWatchingRecord(context, record),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: NetworkArt(
                  url: item.posterUrl,
                  imageType: LocalImageCacheService.imageTypePoster,
                  width: 76,
                  height: 114,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _MetaChip(item.type),
                        if (_episodeLabel(activity) != null)
                          _MetaChip(_episodeLabel(activity)!),
                        if (activity.selectedServer?.isNotEmpty == true)
                          _MetaChip(activity.selectedServer!),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _lastOpenedLabel(record),
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const SizedBox(height: 6),
                    if (activity.selectedServer == 'Jellyfin' && activity.durationSeconds != null && activity.durationSeconds! > 0) ...[
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final progress = (activity.positionSeconds / activity.durationSeconds!).clamp(0.0, 1.0);
                          final remainingSeconds = activity.durationSeconds! - activity.positionSeconds;
                          final remainingMinutes = (remainingSeconds / 60).round();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 4,
                                width: constraints.maxWidth,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: progress,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$remainingMinutes min remaining',
                                style: AppTextStyles.small.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ] else ...[
                      Text(
                        'Exact resume time is unavailable for embedded players.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.small.copyWith(
                          color: Colors.white.withValues(alpha: 0.58),
                        ),
                      ),
                    ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'Remove from Continue Watching',
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () => _removeRecord(context),
                  ),
                  const SizedBox(height: 8),
                  const Icon(
                    Icons.play_arrow,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _removeRecord(BuildContext context) async {
    final user = AuthService.instance.currentUser;
    if (user == null) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Remove Item'),
        content: Text(
          'Remove "${record.item.title}" from Continue Watching?',
          style: AppTextStyles.normal,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirm != true || !context.mounted) return;

    try {
      await UserActivityRepository.instance.removeActivity(
        user: user,
        item: record.item,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Removed "${record.item.title}" from Continue Watching',
          ),
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not remove. Try again.')),
      );
    }
  }
}

class ContinueWatchingAuthRequired extends StatelessWidget {
  const ContinueWatchingAuthRequired({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _ContinueWatchingStateBox(
      compact: compact,
      icon: Icons.lock_outline,
      title: 'Sign in to continue watching',
      message: 'Your private watch activity appears here after you sign in.',
      actionLabel: 'Login',
      onAction: () => Navigator.pushNamed(context, AppRoutes.login),
    );
  }
}

class ContinueWatchingEmpty extends StatelessWidget {
  const ContinueWatchingEmpty({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _ContinueWatchingStateBox(
      compact: compact,
      icon: Icons.history,
      title: 'No watch activity yet',
      message: 'Start a movie or series and it will appear here.',
      actionLabel: 'Browse Movies',
      onAction: () => Navigator.pushNamed(context, AppRoutes.movies),
      secondaryActionLabel: compact ? null : 'Browse Series',
      onSecondaryAction: compact
          ? null
          : () => Navigator.pushNamed(context, AppRoutes.series),
    );
  }
}

class ContinueWatchingError extends StatelessWidget {
  const ContinueWatchingError({
    required this.onRetry,
    this.compact = false,
    super.key,
  });

  final VoidCallback onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _ContinueWatchingStateBox(
      compact: compact,
      icon: Icons.cloud_off_outlined,
      title: 'Could not load watch activity',
      message: 'Check your connection and try again.',
      actionLabel: 'Retry',
      onAction: onRetry,
    );
  }
}

class ContinueWatchingLoading extends StatelessWidget {
  const ContinueWatchingLoading({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact ? 118 : 180,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class _ContinueWatchingStateBox extends StatelessWidget {
  const _ContinueWatchingStateBox({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 14 : 22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: compact ? 28 : 42),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.medium, textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text(
            message,
            style: AppTextStyles.normal.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                FilledButton(onPressed: onAction, child: Text(actionLabel!)),
                if (secondaryActionLabel != null && onSecondaryAction != null)
                  OutlinedButton(
                    onPressed: onSecondaryAction,
                    child: Text(secondaryActionLabel!),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryMuted,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTextStyles.tag.copyWith(color: AppColors.primary),
      ),
    );
  }
}

String _lastOpenedLabel(UserContentRecord record) {
  final lastOpened = record.lastWatchedAt ?? record.updatedAt;
  if (lastOpened == null) {
    return 'Last opened recently';
  }
  return 'Last opened ${_relativeTime(lastOpened)}';
}

String _relativeTime(DateTime time) {
  final diff = DateTime.now().difference(time);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes}m ago';
  if (diff.inDays < 1) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  final date = '${time.year}-${_two(time.month)}-${_two(time.day)}';
  return 'on $date';
}

String _two(int value) => value.toString().padLeft(2, '0');

String? _episodeLabel(UserActivity activity) {
  if (activity.seasonNumber == null && activity.episodeNumber == null) {
    return null;
  }
  final season = activity.seasonNumber == null
      ? '?'
      : '${activity.seasonNumber}';
  final episode = activity.episodeNumber == null
      ? '?'
      : '${activity.episodeNumber}';
  return 'S$season E$episode';
}
