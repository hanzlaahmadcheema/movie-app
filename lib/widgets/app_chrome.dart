import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../core/auth/current_user_role.dart';
import '../core/auth/user_role_service.dart';
import '../core/constants/app_assets.dart';
import '../core/navigation/navigation_state_repository.dart';
import '../core/services/auth_service.dart';
import 'network_art.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({this.dark = false, super.key});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(bottom: 10, left: 18, right: 18),
      alignment: Alignment.bottomCenter,
      color: dark ? AppColors.appBar : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.home),
            child: const NetworkArt(
              url: AppAssets.logo,
              width: 48,
              height: 48,
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.search),
            icon: const Icon(Icons.search, size: 19),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 28, height: 28),
          ),
          const SizedBox(width: 10),
          StreamBuilder(
            stream: AuthService.instance.authStateChanges,
            builder: (context, snapshot) {
              final user = snapshot.data;
              final signedIn = user != null;
              final photoUrl = user?.photoURL;
              return IconButton(
                onPressed: () => signedIn
                    ? Navigator.pushNamed(context, AppRoutes.profile)
                    : Navigator.pushNamed(context, AppRoutes.login),
                icon: signedIn && photoUrl != null && photoUrl.trim().isNotEmpty
                    ? CircleAvatar(
                        radius: 11,
                        backgroundColor: AppColors.surfaceAlt,
                        backgroundImage: NetworkImage(photoUrl),
                      )
                    : Icon(
                        signedIn
                            ? Icons.account_circle
                            : Icons.account_circle_outlined,
                        size: 19,
                        color: signedIn ? AppColors.primary : null,
                      ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 28,
                  height: 28,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MovieBottomNavigation extends StatefulWidget {
  const MovieBottomNavigation({super.key});

  @override
  State<MovieBottomNavigation> createState() => _MovieBottomNavigationState();
}

class _MovieBottomNavigationState extends State<MovieBottomNavigation> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      debugPrint('MovieBottomNavigation init');
    }
  }

  @override
  void dispose() {
    if (kDebugMode) {
      debugPrint('MovieBottomNavigation dispose');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name;
    if (kDebugMode) {
      debugPrint('MovieBottomNavigation build route=$route');
    }
    return SafeArea(
      top: false,
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: AppColors.appBar,
          border: Border(
            top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
        ),
        child: Row(
          children: [
            _BottomNavItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
              active: route == AppRoutes.home,
              onTap: () => _replaceWith(context, AppRoutes.home),
            ),
            _BottomNavItem(
              icon: Icons.movie_outlined,
              activeIcon: Icons.movie,
              label: 'Movies',
              active: route == AppRoutes.movies,
              onTap: () => _replaceWith(context, AppRoutes.movies),
            ),
            _BottomNavItem(
              icon: Icons.live_tv_outlined,
              activeIcon: Icons.live_tv,
              label: 'Series',
              active: route == AppRoutes.series,
              onTap: () => _replaceWith(context, AppRoutes.series),
            ),
            _BottomNavItem(
              icon: Icons.search,
              activeIcon: Icons.search,
              label: 'Search',
              active: route == AppRoutes.search,
              onTap: () => _replaceWith(context, AppRoutes.search),
            ),
            _BottomNavItem(
              icon: Icons.menu,
              activeIcon: Icons.menu,
              label: 'Menu',
              active: false,
              onTap: () => showAppMenu(context),
            ),
          ],
        ),
      ),
    );
  }

  void _replaceWith(BuildContext context, String route) {
    final current = ModalRoute.of(context)?.settings.name;
    if (current == route) return;
    unawaited(NavigationStateRepository.instance.saveBottomTab(route));
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : Colors.white70;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(active ? activeIcon : icon, size: 21, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.small.copyWith(
                  color: color,
                  fontSize: 10,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAppMenu(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.48),
    builder: (context) => StreamBuilder(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        final user = snapshot.data;
        final photoUrl = user?.photoURL;
        return StreamBuilder<CurrentUserRole>(
          stream: UserRoleService.instance.watchCurrentUserRole(),
          builder: (context, roleSnapshot) {
            final role =
                roleSnapshot.data ??
                (user == null
                    ? const CurrentUserRole.signedOut()
                    : CurrentUserRole.fromJson(user.uid, const {}));
            return FractionallySizedBox(
              heightFactor: 0.88,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.88),
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.14),
                        ),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            width: 42,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.32),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 18),
                              children: [
                                if (user != null)
                                  ListTile(
                                    leading:
                                        photoUrl != null &&
                                            photoUrl.trim().isNotEmpty
                                        ? CircleAvatar(
                                            radius: 22,
                                            backgroundColor:
                                                AppColors.surfaceAlt,
                                            backgroundImage: NetworkImage(
                                              photoUrl,
                                            ),
                                          )
                                        : const CircleAvatar(
                                            radius: 22,
                                            backgroundColor:
                                                AppColors.surfaceAlt,
                                            child: Icon(Icons.account_circle),
                                          ),
                                    title: Text(
                                      user.displayName ?? 'Signed in',
                                    ),
                                    subtitle: Text(
                                      user.email ??
                                          user.phoneNumber ??
                                          user.uid,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                if (user == null) ...[
                                  _MenuTile(
                                    label: 'Login',
                                    route: AppRoutes.login,
                                  ),
                                  _MenuTile(
                                    label: 'Register',
                                    route: AppRoutes.register,
                                  ),
                                  _MenuTile(
                                    label: 'Phone Login',
                                    route: AppRoutes.phoneAuth,
                                  ),
                                  _MenuTile(
                                    label: 'Reset Password',
                                    route: AppRoutes.resetPassword,
                                  ),
                                  _MenuTile(
                                    label: 'Contact',
                                    route: AppRoutes.contact,
                                  ),
                                  _MenuTile(
                                    label: 'Terms',
                                    route: AppRoutes.terms,
                                  ),
                                  _MenuTile(
                                    label: 'Privacy',
                                    route: AppRoutes.privacy,
                                  ),
                                ] else ...[
                                  _MenuTile(
                                    label: 'Profile',
                                    route: AppRoutes.profile,
                                  ),
                                  _MenuTile(
                                    label: 'Continue Watching',
                                    route: AppRoutes.continueWatching,
                                  ),
                                  _MenuTile(
                                    label: 'Watchlist',
                                    route: AppRoutes.watchlist,
                                  ),
                                  _MenuTile(
                                    label: 'Watched',
                                    route: AppRoutes.watched,
                                  ),
                                  _MenuTile(
                                    label: 'Request Content / Report Issue',
                                    route: AppRoutes.supportRequest,
                                  ),
                                  if (role.isAdmin)
                                    _MenuTile(
                                      label: 'Admin Panel',
                                      route: AppRoutes.admin,
                                    ),
                                  _MenuTile(
                                    label: 'Jellyfin Settings',
                                    route: AppRoutes.jellyfinSettings,
                                  ),
                                  _MenuTile(
                                    label: 'Contact',
                                    route: AppRoutes.contact,
                                  ),
                                  _MenuTile(
                                    label: 'Terms',
                                    route: AppRoutes.terms,
                                  ),
                                  _MenuTile(
                                    label: 'Privacy',
                                    route: AppRoutes.privacy,
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.logout),
                                    title: const Text('Logout'),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      await AuthService.instance.signOut();
                                      if (!context.mounted) return;
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.login,
                                        (route) => false,
                                      );
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
