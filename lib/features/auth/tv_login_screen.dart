import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/network_art.dart';

class TvLoginScreen extends StatefulWidget {
  const TvLoginScreen({super.key});

  @override
  State<TvLoginScreen> createState() => _TvLoginScreenState();
}

class _TvLoginScreenState extends State<TvLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _submitting = false;
  String? _errorMessage;
  int _focusedIndex = 0; // 0: Google, 1: Email, 2: Password, 3: Login Button

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitEmailPassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _errorMessage = null;
    });

    try {
      await AuthService.instance.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message ?? 'Authentication failed.');
    } catch (e) {
      setState(() => _errorMessage = 'An error occurred. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _submitGoogle() async {
    setState(() {
      _submitting = true;
      _errorMessage = null;
    });

    try {
      await AuthService.instance.signInWithGoogle();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = e.message ?? 'Google Sign-In failed.');
    } catch (e) {
      setState(() => _errorMessage = 'An error occurred. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Widget _buildTextField({
    required int index,
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required IconData icon,
  }) {
    final isFocused = _focusedIndex == index;
    return Focus(
      onFocusChange: (focused) {
        if (focused) setState(() => _focusedIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isFocused ? Colors.white : Colors.black45,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isFocused ? AppColors.primary : Colors.white24,
            width: isFocused ? 3 : 1,
          ),
          boxShadow: isFocused
              ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 16)]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, color: isFocused ? Colors.black : Colors.white70, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                style: TextStyle(
                  color: isFocused ? Colors.black : Colors.white,
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  hintText: label,
                  hintStyle: TextStyle(
                    color: isFocused ? Colors.black54 : Colors.white54,
                    fontSize: 24,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Please enter $label';
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required int index,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    final isFocused = _focusedIndex == index;
    return Focus(
      onFocusChange: (focused) {
        if (focused) setState(() => _focusedIndex = index);
      },
      child: GestureDetector(
        onTap: _submitting ? null : onTap,
        child: AnimatedScale(
          scale: isFocused ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: isFocused
                  ? Colors.white
                  : (isPrimary ? AppColors.primary : Colors.black45),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isFocused ? Colors.white : Colors.white24,
                width: 2,
              ),
              boxShadow: isFocused
                  ? [BoxShadow(color: Colors.white.withValues(alpha: 0.5), blurRadius: 16)]
                  : [],
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_submitting && isFocused)
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 3, color: Colors.black),
                )
              else
                Icon(icon, color: isFocused ? Colors.black : Colors.white, size: 32),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isFocused ? Colors.black : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Backdrop
          NetworkArt(
            url: 'https://image.tmdb.org/t/p/original/rMZ7q0sVzEaYqE8K2w8o1cRcwK7.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.black],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Row(
            children: [
              // Left Panel - Branding
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.movie_creation, color: AppColors.primary, size: 100),
                      const SizedBox(height: 32),
                      const Text(
                        'Welcome to StreamFlix',
                        style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Sign in to access your Watchlist, Continue Watching, and personalized recommendations.',
                        style: TextStyle(fontSize: 24, color: Colors.white70, height: 1.5),
                      ),
                      const Spacer(),
                      if (_errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.withValues(alpha: 0.5)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Right Panel - Login Form
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(80.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    border: Border(left: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 48),
                            _buildButton(
                              index: 0,
                              label: 'Continue with Google',
                              icon: Icons.g_mobiledata,
                              onTap: _submitGoogle,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                child: Text('OR', style: TextStyle(color: Colors.white54, fontSize: 20)),
                              ),
                            ),
                            _buildTextField(
                              index: 1,
                              label: 'Email address',
                              controller: _emailController,
                              obscureText: false,
                              icon: Icons.email_outlined,
                            ),
                            _buildTextField(
                              index: 2,
                              label: 'Password',
                              controller: _passwordController,
                              obscureText: true,
                              icon: Icons.lock_outline,
                            ),
                            const SizedBox(height: 16),
                            _buildButton(
                              index: 3,
                              label: 'Sign In',
                              icon: Icons.login,
                              isPrimary: true,
                              onTap: _submitEmailPassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
