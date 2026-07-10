import 'package:flutter/material.dart';

import '../../../app/app_theme.dart';
import '../../../core/jellyfin/jellyfin_config.dart';
import '../../../core/jellyfin/jellyfin_repository.dart';
import '../../../core/services/admin_repository.dart';
import '../../../widgets/state_views.dart';

class TvJellyfinSettingsScreen extends StatefulWidget {
  const TvJellyfinSettingsScreen({super.key});

  @override
  State<TvJellyfinSettingsScreen> createState() => _TvJellyfinSettingsScreenState();
}

class _TvJellyfinSettingsScreenState extends State<TvJellyfinSettingsScreen> {
  final JellyfinRepository _repository = JellyfinRepository.local();
  bool _loading = true;
  String _defaultServerUrl = kDefaultJellyfinServerUrl;
  
  bool _enabled = false;
  JellyfinPlaybackMode _playbackMode = JellyfinPlaybackMode.auto;
  String _serverUrl = '';
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final remoteConfig = await AdminRepository.instance.loadPublicAppConfig();
      _defaultServerUrl = remoteConfig.defaultJellyfinServerUrl.trim().isEmpty
          ? kDefaultJellyfinServerUrl
          : remoteConfig.defaultJellyfinServerUrl.trim();
      
      final config = await _repository.loadConfig();
      if (!mounted) return;
      _applyConfig(config.serverUrl.isEmpty ? config.copyWith(serverUrl: _defaultServerUrl) : config);
    } catch (e) {
      if (!mounted) return;
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _applyConfig(JellyfinConfig config) {
    setState(() {
      _enabled = config.enabled;
      _serverUrl = config.serverUrl;
      _playbackMode = config.playbackMode;
      _userName = config.userName;
    });
  }

  Future<void> _toggleEnabled() async {
    final config = await _repository.loadConfig();
    await _repository.saveConfig(config.copyWith(enabled: !_enabled));
    setState(() => _enabled = !_enabled);
  }

  Future<void> _togglePlaybackMode() async {
    final nextMode = _playbackMode == JellyfinPlaybackMode.auto
        ? JellyfinPlaybackMode.native
        : (_playbackMode == JellyfinPlaybackMode.native ? JellyfinPlaybackMode.web : JellyfinPlaybackMode.auto);
    
    final config = await _repository.loadConfig();
    await _repository.saveConfig(config.copyWith(playbackMode: nextMode));
    setState(() => _playbackMode = nextMode);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Jellyfin Settings', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _TvSettingsButton(
                    label: 'Enable Jellyfin',
                    value: _enabled ? 'On' : 'Off',
                    icon: Icons.power_settings_new,
                    onTap: _toggleEnabled,
                  ),
                  _TvSettingsButton(
                    label: 'Server URL',
                    value: _serverUrl.isEmpty ? 'Not set' : _serverUrl,
                    icon: Icons.link,
                    onTap: () {}, // Server URL input logic could open keyboard
                  ),
                  _TvSettingsButton(
                    label: 'Playback Mode',
                    value: _playbackMode.name.toUpperCase(),
                    icon: Icons.play_arrow,
                    onTap: _togglePlaybackMode,
                  ),
                  _TvSettingsButton(
                    label: 'Account',
                    value: _userName.isEmpty ? 'Not logged in' : _userName,
                    icon: Icons.person,
                    onTap: () {}, // Login flow
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
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const _TvSettingsButton({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

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
              Expanded(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _isFocused ? Colors.black : Colors.white,
                  ),
                ),
              ),
              Text(
                widget.value,
                style: TextStyle(
                  fontSize: 20,
                  color: _isFocused ? Colors.black54 : Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
