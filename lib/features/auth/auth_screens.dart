import 'dart:ui';

import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/constants/app_assets.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/auth_widgets.dart';
import '../../widgets/buttons.dart';
import '../../widgets/network_art.dart';
import '../../widgets/snackbar_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AuthScaffold(
      child: AuthPanel(
        title: 'Welcome Back',
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthTextField(
                  label: 'Email address',
                  hint: 'your-email@mail.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  obscure: true,
                  textInputAction: TextInputAction.done,
                  validator: _validatePassword,
                  onSubmitted: (_) => _submit(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          PrimaryButton(label: 'Login', onPressed: _submit),
          const SizedBox(height: 28),
          Center(
            child: TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.resetPassword),
              child: Text(
                'Forget password?',
                style: AppTextStyles.normal.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 28),
          SocialButtons(
            onGoogleTap: () => _showMessage('Google sign-in is not connected'),
            onPhoneTap: () => _showMessage('Phone sign-in is not connected'),
          ),
          const SizedBox(height: 26),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.normal,
                  children: const [
                    TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login validated')));
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AuthScaffold(
      child: AuthPanel(
        title: 'Create your account',
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthTextField(
                  label: 'Full name',
                  hint: 'Your name',
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Name is required'
                      : null,
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  label: 'Email address',
                  hint: 'your-email@mail.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  obscure: true,
                  textInputAction: TextInputAction.next,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 25),
                AuthTextField(
                  label: 'Confirm password',
                  hint: 'Confirm your password',
                  controller: _confirmController,
                  obscure: true,
                  textInputAction: TextInputAction.done,
                  validator: _validateConfirmPassword,
                  onSubmitted: (_) => _submit(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          PrimaryButton(label: 'Register', onPressed: _submit),
          const SizedBox(height: 25),
          SocialButtons(
            onGoogleTap: () => _showMessage('Google sign-up is not connected'),
            onPhoneTap: () => _showMessage('Phone sign-up is not connected'),
          ),
          const SizedBox(height: 22),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.normal,
                  children: const [
                    TextSpan(text: 'Already have an account? '),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return _validatePassword(value);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registration complete')));
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AuthScaffold(
      child: AuthPanel(
        title: 'Recovery password',
        children: [
          Form(
            key: _formKey,
            child: AuthTextField(
              label: 'Email address',
              hint: 'your-email@mail.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Enter a valid email';
                }
                return null;
              },
              onSubmitted: (_) => _submit(),
            ),
          ),
          const SizedBox(height: 50),
          PrimaryButton(label: 'Submit', onPressed: _submit),
          const SizedBox(height: 60),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              child: Text(
                'Back to login',
                style: AppTextStyles.normal.copyWith(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reset link sent')));
    Navigator.pushNamed(context, AppRoutes.login);
  }
}

class SnackbarStatesScreen extends StatelessWidget {
  const SnackbarStatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AuthScaffold(
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSnackbar(
            message: 'Success message will show here in this snackbar',
            type: AppSnackbarType.success,
          ),
          SizedBox(height: 18),
          AppSnackbar(
            message: 'Warning message will show here in this snackbar',
            type: AppSnackbarType.warning,
          ),
          SizedBox(height: 18),
          AppSnackbar(
            message: 'Error message will show here in this snackbar',
            type: AppSnackbarType.danger,
          ),
        ],
      ),
    );
  }
}

class _AuthScaffold extends StatelessWidget {
  const _AuthScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Opacity(
                opacity: 0.75,
                child: NetworkArt(url: AppAssets.hero),
              ),
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: MovieAppBar()),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
