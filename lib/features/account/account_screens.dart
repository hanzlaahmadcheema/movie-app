import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/user_activity_repository.dart';
import '../../core/responsive/adaptive_container.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/continue_watching.dart';
import '../../widgets/firebase_posters.dart';
import '../../widgets/state_views.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return _AccountScaffold(
      title: 'Profile',
      child: StreamBuilder<User?>(
        stream: AuthService.instance.userChanges,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return AppErrorView(
              title: 'Could not load profile',
              message: userMessageForError(snapshot.error),
              onRetry: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.profile),
            );
          }
          final user = snapshot.data;
          if (user == null) {
            return const _SignedOutMessage();
          }

          final providers = user.providerData
              .map((provider) => provider.providerId)
              .where((provider) => provider.isNotEmpty)
              .join(', ');
          final hasPasswordProvider = user.providerData.any(
            (provider) => provider.providerId == EmailAuthProvider.PROVIDER_ID,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: AppColors.surfaceAlt,
                    backgroundImage: user.photoURL == null
                        ? null
                        : NetworkImage(user.photoURL!),
                    child: user.photoURL == null
                        ? const Icon(Icons.account_circle, size: 48)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName ?? 'MovieApp User',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          user.email ?? user.phoneNumber ?? user.uid,
                          style: AppTextStyles.normal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _ProfileRow(label: 'User ID', value: user.uid),
              _ProfileRow(
                label: 'Email',
                value: user.email?.isNotEmpty == true ? user.email! : 'N/A',
              ),
              _ProfileRow(
                label: 'Phone',
                value: user.phoneNumber?.isNotEmpty == true
                    ? user.phoneNumber!
                    : 'N/A',
              ),
              _ProfileRow(
                label: 'Providers',
                value: providers.isEmpty ? 'N/A' : providers,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed: () => _editProfile(user),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Edit Profile'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _changePassword(user),
                    icon: const Icon(Icons.lock_reset),
                    label: Text(
                      hasPasswordProvider ? 'Change Password' : 'Set Password',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              StreamBuilder<List<UserContentRecord>>(
                stream: UserActivityRepository.instance.watchlistStream(user),
                builder: (context, watchlistSnapshot) {
                  if (watchlistSnapshot.hasError) {
                    return AppErrorView(
                      title: 'Could not load watchlist',
                      message: userMessageForError(watchlistSnapshot.error),
                    );
                  }
                  if (!watchlistSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final items = watchlistSnapshot.data!
                      .map((record) => record.item)
                      .toList();
                  if (items.isEmpty) {
                    return _EmptyMessage(
                      icon: Icons.bookmark_border,
                      message: 'Your watchlist is empty',
                      action: OutlinedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.movies),
                        child: const Text('Browse Movies'),
                      ),
                    );
                  }
                  return FirebaseHorizontalPosterSection(
                    title: 'Your Watchlist',
                    items: items,
                    itemCount: items.length,
                    onMore: () =>
                        Navigator.pushNamed(context, AppRoutes.watchlist),
                  );
                },
              ),
              const SizedBox(height: 28),
              StreamBuilder<List<UserContentRecord>>(
                stream: UserActivityRepository.instance.watchedStream(user),
                builder: (context, watchedSnapshot) {
                  if (watchedSnapshot.hasError) {
                    return AppErrorView(
                      title: 'Could not load watched titles',
                      message: userMessageForError(watchedSnapshot.error),
                    );
                  }
                  if (!watchedSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final items = watchedSnapshot.data!
                      .map((record) => record.item)
                      .toList();
                  if (items.isEmpty) {
                    return const _EmptyMessage(
                      icon: Icons.check_circle_outline,
                      message: 'No watched titles yet',
                    );
                  }
                  return FirebaseHorizontalPosterSection(
                    title: 'Watched',
                    items: items,
                    itemCount: items.length,
                    onMore: () =>
                        Navigator.pushNamed(context, AppRoutes.watched),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _editProfile(User user) async {
    final nameController = TextEditingController(text: user.displayName ?? '');
    final photoController = TextEditingController(text: user.photoURL ?? '');
    final values = await showDialog<_ProfileEditValues>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Display name'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: photoController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Profile image URL',
                  hintText: 'https://...',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isEmpty) return;
              Navigator.of(dialogContext).pop(
                _ProfileEditValues(
                  displayName: name,
                  photoUrl: photoController.text.trim(),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    nameController.dispose();
    photoController.dispose();
    if (values == null || !mounted) return;

    try {
      await AuthService.instance.updateProfile(
        displayName: values.displayName,
        photoUrl: values.photoUrl,
      );
      if (!mounted) return;
      _showSnackBarDeferred('Profile updated');
    } on FirebaseAuthException catch (error) {
      _showError(error.message ?? 'Could not update profile. Try again.');
    } catch (_) {
      _showError('Could not update profile. Try again.');
    }
  }

  Future<void> _changePassword(User user) async {
    final hasPasswordProvider = user.providerData.any(
      (provider) => provider.providerId == EmailAuthProvider.PROVIDER_ID,
    );
    if (user.email?.isNotEmpty != true) {
      _showError('Add an email address before setting a password.');
      return;
    }

    final currentController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();
    final values = await showDialog<_PasswordValues>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(hasPasswordProvider ? 'Change Password' : 'Set Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasPasswordProvider) ...[
                TextField(
                  controller: currentController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Current password',
                  ),
                ),
                const SizedBox(height: 14),
              ] else ...[
                const Text(
                  'This adds email and password sign-in to your existing account.',
                ),
                const SizedBox(height: 14),
              ],
              TextField(
                controller: newController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New password'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm new password',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final current = currentController.text;
              final password = newController.text;
              if (hasPasswordProvider && current.isEmpty) return;
              if (password.length < 6) return;
              if (password != confirmController.text) return;
              Navigator.of(dialogContext).pop(
                _PasswordValues(
                  currentPassword: current,
                  newPassword: password,
                ),
              );
            },
            child: Text(hasPasswordProvider ? 'Update' : 'Set Password'),
          ),
        ],
      ),
    );
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    if (values == null || !mounted) return;

    try {
      if (hasPasswordProvider) {
        await AuthService.instance.changePassword(
          currentPassword: values.currentPassword,
          newPassword: values.newPassword,
        );
      } else {
        await AuthService.instance.addPassword(newPassword: values.newPassword);
      }
      if (!mounted) return;
      _showSnackBarDeferred(
        hasPasswordProvider ? 'Password updated' : 'Password sign-in added',
      );
    } on FirebaseAuthException catch (error) {
      final message = switch (error.code) {
        'wrong-password' ||
        'invalid-credential' => 'Current password is incorrect.',
        'weak-password' =>
          'Use a stronger password with at least 6 characters.',
        'requires-recent-login' =>
          'Please sign in again before updating your password.',
        'email-already-in-use' || 'credential-already-in-use' =>
          'This email is already linked to another account.',
        'provider-already-linked' =>
          'Password sign-in is already linked to this account.',
        _ => error.message ?? 'Could not update password. Try again.',
      };
      _showError(message);
    } catch (_) {
      _showError('Could not update password. Try again.');
    }
  }


  Future<void> _logout() async {
    await AuthService.instance.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSnackBarDeferred(String message) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ScaffoldMessenger.maybeOf(
        context,
      )?.showSnackBar(SnackBar(content: Text(message)));
    });
  }
}

class _ProfileEditValues {
  const _ProfileEditValues({required this.displayName, required this.photoUrl});

  final String displayName;
  final String photoUrl;
}

class _PasswordValues {
  const _PasswordValues({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;
}

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AccountScaffold(
      title: 'Watchlist',
      child: StreamBuilder<User?>(
        stream: AuthService.instance.authStateChanges,
        builder: (context, authSnapshot) {
          if (authSnapshot.hasError) {
            return AppErrorView(
              title: 'Could not load account',
              message: userMessageForError(authSnapshot.error),
              onRetry: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.watchlist),
            );
          }
          final user = authSnapshot.data;
          if (user == null) {
            return const _SignedOutMessage();
          }

          return StreamBuilder<List<UserContentRecord>>(
            stream: UserActivityRepository.instance.watchlistStream(user),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppErrorView(
                  title: 'Could not load watchlist',
                  message: userMessageForError(snapshot.error),
                  onRetry: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.watchlist,
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final records = snapshot.data!;
              if (records.isEmpty) {
                return const _EmptyMessage(
                  icon: Icons.bookmark_border,
                  message: 'Your watchlist is empty',
                );
              }

              final items = records.map((record) => record.item).toList();
              return FirebasePosterGrid(items: items, itemCount: items.length);
            },
          );
        },
      ),
    );
  }
}

class WatchedScreen extends StatelessWidget {
  const WatchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AccountScaffold(
      title: 'Watched',
      child: StreamBuilder<User?>(
        stream: AuthService.instance.authStateChanges,
        builder: (context, authSnapshot) {
          final user = authSnapshot.data;
          if (user == null) {
            return const _SignedOutMessage();
          }

          return StreamBuilder<List<UserContentRecord>>(
            stream: UserActivityRepository.instance.watchedStream(user),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return AppErrorView(
                  title: 'Could not load watched titles',
                  message: userMessageForError(snapshot.error),
                  onRetry: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.watched,
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final records = snapshot.data!;
              if (records.isEmpty) {
                return const _EmptyMessage(
                  icon: Icons.check_circle_outline,
                  message: 'No watched titles yet',
                );
              }

              final items = records.map((record) => record.item).toList();
              return FirebasePosterGrid(items: items, itemCount: items.length);
            },
          );
        },
      ),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ContinueWatchingScreen();
  }
}

class ContinueWatchingScreen extends StatelessWidget {
  const ContinueWatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AccountScaffold(
      title: 'Continue Watching',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resume playback may start from the beginning. Exact resume time is unavailable for embedded players.',
            style: AppTextStyles.normal,
          ),
          SizedBox(height: 18),
          ContinueWatchingList(),
        ],
      ),
    );
  }
}

class _AccountScaffold extends StatelessWidget {
  const _AccountScaffold({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      body: AdaptiveContainer(
        maxWidth: 1100,
        padding: EdgeInsets.zero,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const MovieAppBar(dark: true),
            Padding(
              padding: const EdgeInsets.fromLTRB(17, 43, 17, 24),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.small),
          const SizedBox(height: 4),
          SelectableText(value, style: AppTextStyles.normal),
        ],
      ),
    );
  }
}

class _SignedOutMessage extends StatelessWidget {
  const _SignedOutMessage();

  @override
  Widget build(BuildContext context) {
    return _EmptyMessage(
      icon: Icons.lock_outline,
      message: 'Login to view this page',
      action: FilledButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
        child: const Text('Login'),
      ),
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  const _EmptyMessage({required this.icon, required this.message, this.action});

  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 42, color: AppColors.primary),
            const SizedBox(height: 14),
            Text(message, style: AppTextStyles.normal),
            if (action != null) ...[const SizedBox(height: 18), action!],
          ],
        ),
      ),
    );
  }
}
