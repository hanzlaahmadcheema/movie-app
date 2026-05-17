import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../core/constants/app_assets.dart';
import '../core/navigation/content_navigation.dart';
import 'network_art.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({this.dark = false, super.key});

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dark ? 55 : 60,
      padding: EdgeInsets.only(top: dark ? 24 : 28, left: 18, right: 18),
      color: dark ? AppColors.appBar : Colors.transparent,
      child: Row(
        children: [
          IconButton(
            onPressed: () => _showMenu(context),
            icon: const Icon(Icons.menu, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 28, height: 28),
          ),
          const SizedBox(width: 8),
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
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
            icon: const Icon(Icons.account_circle_outlined, size: 19),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 28, height: 28),
          ),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MenuTile(label: 'Home', route: AppRoutes.home),
            _MenuTile(label: 'Movies', route: AppRoutes.movies),
            _MenuTile(label: 'TV Series', route: AppRoutes.series),
            _MenuTile(label: 'Search', route: AppRoutes.search),
            _MenuTile(label: 'Login', route: AppRoutes.login),
            _MenuTile(label: 'Register', route: AppRoutes.register),
            _MenuTile(label: 'Reset Password', route: AppRoutes.resetPassword),
            _MenuTile(label: 'Snackbar Demo', route: AppRoutes.snackbarStates),
          ],
        ),
      ),
    );
  }
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

class FooterDetails extends StatelessWidget {
  const FooterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(15, 22, 15, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF9D38FF)),
            ),
            child: const Center(
              child: Icon(
                Icons.video_camera_back_outlined,
                color: Color(0xFF9D38FF),
                size: 34,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text('About Us', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(
            'MovieApp is a TMDB-powered catalog for movies, series, cast, genres, countries, and production browsing.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Text(
            'This product uses the TMDB API but is not endorsed or certified by TMDB.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Text(
            'Movie metadata and images are provided by TMDB.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact: support@1hd.example')),
                ),
                child: Text(
                  'Contact',
                  style: AppTextStyles.small.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 42),
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Terms page is not wired yet')),
                ),
                child: Text(
                  'Terms of Service',
                  style: AppTextStyles.small.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text('Links', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 46,
            runSpacing: 10,
            children: [
              _FooterColumn(items: ['Movies', 'TV Series', 'Top IMDB']),
              _FooterColumn(items: ['Action', 'Comedy', 'Drama']),
              _FooterColumn(items: ['Fantasy', 'Horror', 'Mystery']),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => openSearchResult(context, item),
                child: Text(item, style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
          )
          .toList(),
    );
  }
}
