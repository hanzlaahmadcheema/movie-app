import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../../core/jellyfin/jellyfin_client.dart';
import '../../core/jellyfin/jellyfin_config.dart';
import '../../core/jellyfin/jellyfin_repository.dart';
import '../../widgets/state_views.dart';

class JellyfinLoginScreen extends StatefulWidget {
  const JellyfinLoginScreen({super.key, this.repository});

  final JellyfinRepository? repository;

  @override
  State<JellyfinLoginScreen> createState() => _JellyfinLoginScreenState();
}

class _JellyfinLoginScreenState extends State<JellyfinLoginScreen> {
  late final JellyfinRepository _repository =
      widget.repository ?? JellyfinRepository.local();
  final _formKey = GlobalKey<FormState>();
  final _serverController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberSession = true;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _serverController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final config = await _repository.loadConfig();
    if (!mounted) return;
    setState(() {
      _serverController.text = config.serverUrl;
      _usernameController.text = config.userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        title: const Text('Login to Jellyfin'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use your Jellyfin account once, then the app will reuse the saved access token for matching and playback.',
                  style: AppTextStyles.normal,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _serverController,
                  decoration: const InputDecoration(
                    labelText: 'Server URL',
                    hintText: kJellyfinServerUrlHint,
                  ),
                  keyboardType: TextInputType.url,
                  validator: (_) => JellyfinConfig(
                    serverUrl: _serverController.text.trim().isEmpty
                        ? kDefaultJellyfinServerUrl
                        : _serverController.text.trim(),
                  ).validate(),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) => value?.trim().isEmpty == true
                      ? 'Enter your Jellyfin username.'
                      : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value?.isEmpty == true
                      ? 'Enter your Jellyfin password.'
                      : null,
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: _rememberSession,
                  onChanged: (value) {
                    setState(() => _rememberSession = value ?? true);
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Remember session'),
                  subtitle: const Text(
                    'Saved locally on this device for later playback.',
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  AppErrorView(
                    title: 'Jellyfin login failed',
                    message: _error!,
                    onRetry: _submit,
                  ),
                ],
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: _submitting ? null : _submit,
                      icon: const Icon(Icons.login),
                      label: Text(_submitting ? 'Logging in...' : 'Login'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _submitting
                          ? null
                          : () => Navigator.of(context).pop(false),
                      icon: const Icon(Icons.close),
                      label: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    final serverUrl = _serverController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if (!_rememberSession) {
      _passwordController.clear();
      setState(() {
        _submitting = false;
        _error =
            'This build currently requires Remember session to stay enabled.';
      });
      return;
    }
    try {
      await _repository.login(
        serverUrl: serverUrl,
        username: username,
        password: password,
        enabled: true,
      );
      _passwordController.clear();
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on JellyfinException catch (error) {
      _passwordController.clear();
      if (!mounted) return;
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}
