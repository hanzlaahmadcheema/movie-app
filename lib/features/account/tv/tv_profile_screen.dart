import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../app/app_routes.dart';
import '../../../app/app_theme.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/auth/current_user_role.dart';
import '../../../widgets/state_views.dart';

class TvProfileScreen extends StatefulWidget {
  const TvProfileScreen({super.key});

  @override
  State<TvProfileScreen> createState() => _TvProfileScreenState();
}

class _TvProfileScreenState extends State<TvProfileScreen> {
  Future<void> _logout() async {
    await AuthService.instance.signOut();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<User?>(
        stream: AuthService.instance.userChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          if (user == null) {
            return const AppErrorView(title: 'Not signed in', message: 'Please sign in.');
          }

          return StreamBuilder<CurrentUserRole>(
            stream: CurrentUserRole.streamForUser(user),
            builder: (context, roleSnapshot) {
              final role = roleSnapshot.data;
              final isAdmin = role?.isAdmin ?? false;

              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: AppColors.surfaceAlt,
                            backgroundImage: user.photoURL == null ? null : NetworkImage(user.photoURL!),
                            child: user.photoURL == null ? const Icon(Icons.account_circle, size: 100, color: Colors.white) : null,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            user.displayName ?? 'TV User',
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.email ?? user.phoneNumber ?? 'Unknown',
                            style: const TextStyle(fontSize: 20, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: SizedBox(
                          width: 400,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              _TvMenuButton(
                                label: 'Continue Watching',
                                icon: Icons.play_arrow,
                                onTap: () => Navigator.pushNamed(context, AppRoutes.continueWatching),
                              ),
                              _TvMenuButton(
                                label: 'Watchlist',
                                icon: Icons.bookmark,
                                onTap: () => Navigator.pushNamed(context, AppRoutes.watchlist),
                              ),
                              _TvMenuButton(
                                label: 'Jellyfin Settings',
                                icon: Icons.dns,
                                onTap: () => Navigator.pushNamed(context, AppRoutes.jellyfinSettings),
                              ),
                              _TvMenuButton(
                                label: 'App Settings',
                                icon: Icons.settings,
                                onTap: () {
                                  // Navigate to settings
                                },
                              ),
                              _TvMenuButton(
                                label: 'Support',
                                icon: Icons.help,
                                onTap: () => Navigator.pushNamed(context, AppRoutes.supportRequest),
                              ),
                              if (isAdmin)
                                _TvMenuButton(
                                  label: 'Admin Panel',
                                  icon: Icons.admin_panel_settings,
                                  onTap: () => Navigator.pushNamed(context, AppRoutes.admin),
                                  isPrimary: true,
                                ),
                              _TvMenuButton(
                                label: 'Logout',
                                icon: Icons.logout,
                                onTap: _logout,
                                isDestructive: true,
                              ),
                            ],
                          ),
                        ),
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

class _TvMenuButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isDestructive;

  const _TvMenuButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
    this.isDestructive = false,
  });

  @override
  State<_TvMenuButton> createState() => _TvMenuButtonState();
}

class _TvMenuButtonState extends State<_TvMenuButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: _isFocused
                ? Colors.white
                : (widget.isPrimary
                    ? AppColors.primary
                    : (widget.isDestructive ? Colors.red.withOpacity(0.2) : Colors.white12)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)] : [],
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: _isFocused
                    ? Colors.black
                    : (widget.isDestructive ? Colors.red : Colors.white),
                size: 32,
              ),
              const SizedBox(width: 24),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _isFocused
                      ? Colors.black
                      : (widget.isDestructive ? Colors.red : Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
