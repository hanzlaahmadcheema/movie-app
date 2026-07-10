import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../core/services/admin_repository.dart';
import '../../../widgets/state_views.dart';

class TvAdminPanelScreen extends StatefulWidget {
  const TvAdminPanelScreen({super.key});

  @override
  State<TvAdminPanelScreen> createState() => _TvAdminPanelScreenState();
}

class _TvAdminPanelScreenState extends State<TvAdminPanelScreen> {
  late Future<AdminDashboardStats> _statsFuture = AdminRepository.instance.loadDashboardStats();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<AdminDashboardStats>(
        future: _statsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return AppErrorView(
              title: 'Error',
              message: 'Failed to load stats',
              onRetry: () => setState(() => _statsFuture = AdminRepository.instance.loadDashboardStats()),
            );
          }
          final stats = snapshot.data;
          
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Admin Dashboard', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 32),
                if (stats != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _TvStatCard(label: 'Users', value: '${stats.totalUsers}', icon: Icons.people),
                      _TvStatCard(label: 'Continue Watching', value: '${stats.continueWatchingRecords}', icon: Icons.play_circle),
                      _TvStatCard(label: 'Playback Errors', value: '${stats.playbackErrors}', icon: Icons.error),
                    ],
                  ),
                const SizedBox(height: 48),
                const Text('Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white70)),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 3,
                    children: [
                      _TvAdminButton(label: 'Featured Content', icon: Icons.star, onTap: () => Navigator.pushNamed(context, AppRoutes.adminFeatured)),
                      _TvAdminButton(label: 'Banners', icon: Icons.view_carousel, onTap: () => Navigator.pushNamed(context, AppRoutes.adminBanners)),
                      _TvAdminButton(label: 'Notices', icon: Icons.announcement, onTap: () => Navigator.pushNamed(context, AppRoutes.adminNotices)),
                      _TvAdminButton(label: 'Providers', icon: Icons.connected_tv, onTap: () => Navigator.pushNamed(context, AppRoutes.adminProviders)),
                      _TvAdminButton(label: 'Jellyfin Config', icon: Icons.dns, onTap: () => Navigator.pushNamed(context, AppRoutes.adminJellyfin)),
                      _TvAdminButton(label: 'Users', icon: Icons.people, onTap: () => Navigator.pushNamed(context, AppRoutes.adminUsers)),
                      _TvAdminButton(label: 'Content Requests', icon: Icons.queue, onTap: () => Navigator.pushNamed(context, AppRoutes.adminRequests)),
                      _TvAdminButton(label: 'Playback Logs', icon: Icons.receipt_long, onTap: () => Navigator.pushNamed(context, AppRoutes.adminPlaybackLogs)),
                      _TvAdminButton(label: 'App Config', icon: Icons.settings_applications, onTap: () => Navigator.pushNamed(context, AppRoutes.adminAppConfig)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TvStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _TvStatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.white54),
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 20, color: Colors.white70)),
        ],
      ),
    );
  }
}

class _TvAdminButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _TvAdminButton({required this.label, required this.icon, required this.onTap});

  @override
  State<_TvAdminButton> createState() => _TvAdminButtonState();
}

class _TvAdminButtonState extends State<_TvAdminButton> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => _isFocused = focused),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : Colors.white12,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 10, spreadRadius: 2)] : [],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: _isFocused ? Colors.black : Colors.white, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _isFocused ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
