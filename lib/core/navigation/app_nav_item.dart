import 'package:flutter/material.dart';

import '../../app/app_routes.dart';

class AppNavItem {
  const AppNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
}

const appNavItems = <AppNavItem>[
  AppNavItem(
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    route: AppRoutes.home,
  ),
  AppNavItem(
    label: 'Movies',
    icon: Icons.movie_outlined,
    activeIcon: Icons.movie,
    route: AppRoutes.movies,
  ),
  AppNavItem(
    label: 'TV Series',
    icon: Icons.live_tv_outlined,
    activeIcon: Icons.live_tv,
    route: AppRoutes.series,
  ),
  AppNavItem(
    label: 'Genres',
    icon: Icons.category_outlined,
    activeIcon: Icons.category,
    route: AppRoutes.genre,
  ),
  AppNavItem(
    label: 'Top IMDb',
    icon: Icons.star_outline,
    activeIcon: Icons.star,
    route: AppRoutes.topRated,
  ),
  AppNavItem(
    label: 'Search',
    icon: Icons.search,
    activeIcon: Icons.search,
    route: AppRoutes.search,
  ),
];
