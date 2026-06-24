import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/jellyfin/jellyfin_client.dart';
import '../../core/jellyfin/jellyfin_config.dart';
import '../../core/jellyfin/jellyfin_repository.dart';
import '../../core/services/admin_repository.dart';
import '../../widgets/app_chrome.dart';

class JellyfinSettingsScreen extends StatefulWidget {
  const JellyfinSettingsScreen({super.key, this.repository});

  final JellyfinRepository? repository;

  @override
  State<JellyfinSettingsScreen> createState() => _JellyfinSettingsScreenState();
}

class _JellyfinSettingsScreenState extends State<JellyfinSettingsScreen> {
  late final JellyfinRepository _repository =
      widget.repository ?? JellyfinRepository.local();
  final _formKey = GlobalKey<FormState>();
  final _serverController = TextEditingController();
  bool _enabled = false;
  JellyfinPlaybackMode _playbackMode = JellyfinPlaybackMode.auto;
  bool _loading = true;
  bool _saving = false;
  bool _testing = false;
  bool _syncing = false;
  String _userName = '';
  String? _message;
  DateTime? _lastSyncAt;
  String _defaultServerUrl = kDefaultJellyfinServerUrl;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _serverController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final remoteConfig = await AdminRepository.instance.loadPublicAppConfig();
      final remoteDefault = remoteConfig.defaultJellyfinServerUrl.trim().isEmpty
          ? kDefaultJellyfinServerUrl
          : remoteConfig.defaultJellyfinServerUrl.trim();
      final config = await _repository.validateSavedSession();
      if (!mounted) return;
      _defaultServerUrl = remoteDefault;
      _applyConfig(_resolvedServerConfig(config, remoteDefault));
    } on JellyfinException catch (error) {
      final remoteConfig = await AdminRepository.instance.loadPublicAppConfig();
      final remoteDefault = remoteConfig.defaultJellyfinServerUrl.trim().isEmpty
          ? kDefaultJellyfinServerUrl
          : remoteConfig.defaultJellyfinServerUrl.trim();
      final config = await _repository.loadConfig();
      if (!mounted) return;
      _defaultServerUrl = remoteDefault;
      _applyConfig(
        _resolvedServerConfig(config, remoteDefault),
        message: error.message,
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  JellyfinConfig _resolvedServerConfig(
    JellyfinConfig config,
    String defaultServerUrl,
  ) {
    if (config.serverUrl.trim().isNotEmpty &&
        config.serverUrl.trim() != kDefaultJellyfinServerUrl) {
      return config;
    }
    return config.copyWith(serverUrl: defaultServerUrl);
  }

  void _applyConfig(JellyfinConfig config, {String? message}) {
    setState(() {
      _enabled = config.enabled;
      _serverController.text = config.serverUrl;
      _playbackMode = config.playbackMode;
      _userName = config.userName;
      _lastSyncAt = config.lastSyncAt;
      _message = message;
    });
  }

  JellyfinConfig _configFromForm({JellyfinConfig? current}) {
    final base = current ?? JellyfinConfig.empty;
    return base.copyWith(
      enabled: _enabled,
      serverUrl: _serverController.text.trim().isEmpty
          ? _defaultServerUrl
          : _serverController.text.trim(),
      playbackMode: _playbackMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const MovieAppBar(dark: true),
          Padding(
            padding: const EdgeInsets.fromLTRB(17, 43, 17, 18),
            child: Text(
              'Jellyfin Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          value: _enabled,
                          onChanged: (value) =>
                              setState(() => _enabled = value),
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Enable Jellyfin'),
                          subtitle: const Text(
                            'Use your private Tailscale Jellyfin server before public providers.',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _serverController,
                          decoration: InputDecoration(
                            labelText: 'Server URL',
                            hintText: _defaultServerUrl.trim().isEmpty
                                ? kJellyfinServerUrlHint
                                : _defaultServerUrl,
                          ),
                          keyboardType: TextInputType.url,
                          validator: (_) => _validateServerUrl(),
                        ),
                        const SizedBox(height: 18),
                        DropdownButtonFormField<JellyfinPlaybackMode>(
                          initialValue: _playbackMode,
                          decoration: const InputDecoration(
                            labelText: 'Playback Mode',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: JellyfinPlaybackMode.auto,
                              child: Text('Auto'),
                            ),
                            DropdownMenuItem(
                              value: JellyfinPlaybackMode.native,
                              child: Text('Native Flutter Player'),
                            ),
                            DropdownMenuItem(
                              value: JellyfinPlaybackMode.web,
                              child: Text('Jellyfin Web Player'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() => _playbackMode = value);
                          },
                        ),
                        const SizedBox(height: 18),
                        _InfoBox(
                          icon: _userName.isEmpty
                              ? Icons.lock_outline
                              : Icons.verified_user_outlined,
                          text: _userName.isEmpty
                              ? 'Login status: Not logged in'
                              : 'Login status: Logged in as $_userName',
                        ),
                        if (_lastSyncAt != null) ...[
                          const SizedBox(height: 12),
                          _InfoBox(
                            icon: Icons.sync,
                            text:
                                'Last Jellyfin sync: ${_lastSyncAt!.toLocal().toString().split('.').first}',
                          ),
                        ],
                        if (_message != null) ...[
                          const SizedBox(height: 12),
                          _InfoBox(icon: Icons.info_outline, text: _message!),
                        ],
                        const SizedBox(height: 22),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            FilledButton.icon(
                              onPressed: _testing ? null : _testServer,
                              icon: const Icon(Icons.wifi_tethering),
                              label: Text(
                                _testing ? 'Testing...' : 'Test Server',
                              ),
                            ),
                            FilledButton.icon(
                              onPressed: _openLogin,
                              icon: const Icon(Icons.login),
                              label: Text(
                                _userName.isEmpty
                                    ? 'Login to Jellyfin'
                                    : 'Login Again',
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: _userName.isEmpty ? null : _logout,
                              icon: const Icon(Icons.logout),
                              label: const Text('Logout'),
                            ),
                            OutlinedButton.icon(
                              onPressed: _userName.isEmpty || _syncing
                                  ? null
                                  : _resyncLibrary,
                              icon: const Icon(Icons.sync_outlined),
                              label: Text(
                                _syncing
                                    ? 'Syncing...'
                                    : 'Resync Jellyfin Library',
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: _saving ? null : _saveSettings,
                              icon: const Icon(Icons.save_outlined),
                              label: Text(
                                _saving ? 'Saving...' : 'Save Settings',
                              ),
                            ),
                            TextButton.icon(
                              onPressed: _clearAll,
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('Clear Jellyfin Settings'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String? _validateServerUrl() {
    if (!_enabled && _serverController.text.trim().isEmpty) {
      return null;
    }
    return _configFromForm().validate();
  }

  Future<void> _testServer() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _testing = true;
      _message = null;
    });
    try {
      final config = _configFromForm();
      final result = await _repository.testConnection(config);
      if (!mounted) return;
      setState(() {
        _message =
            'Connected to ${result.serverName} (${result.version}). Login to start syncing your Jellyfin library.';
      });
    } on JellyfinException catch (error) {
      if (!mounted) return;
      setState(() => _message = error.message);
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _message = null;
    });
    final current = await _repository.loadConfig();
    final next = _configFromForm(current: current);
    try {
      final serverChanged =
          current.serverUrl.trim() != next.serverUrl.trim() &&
          current.serverUrl.trim().isNotEmpty;
      if (serverChanged && current.hasToken) {
        await _repository.clearSession(serverUrl: next.serverUrl);
        await _repository.saveConfig(
          next.withoutSession().copyWith(
            enabled: next.enabled,
            serverUrl: next.serverUrl,
            playbackMode: next.playbackMode,
            displayName: current.displayName,
            deviceId: current.deviceId,
          ),
        );
        if (!mounted) return;
        _applyConfig(
          next.withoutSession().copyWith(
            enabled: next.enabled,
            serverUrl: next.serverUrl,
            playbackMode: next.playbackMode,
            displayName: current.displayName,
            deviceId: current.deviceId,
          ),
          message:
              'Jellyfin server changed. Previous session was cleared, please log in again.',
        );
      } else {
        await _repository.saveConfig(next);
        if (!mounted) return;
        _applyConfig(next, message: 'Jellyfin settings saved locally.');
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _openLogin() async {
    if (!_formKey.currentState!.validate()) return;
    await _saveSettings();
    if (!mounted) return;
    final didLogin = await Navigator.pushNamed(
      context,
      AppRoutes.jellyfinLogin,
    );
    if (didLogin == true && mounted) {
      await _load();
    }
  }

  Future<void> _logout() async {
    final current = await _repository.loadConfig();
    await _repository.clearSession(serverUrl: current.serverUrl);
    if (!mounted) return;
    await _load();
    if (!mounted) return;
    setState(() => _message = 'Jellyfin session cleared. Please log in again.');
  }

  Future<void> _clearAll() async {
    await _repository.clearConfig();
    if (!mounted) return;
    setState(() {
      _enabled = false;
      _serverController.text = '';
      _playbackMode = JellyfinPlaybackMode.auto;
      _userName = '';
      _lastSyncAt = null;
      _message = 'Jellyfin settings cleared.';
    });
  }

  Future<void> _resyncLibrary() async {
    setState(() {
      _syncing = true;
      _message = null;
    });
    try {
      final config = await _repository.resyncLibrary();
      if (!mounted) return;
      _applyConfig(
        config,
        message: 'Jellyfin library sync completed for ${config.userName}.',
      );
    } on JellyfinException catch (error) {
      if (!mounted) return;
      setState(() => _message = error.message);
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.normal)),
        ],
      ),
    );
  }
}
