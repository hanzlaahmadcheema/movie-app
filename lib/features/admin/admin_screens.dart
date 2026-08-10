import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/auth/current_user_role.dart';
import '../../core/auth/user_role_service.dart';
import '../../core/services/admin_repository.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/state_views.dart';

class AdminRouteGate extends StatelessWidget {
  const AdminRouteGate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      return const LoginScreenPlaceholder();
    }
    return StreamBuilder<CurrentUserRole>(
      stream: UserRoleService.instance.watchRole(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active &&
            !snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final role =
            snapshot.data ?? CurrentUserRole.fromJson(user.uid, const {});
        if (!role.isAdmin) {
          return const AccessDeniedScreen(
            message: 'Admin access requires a Firestore role of admin.',
          );
        }
        return child;
      },
    );
  }
}

class LoginScreenPlaceholder extends StatelessWidget {
  const LoginScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key, this.statsLoader});

  final Future<AdminDashboardStats> Function()? statsLoader;

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late Future<AdminDashboardStats> _statsFuture = _load();

  Future<AdminDashboardStats> _load() =>
      widget.statsLoader?.call() ??
      AdminRepository.instance.loadDashboardStats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Admin Panel')),
      body: FutureBuilder<AdminDashboardStats>(
        future: _statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return AppErrorView(
              title: 'Could not load admin dashboard',
              message: userMessageForError(snapshot.error),
              onRetry: () => setState(() => _statsFuture = _load()),
            );
          }
          final stats = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Overview', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _StatCard(label: 'Total users', value: stats.totalUsers),
                  _StatCard(label: 'Active users', value: stats.activeUsers),
                  _StatCard(
                    label: 'New users today',
                    value: stats.newUsersToday,
                  ),
                  _StatCard(
                    label: 'Watchlist records',
                    value: stats.watchlistRecords,
                  ),
                  _StatCard(
                    label: 'Continue Watching',
                    value: stats.continueWatchingRecords,
                  ),
                  _StatCard(
                    label: 'Playback errors',
                    value: stats.playbackErrors,
                  ),
                  _StatCard(
                    label: 'Provider configs',
                    value: stats.providerStatuses,
                  ),
                  _StatCard(
                    label: 'Jellyfin status',
                    value: stats.jellyfinStatus,
                  ),
                  _StatCard(
                    label: 'Latest reports',
                    value: stats.latestReports,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Quick actions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ...[
                ('Manage Banners', AppRoutes.adminBanners),
                ('Manage Featured Content', AppRoutes.adminFeatured),
                ('Manage Notices', AppRoutes.adminNotices),
                ('Provider Settings', AppRoutes.adminProviders),
                ('User Management', AppRoutes.adminUsers),
                ('Playback Logs', AppRoutes.adminPlaybackLogs),
                ('Content Requests', AppRoutes.adminRequests),
                ('App Config', AppRoutes.adminAppConfig),
                ('Jellyfin Config', AppRoutes.adminJellyfin),
                ('Security Audit', AppRoutes.adminSecurity),
              ].map(
                (entry) => Card(
                  child: ListTile(
                    title: Text(entry.$1),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(context, entry.$2),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AdminFeaturedScreen extends StatelessWidget {
  const AdminFeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AdminCollectionScreen<FeaturedContentConfig>(
      title: 'Featured Content',
      stream: AdminRepository.instance.watchFeaturedContent(),
      itemBuilder: (context, item) => ListTile(
        title: Text('${item.tmdbId} - ${item.section}'),
        subtitle: Text(
          '${item.contentType.name} • order ${item.order} • ${item.enabled ? 'enabled' : 'disabled'}',
        ),
        trailing: const Icon(Icons.edit_outlined),
        onTap: () => _showFeaturedDialog(context, initial: item),
      ),
      onAdd: () => _showFeaturedDialog(context),
      onDelete: (item) =>
          AdminRepository.instance.deleteFeaturedContent(item.id),
    );
  }
}

class AdminBannersScreen extends StatelessWidget {
  const AdminBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AdminCollectionScreen<AdminBanner>(
      title: 'Banners',
      stream: AdminRepository.instance.watchBanners(),
      itemBuilder: (context, item) => ListTile(
        title: Text(item.title),
        subtitle: Text(
          'TMDB ${item.tmdbId} • ${item.buttonAction.name} • ${item.enabled ? 'enabled' : 'disabled'}',
        ),
        trailing: const Icon(Icons.edit_outlined),
        onTap: () => _showBannerDialog(context, initial: item),
      ),
      onAdd: () => _showBannerDialog(context),
      onDelete: (item) => AdminRepository.instance.deleteBanner(item.id),
    );
  }
}

class AdminNoticesScreen extends StatelessWidget {
  const AdminNoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AdminCollectionScreen<AdminNotice>(
      title: 'Notices',
      stream: AdminRepository.instance.watchNotices(),
      itemBuilder: (context, item) => ListTile(
        title: Text(item.title),
        subtitle: Text('${item.type.name} • ${item.target.name}'),
        trailing: const Icon(Icons.edit_outlined),
        onTap: () => _showNoticeDialog(context, initial: item),
      ),
      onAdd: () => _showNoticeDialog(context),
      onDelete: (item) => AdminRepository.instance.deleteNotice(item.id),
    );
  }
}

class AdminProvidersScreen extends StatelessWidget {
  const AdminProvidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Providers')),
      body: StreamBuilder<List<ProviderConfigRecord>>(
        stream: AdminRepository.instance.watchProviders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorView(
              title: 'Could not load providers',
              message: userMessageForError(snapshot.error),
            );
          }
          final providers = snapshot.data ?? const <ProviderConfigRecord>[];
          if (providers.isEmpty) {
            return AppEmptyState(
              title: 'No provider configs',
              message:
                  'Add provider settings for Jellyfin, Hindi Player, VidSrc, 2Embed, Videasy, StreamVault, 111Movies, and VidKing.',
              actionLabel: 'Seed Providers',
              onAction: () => _seedProviders(context),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: providers
                .map(
                  (provider) => Card(
                    child: ListTile(
                      title: Text(provider.displayName),
                      subtitle: Text(
                        'priority ${provider.priority} • ${provider.enabled ? 'enabled' : 'disabled'} • ${provider.fallbackAllowed ? 'fallback allowed' : 'no fallback'}',
                      ),
                      trailing: const Icon(Icons.edit_outlined),
                      onTap: () =>
                          _showProviderDialog(context, initial: provider),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  Future<void> _seedProviders(BuildContext context) async {
    for (final provider in AdminRepository.defaultProviderConfigs) {
      await AdminRepository.instance.saveProviderConfig(provider);
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Default provider configs created.')),
    );
  }
}

class AdminJellyfinScreen extends StatefulWidget {
  const AdminJellyfinScreen({super.key});

  @override
  State<AdminJellyfinScreen> createState() => _AdminJellyfinScreenState();
}

class _AdminJellyfinScreenState extends State<AdminJellyfinScreen> {
  late Future<AppRemoteConfig> _configFuture = AdminRepository.instance
      .loadPublicAppConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Jellyfin Public Config')),
      body: FutureBuilder<AppRemoteConfig>(
        future: _configFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return AppErrorView(
              title: 'Could not load Jellyfin config',
              message: userMessageForError(snapshot.error),
              onRetry: () => setState(
                () => _configFuture = AdminRepository.instance
                    .loadPublicAppConfig(),
              ),
            );
          }
          return _JellyfinConfigForm(
            config: snapshot.data!,
            onSaved: () => setState(
              () => _configFuture = AdminRepository.instance
                  .loadPublicAppConfig(),
            ),
          );
        },
      ),
    );
  }
}

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Users')),
      body: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        stream: AdminRepository.instance.watchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorView(
              title: 'Could not load users',
              message: userMessageForError(snapshot.error),
            );
          }
          final docs = snapshot.data ?? const [];
          final filtered = docs.where((doc) {
            if (_query.trim().isEmpty) return true;
            final data = doc.data();
            final haystack =
                '${data['displayName'] ?? ''} ${data['email'] ?? ''}'
                    .toLowerCase();
            return haystack.contains(_query.trim().toLowerCase());
          }).toList();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: const InputDecoration(
                  hintText: 'Search by name or email',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 12),
              ...filtered.map((doc) => _UserSummaryCard(doc: doc)),
            ],
          );
        },
      ),
    );
  }
}

class AdminRequestsScreen extends StatelessWidget {
  const AdminRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Content Requests')),
      body: StreamBuilder<List<ContentRequestRecord>>(
        stream: AdminRepository.instance.watchContentRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorView(
              title: 'Could not load requests',
              message: userMessageForError(snapshot.error),
            );
          }
          final records = snapshot.data ?? const <ContentRequestRecord>[];
          if (records.isEmpty) {
            return const AppEmptyState(
              title: 'No requests yet',
              message:
                  'User content requests and issue reports will appear here.',
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: records
                .map(
                  (record) => Card(
                    child: ListTile(
                      title: Text(record.title),
                      subtitle: Text(
                        '${record.type.name} • ${record.status.name} • ${record.userEmail}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showRequestStatusSheet(context, record),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class AdminPlaybackLogsScreen extends StatefulWidget {
  const AdminPlaybackLogsScreen({super.key});

  @override
  State<AdminPlaybackLogsScreen> createState() =>
      _AdminPlaybackLogsScreenState();
}

class _AdminPlaybackLogsScreenState extends State<AdminPlaybackLogsScreen> {
  String _providerFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Playback Logs')),
      body: StreamBuilder<List<PlaybackLogRecord>>(
        stream: AdminRepository.instance.watchPlaybackLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorView(
              title: 'Could not load playback logs',
              message: userMessageForError(snapshot.error),
            );
          }
          final logs = snapshot.data ?? const <PlaybackLogRecord>[];
          final providers = {
            'all',
            ...logs
                .map((log) => log.providerId)
                .where((value) => value.isNotEmpty),
          }.toList();
          final filtered = logs.where((log) {
            return _providerFilter == 'all' ||
                log.providerId == _providerFilter;
          }).toList();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: providers
                    .map(
                      (provider) => ChoiceChip(
                        label: Text(provider),
                        selected: _providerFilter == provider,
                        onSelected: (_) =>
                            setState(() => _providerFilter = provider),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              if (filtered.isEmpty)
                const AppEmptyState(
                  title: 'No playback logs',
                  message:
                      'Safe playback logs will appear here when errors are reported.',
                )
              else
                ...filtered.map(
                  (log) => Card(
                    child: ListTile(
                      title: Text(log.errorType),
                      subtitle: Text(
                        '${log.providerId} • ${log.playbackMode} • ${log.errorMessageSafe}',
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class AdminAppConfigScreen extends StatefulWidget {
  const AdminAppConfigScreen({super.key});

  @override
  State<AdminAppConfigScreen> createState() => _AdminAppConfigScreenState();
}

class _AdminAppConfigScreenState extends State<AdminAppConfigScreen> {
  late Future<AppRemoteConfig> _configFuture = AdminRepository.instance
      .loadPublicAppConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('App Config')),
      body: FutureBuilder<AppRemoteConfig>(
        future: _configFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return AppErrorView(
              title: 'Could not load app config',
              message: userMessageForError(snapshot.error),
              onRetry: () => setState(
                () => _configFuture = AdminRepository.instance
                    .loadPublicAppConfig(),
              ),
            );
          }
          return _AppConfigForm(
            config: snapshot.data!,
            onSaved: () => setState(
              () => _configFuture = AdminRepository.instance
                  .loadPublicAppConfig(),
            ),
          );
        },
      ),
    );
  }
}

class AdminSecurityScreen extends StatelessWidget {
  const AdminSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Security Audit')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SecurityTile(
            'Client admin route guard',
            SecurityStatus.verified,
            'Admin screens are routed through the app role guard. Firestore rules must still be verified separately.',
          ),
          _SecurityTile(
            'Firestore rules deployment',
            SecurityStatus.unableToVerify,
            'Unable to verify from client. Confirm the deployed ruleset with Firebase tooling before release.',
          ),
          _SecurityTile(
            'TMDB token handling',
            SecurityStatus.warning,
            'The app uses direct TMDB API access. Keep the token out of source control, logs, Firestore, and UI; APK-contained dart-defines can still be extracted.',
          ),
          _SecurityTile(
            'Firebase App Check',
            SecurityStatus.notConfigured,
            'No client evidence of App Check enforcement is available here.',
          ),
          _SecurityTile(
            'Jellyfin token storage',
            SecurityStatus.unableToVerify,
            'Unable to verify from client. Code review should confirm tokens stay in secure local storage only.',
          ),
          _SecurityTile(
            'Provider URL validation',
            SecurityStatus.warning,
            'Navigation policy exists, but provider behavior must be regression-tested on device.',
          ),
          _SecurityTile(
            'Playback log redaction',
            SecurityStatus.warning,
            'Logs are intended to store safe metadata only. Review new fields before release.',
          ),
        ],
      ),
    );
  }
}

enum SecurityStatus { verified, warning, notConfigured, unableToVerify }

class ContentRequestFormScreen extends StatefulWidget {
  const ContentRequestFormScreen({super.key});

  @override
  State<ContentRequestFormScreen> createState() =>
      _ContentRequestFormScreenState();
}

class _ContentRequestFormScreenState extends State<ContentRequestFormScreen> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  ContentRequestType _type = ContentRequestType.other;
  bool _submitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      return const LoginScreenPlaceholder();
    }
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: const Text('Request Content / Report Issue')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<ContentRequestType>(
            initialValue: _type,
            items: ContentRequestType.values
                .map(
                  (value) =>
                      DropdownMenuItem(value: value, child: Text(value.name)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _type = value);
            },
            decoration: const InputDecoration(labelText: 'Request type'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _messageController,
            minLines: 4,
            maxLines: 6,
            decoration: const InputDecoration(labelText: 'Message'),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _submitting ? null : () => _submit(user),
            child: Text(_submitting ? 'Submitting...' : 'Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(User user) async {
    if (_titleController.text.trim().isEmpty ||
        _messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and message are required.')),
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      await AdminRepository.instance.createContentRequest(
        ContentRequestRecord(
          id: '',
          userId: user.uid,
          userEmail: user.email ?? '',
          type: _type,
          title: _titleController.text,
          message: _messageController.text,
          status: ContentRequestStatus.pending,
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Request submitted.')));
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(userMessageForError(error))));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

class _AdminCollectionScreen<T> extends StatelessWidget {
  const _AdminCollectionScreen({
    required this.title,
    required this.stream,
    required this.itemBuilder,
    required this.onAdd,
    required this.onDelete,
  });

  final String title;
  final Stream<List<T>> stream;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final VoidCallback onAdd;
  final Future<void> Function(T item) onDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<T>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorView(
              title: 'Could not load $title',
              message: userMessageForError(snapshot.error),
            );
          }
          final items = snapshot.data ?? <T>[];
          if (items.isEmpty) {
            return AppEmptyState(
              title: 'No $title',
              message: 'Add your first item to start managing this section.',
              actionLabel: 'Add',
              onAction: onAdd,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                key: ValueKey(item.hashCode),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  await onDelete(item);
                  return false;
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 24),
                  child: const Icon(Icons.delete_outline),
                ),
                child: Card(child: itemBuilder(context, item)),
              );
            },
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 44) / 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(label, style: AppTextStyles.normal),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecurityTile extends StatelessWidget {
  const _SecurityTile(this.label, this.status, this.message);

  final String label;
  final SecurityStatus status;
  final String message;

  IconData get _icon => switch (status) {
    SecurityStatus.verified => Icons.verified_outlined,
    SecurityStatus.warning => Icons.warning_amber_outlined,
    SecurityStatus.notConfigured => Icons.settings_outlined,
    SecurityStatus.unableToVerify => Icons.help_outline,
  };

  Color get _color => switch (status) {
    SecurityStatus.verified => AppColors.primary,
    SecurityStatus.warning => Colors.amber,
    SecurityStatus.notConfigured => Colors.orange,
    SecurityStatus.unableToVerify => Colors.blueGrey,
  };

  String get _statusLabel => switch (status) {
    SecurityStatus.verified => 'Verified',
    SecurityStatus.warning => 'Warning',
    SecurityStatus.notConfigured => 'Not configured',
    SecurityStatus.unableToVerify => 'Unable to verify',
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(_icon, color: _color),
        title: Text(label),
        subtitle: Text('$_statusLabel: $message'),
      ),
    );
  }
}

class _UserSummaryCard extends StatelessWidget {
  const _UserSummaryCard({required this.doc});

  final QueryDocumentSnapshot<Map<String, dynamic>> doc;

  @override
  Widget build(BuildContext context) {
    final data = doc.data();
    final createdAt = data['createdAt'] is Timestamp
        ? (data['createdAt'] as Timestamp).toDate()
        : null;
    final lastLoginAt = data['lastLoginAt'] is Timestamp
        ? (data['lastLoginAt'] as Timestamp).toDate()
        : null;
    return Card(
      child: ListTile(
        title: Text((data['displayName'] ?? 'Unknown user').toString()),
        subtitle: Text(
          '${data['email'] ?? data['uid']} \nrole: ${data['role'] ?? 'user'} • status: ${data['status'] ?? 'active'} • verified: ${data['isVerified'] == true || data['verified'] == true}\ncreated: ${_dateLabel(createdAt)} • last login: ${_dateLabel(lastLoginAt)}',
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.edit),
        onTap: () => _showUserManagementSheet(context, doc),
      ),
    );
  }
}

String _dateLabel(DateTime? value) {
  if (value == null) return 'N/A';
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '${value.year}-$month-$day';
}

Future<void> _showUserManagementSheet(
  BuildContext context,
  QueryDocumentSnapshot<Map<String, dynamic>> doc,
) async {
  final data = doc.data();
  var role = (data['role'] ?? 'user').toString();
  var status = (data['status'] ?? 'active').toString();
  var isVerified = data['isVerified'] == true || data['verified'] == true;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage ${(data['displayName'] ?? 'Unknown user')}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: ['user', 'admin', 'super_admin'].contains(role) ? role : 'user',
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('User')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'super_admin', child: Text('Super Admin')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => role = value);
                },
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: ['active', 'blocked'].contains(status) ? status : 'active',
                items: const [
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'blocked', child: Text('Blocked')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => status = value);
                },
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Verified User'),
                subtitle: const Text('Allows access to watch content'),
                value: isVerified,
                onChanged: (value) => setState(() => isVerified = value),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () async {
                  await AdminRepository.instance.updateUser(
                    doc.id,
                    {
                      'role': role,
                      'status': status,
                      'isVerified': isVerified,
                    },
                  );
                  if (!sheetContext.mounted) return;
                  Navigator.pop(sheetContext);
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _showFeaturedDialog(
  BuildContext context, {
  FeaturedContentConfig? initial,
}) async {
  final tmdbId = TextEditingController(text: initial?.tmdbId.toString() ?? '');
  final section = TextEditingController(text: initial?.section ?? 'featured');
  final titleOverride = TextEditingController(
    text: initial?.titleOverride ?? '',
  );
  final subtitle = TextEditingController(text: initial?.subtitle ?? '');
  final order = TextEditingController(text: (initial?.order ?? 0).toString());
  var enabled = initial?.enabled ?? true;
  var contentType = initial?.contentType ?? AdminContentType.movie;
  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            initial == null ? 'Add featured item' : 'Edit featured item',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tmdbId,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'TMDB ID'),
                ),
                DropdownButtonFormField<AdminContentType>(
                  initialValue: contentType,
                  items: AdminContentType.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => contentType = value);
                  },
                  decoration: const InputDecoration(labelText: 'Content type'),
                ),
                TextField(
                  controller: section,
                  decoration: const InputDecoration(labelText: 'Section'),
                ),
                TextField(
                  controller: titleOverride,
                  decoration: const InputDecoration(
                    labelText: 'Title override',
                  ),
                ),
                TextField(
                  controller: subtitle,
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                ),
                TextField(
                  controller: order,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Order'),
                ),
                SwitchListTile(
                  value: enabled,
                  title: const Text('Enabled'),
                  onChanged: (value) => setState(() => enabled = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final id = int.tryParse(tmdbId.text.trim());
                if (id == null || id <= 0) return;
                await AdminRepository.instance.saveFeaturedContent(
                  id: initial?.id,
                  item: FeaturedContentConfig(
                    id: initial?.id ?? '',
                    tmdbId: id,
                    contentType: contentType,
                    section: section.text.trim().isEmpty
                        ? 'featured'
                        : section.text.trim(),
                    titleOverride: titleOverride.text,
                    subtitle: subtitle.text,
                    order: int.tryParse(order.text.trim()) ?? 0,
                    enabled: enabled,
                  ),
                );
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _showBannerDialog(
  BuildContext context, {
  AdminBanner? initial,
}) async {
  final title = TextEditingController(text: initial?.title ?? '');
  final subtitle = TextEditingController(text: initial?.subtitle ?? '');
  final tmdbId = TextEditingController(text: initial?.tmdbId.toString() ?? '');
  final imageUrl = TextEditingController(text: initial?.imageUrl ?? '');
  final buttonText = TextEditingController(
    text: initial?.buttonText ?? 'Watch Now',
  );
  final order = TextEditingController(text: (initial?.order ?? 0).toString());
  var enabled = initial?.enabled ?? true;
  var action = initial?.buttonAction ?? BannerActionType.watch;
  var contentType = initial?.contentType ?? AdminContentType.movie;
  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(initial == null ? 'Add banner' : 'Edit banner'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: subtitle,
                  decoration: const InputDecoration(labelText: 'Subtitle'),
                ),
                TextField(
                  controller: tmdbId,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'TMDB ID'),
                ),
                DropdownButtonFormField<AdminContentType>(
                  initialValue: contentType,
                  items: AdminContentType.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => contentType = value);
                  },
                  decoration: const InputDecoration(labelText: 'Content type'),
                ),
                TextField(
                  controller: imageUrl,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: buttonText,
                  decoration: const InputDecoration(labelText: 'Button text'),
                ),
                DropdownButtonFormField<BannerActionType>(
                  initialValue: action,
                  items: BannerActionType.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => action = value);
                  },
                  decoration: const InputDecoration(labelText: 'Button action'),
                ),
                TextField(
                  controller: order,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Order'),
                ),
                SwitchListTile(
                  value: enabled,
                  title: const Text('Enabled'),
                  onChanged: (value) => setState(() => enabled = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final id = int.tryParse(tmdbId.text.trim());
                if (id == null || id <= 0 || title.text.trim().isEmpty) return;
                await AdminRepository.instance.saveBanner(
                  id: initial?.id,
                  banner: AdminBanner(
                    id: initial?.id ?? '',
                    title: title.text,
                    subtitle: subtitle.text,
                    tmdbId: id,
                    contentType: contentType,
                    imageUrl: imageUrl.text,
                    buttonText: buttonText.text,
                    buttonAction: action,
                    order: int.tryParse(order.text.trim()) ?? 0,
                    enabled: enabled,
                  ),
                );
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _showNoticeDialog(
  BuildContext context, {
  AdminNotice? initial,
}) async {
  final title = TextEditingController(text: initial?.title ?? '');
  final message = TextEditingController(text: initial?.message ?? '');
  var type = initial?.type ?? NoticeType.info;
  var target = initial?.target ?? NoticeTarget.all;
  var enabled = initial?.enabled ?? true;
  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(initial == null ? 'Add notice' : 'Edit notice'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: message,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: 'Message'),
                ),
                DropdownButtonFormField<NoticeType>(
                  initialValue: type,
                  items: NoticeType.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => type = value);
                  },
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                DropdownButtonFormField<NoticeTarget>(
                  initialValue: target,
                  items: NoticeTarget.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => target = value);
                  },
                  decoration: const InputDecoration(labelText: 'Target'),
                ),
                SwitchListTile(
                  value: enabled,
                  title: const Text('Enabled'),
                  onChanged: (value) => setState(() => enabled = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (title.text.trim().isEmpty || message.text.trim().isEmpty) {
                  return;
                }
                await AdminRepository.instance.saveNotice(
                  id: initial?.id,
                  notice: AdminNotice(
                    id: initial?.id ?? '',
                    title: title.text,
                    message: message.text,
                    type: type,
                    target: target,
                    enabled: enabled,
                  ),
                );
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _showProviderDialog(
  BuildContext context, {
  required ProviderConfigRecord initial,
}) async {
  final displayName = TextEditingController(text: initial.displayName);
  final statusMessage = TextEditingController(
    text: initial.statusMessage ?? '',
  );
  final priority = TextEditingController(text: initial.priority.toString());
  var enabled = initial.enabled;
  var maintenanceMode = initial.maintenanceMode;
  var fallbackAllowed = initial.fallbackAllowed;
  await showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(initial.providerId),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: displayName,
                  decoration: const InputDecoration(labelText: 'Display name'),
                ),
                TextField(
                  controller: priority,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Priority'),
                ),
                TextField(
                  controller: statusMessage,
                  decoration: const InputDecoration(
                    labelText: 'Status message',
                  ),
                ),
                SwitchListTile(
                  value: enabled,
                  title: const Text('Enabled'),
                  onChanged: (value) => setState(() => enabled = value),
                ),
                SwitchListTile(
                  value: maintenanceMode,
                  title: const Text('Maintenance mode'),
                  onChanged: (value) => setState(() => maintenanceMode = value),
                ),
                SwitchListTile(
                  value: fallbackAllowed,
                  title: const Text('Fallback allowed'),
                  onChanged: (value) => setState(() => fallbackAllowed = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                await AdminRepository.instance.saveProviderConfig(
                  ProviderConfigRecord(
                    id: initial.id,
                    providerId: initial.providerId,
                    displayName: displayName.text.trim().isEmpty
                        ? initial.displayName
                        : displayName.text.trim(),
                    enabled: enabled,
                    priority:
                        int.tryParse(priority.text.trim()) ?? initial.priority,
                    maintenanceMode: maintenanceMode,
                    fallbackAllowed: fallbackAllowed,
                    statusMessage: statusMessage.text,
                  ),
                );
                if (!dialogContext.mounted) return;
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _showRequestStatusSheet(
  BuildContext context,
  ContentRequestRecord record,
) async {
  final noteController = TextEditingController(text: record.adminNote ?? '');
  var status = record.status;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    builder: (sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
        ),
        child: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(record.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              DropdownButtonFormField<ContentRequestStatus>(
                initialValue: status,
                items: ContentRequestStatus.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => status = value);
                },
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Admin note'),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  await AdminRepository.instance.updateContentRequestStatus(
                    id: record.id,
                    status: status,
                    adminNote: noteController.text,
                  );
                  if (!sheetContext.mounted) return;
                  Navigator.pop(sheetContext);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _JellyfinConfigForm extends StatefulWidget {
  const _JellyfinConfigForm({required this.config, required this.onSaved});

  final AppRemoteConfig config;
  final VoidCallback onSaved;

  @override
  State<_JellyfinConfigForm> createState() => _JellyfinConfigFormState();
}

class _JellyfinConfigFormState extends State<_JellyfinConfigForm> {
  late final _serverController = TextEditingController(
    text: widget.config.defaultJellyfinServerUrl,
  );
  late final _tailscaleController = TextEditingController(
    text: widget.config.tailscaleRequiredMessage,
  );
  late final _guideController = TextEditingController(
    text: widget.config.jellyfinSetupGuide,
  );
  late bool _enabled = widget.config.jellyfinEnabled;
  late bool _nativeEnabled = widget.config.jellyfinNativeEnabled;
  late bool _webEnabled = widget.config.jellyfinWebEnabled;
  bool _saving = false;

  @override
  void dispose() {
    _serverController.dispose();
    _tailscaleController.dispose();
    _guideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _serverController,
          decoration: const InputDecoration(labelText: 'Default server URL'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _tailscaleController,
          decoration: const InputDecoration(
            labelText: 'Tailscale required message',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _guideController,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(labelText: 'Setup guide'),
        ),
        SwitchListTile(
          value: _enabled,
          title: const Text('Jellyfin enabled'),
          onChanged: (value) => setState(() => _enabled = value),
        ),
        SwitchListTile(
          value: _nativeEnabled,
          title: const Text('Native player enabled'),
          onChanged: (value) => setState(() => _nativeEnabled = value),
        ),
        SwitchListTile(
          value: _webEnabled,
          title: const Text('Web player enabled'),
          onChanged: (value) => setState(() => _webEnabled = value),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Saving...' : 'Save'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await AdminRepository.instance.saveAppConfig(
        AppRemoteConfig(
          maintenanceMode: widget.config.maintenanceMode,
          maintenanceMessage: widget.config.maintenanceMessage,
          minimumAppVersion: widget.config.minimumAppVersion,
          forceUpdateEnabled: widget.config.forceUpdateEnabled,
          forceUpdateMessage: widget.config.forceUpdateMessage,
          signupEnabled: widget.config.signupEnabled,
          googleLoginEnabled: widget.config.googleLoginEnabled,
          phoneLoginEnabled: widget.config.phoneLoginEnabled,
          defaultPlaybackMode: widget.config.defaultPlaybackMode,
          contactEmail: widget.config.contactEmail,
          supportWhatsapp: widget.config.supportWhatsapp,
          privacyPolicyUrl: widget.config.privacyPolicyUrl,
          termsUrl: widget.config.termsUrl,
          defaultJellyfinServerUrl: _serverController.text,
          jellyfinEnabled: _enabled,
          jellyfinNativeEnabled: _nativeEnabled,
          jellyfinWebEnabled: _webEnabled,
          tailscaleRequiredMessage: _tailscaleController.text,
          jellyfinSetupGuide: _guideController.text,
        ),
      );
      if (!mounted) return;
      widget.onSaved();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Jellyfin config saved.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _AppConfigForm extends StatefulWidget {
  const _AppConfigForm({required this.config, required this.onSaved});

  final AppRemoteConfig config;
  final VoidCallback onSaved;

  @override
  State<_AppConfigForm> createState() => _AppConfigFormState();
}

class _AppConfigFormState extends State<_AppConfigForm> {
  late final _maintenanceController = TextEditingController(
    text: widget.config.maintenanceMessage,
  );
  late final _minVersionController = TextEditingController(
    text: widget.config.minimumAppVersion,
  );
  late final _forceUpdateController = TextEditingController(
    text: widget.config.forceUpdateMessage,
  );
  late final _contactController = TextEditingController(
    text: widget.config.contactEmail,
  );
  late final _whatsappController = TextEditingController(
    text: widget.config.supportWhatsapp,
  );
  late final _paymentWhatsappController = TextEditingController(
    text: widget.config.paymentWhatsappLink,
  );
  late final _privacyController = TextEditingController(
    text: widget.config.privacyPolicyUrl,
  );
  late final _termsController = TextEditingController(
    text: widget.config.termsUrl,
  );
  late bool _maintenanceMode = widget.config.maintenanceMode;
  late bool _forceUpdateEnabled = widget.config.forceUpdateEnabled;
  late bool _signupEnabled = widget.config.signupEnabled;
  late bool _googleLoginEnabled = widget.config.googleLoginEnabled;
  late bool _phoneLoginEnabled = widget.config.phoneLoginEnabled;
  bool _saving = false;

  @override
  void dispose() {
    _maintenanceController.dispose();
    _minVersionController.dispose();
    _forceUpdateController.dispose();
    _contactController.dispose();
    _whatsappController.dispose();
    _paymentWhatsappController.dispose();
    _privacyController.dispose();
    _termsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          value: _maintenanceMode,
          title: const Text('Maintenance mode'),
          onChanged: (value) => setState(() => _maintenanceMode = value),
        ),
        TextField(
          controller: _maintenanceController,
          decoration: const InputDecoration(labelText: 'Maintenance message'),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          value: _forceUpdateEnabled,
          title: const Text('Force update'),
          onChanged: (value) => setState(() => _forceUpdateEnabled = value),
        ),
        TextField(
          controller: _minVersionController,
          decoration: const InputDecoration(labelText: 'Minimum app version'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _forceUpdateController,
          decoration: const InputDecoration(labelText: 'Force update message'),
        ),
        SwitchListTile(
          value: _signupEnabled,
          title: const Text('Signup enabled'),
          onChanged: (value) => setState(() => _signupEnabled = value),
        ),
        SwitchListTile(
          value: _googleLoginEnabled,
          title: const Text('Google login enabled'),
          onChanged: (value) => setState(() => _googleLoginEnabled = value),
        ),
        SwitchListTile(
          value: _phoneLoginEnabled,
          title: const Text('Phone login enabled'),
          onChanged: (value) => setState(() => _phoneLoginEnabled = value),
        ),
        TextField(
          controller: _contactController,
          decoration: const InputDecoration(labelText: 'Contact email'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _whatsappController,
          decoration: const InputDecoration(labelText: 'Support WhatsApp'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _paymentWhatsappController,
          decoration: const InputDecoration(labelText: 'Payment WhatsApp Link'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _privacyController,
          decoration: const InputDecoration(labelText: 'Privacy policy URL'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _termsController,
          decoration: const InputDecoration(labelText: 'Terms URL'),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Saving...' : 'Save'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await AdminRepository.instance.saveAppConfig(
        AppRemoteConfig(
          maintenanceMode: _maintenanceMode,
          maintenanceMessage: _maintenanceController.text,
          minimumAppVersion: _minVersionController.text,
          forceUpdateEnabled: _forceUpdateEnabled,
          forceUpdateMessage: _forceUpdateController.text,
          signupEnabled: _signupEnabled,
          googleLoginEnabled: _googleLoginEnabled,
          phoneLoginEnabled: _phoneLoginEnabled,
          defaultPlaybackMode: widget.config.defaultPlaybackMode,
          contactEmail: _contactController.text,
          supportWhatsapp: _whatsappController.text,
          paymentWhatsappLink: _paymentWhatsappController.text,
          privacyPolicyUrl: _privacyController.text,
          termsUrl: _termsController.text,
          defaultJellyfinServerUrl: widget.config.defaultJellyfinServerUrl,
          jellyfinEnabled: widget.config.jellyfinEnabled,
          jellyfinNativeEnabled: widget.config.jellyfinNativeEnabled,
          jellyfinWebEnabled: widget.config.jellyfinWebEnabled,
          tailscaleRequiredMessage: widget.config.tailscaleRequiredMessage,
          jellyfinSetupGuide: widget.config.jellyfinSetupGuide,
        ),
      );
      if (!mounted) return;
      widget.onSaved();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('App config saved.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
