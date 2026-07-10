import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../app/app_theme.dart';

class TvSettingsScreen extends StatelessWidget {
  const TvSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('App Settings', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _TvSettingsButton(
                    label: 'Theme (Dark)',
                    icon: Icons.color_lens,
                    onTap: () {
                      // Toggle theme logic
                    },
                  ),
                  _TvSettingsButton(
                    label: 'Playback Settings',
                    icon: Icons.play_circle_fill,
                    onTap: () {
                      // Playback logic
                    },
                  ),
                  _TvSettingsButton(
                    label: 'Clear Image Cache',
                    icon: Icons.image,
                    onTap: () {
                      // Cache logic
                    },
                  ),
                  _TvSettingsButton(
                    label: 'Privacy Policy',
                    icon: Icons.privacy_tip,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.privacy),
                  ),
                  _TvSettingsButton(
                    label: 'Terms of Service',
                    icon: Icons.description,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.terms),
                  ),
                  _TvSettingsButton(
                    label: 'Contact Us',
                    icon: Icons.contact_mail,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.contact),
                  ),
                  _TvSettingsButton(
                    label: 'About',
                    icon: Icons.info,
                    onTap: () {
                      // About logic
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TvSettingsButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _TvSettingsButton({required this.label, required this.icon, required this.onTap});

  @override
  State<_TvSettingsButton> createState() => _TvSettingsButtonState();
}

class _TvSettingsButtonState extends State<_TvSettingsButton> {
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
            color: _isFocused ? Colors.white : Colors.white12,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isFocused ? [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)] : [],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: _isFocused ? Colors.black : Colors.white, size: 32),
              const SizedBox(width: 24),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _isFocused ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
