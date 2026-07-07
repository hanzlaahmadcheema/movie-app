import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../core/constants/app_assets.dart';
import '../core/navigation/app_nav_item.dart';
import '../core/responsive/adaptive_container.dart';
import '../core/responsive/responsive_builder.dart';
import '../core/services/auth_service.dart';
import 'app_chrome.dart';
import 'network_art.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.body,
    this.enablePullToRefresh = true,
    super.key,
  });

  final Widget body;
  final bool enablePullToRefresh;

  @override
  Widget build(BuildContext context) {
    final shellBody = enablePullToRefresh ? _PullToReload(body: body) : body;
    return ResponsiveBuilder(
      mobile: (_, _) => MobileShell(body: shellBody),
      tablet: (_, _) => TabletShell(body: shellBody),
      desktop: (_, _) => DesktopShell(body: shellBody),
    );
  }
}

class _PullToReload extends StatelessWidget {
  const _PullToReload({required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: 80,
      onRefresh: () => _reloadCurrentRoute(context),
      child: body,
    );
  }

  Future<void> _reloadCurrentRoute(BuildContext context) async {
    final settings = ModalRoute.of(context)?.settings;
    final routeName = settings?.name;
    if (routeName == null) {
      return;
    }

    await Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: settings?.arguments,
    );
  }
}

class MobileShell extends StatelessWidget {
  const MobileShell({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      body: body,
    );
  }
}

class TabletShell extends StatelessWidget {
  const TabletShell({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _DesktopNavigation(compact: true),
          Expanded(child: body),
        ],
      ),
    );
  }
}

class DesktopShell extends StatelessWidget {
  const DesktopShell({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _DesktopNavigation(),
          Expanded(child: body),
        ],
      ),
    );
  }
}

class _DesktopNavigation extends StatelessWidget {
  const _DesktopNavigation({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final desktopItems = appNavItems.where(
      (item) => item.route != AppRoutes.search,
    );
    final visibleItems = compact ? desktopItems.take(3) : desktopItems;

    return Material(
      color: AppColors.appBar,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.25),
      child: SafeArea(
        bottom: false,
        child: AdaptiveContainer(
          child: SizedBox(
            height: compact ? 68 : 76,
            child: Row(
              children: [
                _LogoButton(compact: compact),
                SizedBox(width: compact ? 20 : 40),
                for (final item in visibleItems)
                  _DesktopNavItem(
                    item: item,
                    active: currentRoute == item.route,
                    compact: compact,
                  ),
                if (compact)
                  PopupMenuButton<String>(
                    tooltip: 'More navigation',
                    onSelected: (route) =>
                        Navigator.pushReplacementNamed(context, route),
                    itemBuilder: (_) => [
                      for (final item in desktopItems.skip(3))
                        PopupMenuItem(
                          value: item.route,
                          child: Row(
                            children: [
                              Icon(item.icon, size: 18),
                              const SizedBox(width: 10),
                              Text(item.label),
                            ],
                          ),
                        ),
                    ],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Text('More'),
                          SizedBox(width: 4),
                          Icon(Icons.expand_more, size: 18),
                        ],
                      ),
                    ),
                  ),
                const Spacer(),
                if (!compact) const _DesktopSearchField(),
                if (!compact) const SizedBox(width: 12),
                const _AccountButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoButton extends StatelessWidget {
  const _LogoButton({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
        borderRadius: BorderRadius.circular(28),
        child: Row(
          children: [
            const NetworkArt(
              url: AppAssets.logo,
              width: 44,
              height: 44,
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            if (!compact) ...[
              const SizedBox(width: 10),
              const Text(
                'MovieApp',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DesktopNavItem extends StatelessWidget {
  const _DesktopNavItem({
    required this.item,
    required this.active,
    required this.compact,
  });

  final AppNavItem item;
  final bool active;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : Colors.white70;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          if (!active) {
            Navigator.pushReplacementNamed(context, item.route);
          }
        },
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 14,
            vertical: 10,
          ),
          child: Text(
            item.label,
            style: AppTextStyles.normal.copyWith(
              color: color,
              fontSize: compact ? 12 : 13,
              fontWeight: active ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopSearchField extends StatefulWidget {
  const _DesktopSearchField();

  @override
  State<_DesktopSearchField> createState() => _DesktopSearchFieldState();
}

class _DesktopSearchFieldState extends State<_DesktopSearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      height: 42,
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        onSubmitted: _search,
        style: AppTextStyles.normal.copyWith(fontSize: 13),
        decoration: InputDecoration(
          hintText: 'Search movies and series',
          prefixIcon: const Icon(Icons.search, size: 18),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _search(String value) {
    Navigator.pushNamed(context, AppRoutes.search, arguments: value.trim());
  }
}

class _AccountButton extends StatelessWidget {
  const _AccountButton();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        final user = snapshot.data;
        final signedIn = user != null;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: TextButton.icon(
            onPressed: () => Navigator.pushNamed(
              context,
              signedIn ? AppRoutes.profile : AppRoutes.login,
            ),
            icon: const Icon(Icons.account_circle_outlined, size: 20),
            label: Text(signedIn ? 'Profile' : 'Login'),
          ),
        );
      },
    );
  }
}
