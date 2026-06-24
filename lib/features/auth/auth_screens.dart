import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/constants/app_assets.dart';
import '../../core/services/admin_repository.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/app_chrome.dart';
import '../../widgets/auth_widgets.dart';
import '../../widgets/buttons.dart';
import '../../widgets/network_art.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _submitting = false;

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
          PrimaryButton(
            label: _submitting ? 'Logging in...' : 'Login',
            onPressed: _submitting ? null : _submit,
          ),
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
          FutureBuilder<AppRemoteConfig>(
            future: AdminRepository.instance.loadPublicAppConfig(),
            builder: (context, snapshot) {
              final config = snapshot.data ?? const AppRemoteConfig();
              return SocialButtons(
                onGoogleTap: _submitting || !config.googleLoginEnabled
                    ? null
                    : _signInWithGoogle,
                onPhoneTap: _submitting || !config.phoneLoginEnabled
                    ? null
                    : () => Navigator.pushNamed(context, AppRoutes.phoneAuth),
              );
            },
          ),
          const SizedBox(height: 26),
          FutureBuilder<AppRemoteConfig>(
            future: AdminRepository.instance.loadPublicAppConfig(),
            builder: (context, snapshot) {
              final config = snapshot.data ?? const AppRemoteConfig();
              if (!config.signupEnabled) {
                return const SizedBox.shrink();
              }
              return Center(
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.register),
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
              );
            },
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await _runAuthAction(() {
      return AuthService.instance.signInWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );
    });
  }

  Future<void> _signInWithGoogle() {
    return _runAuthAction(AuthService.instance.signInWithGoogle);
  }

  Future<void> _runAuthAction(Future<void> Function() action) async {
    setState(() => _submitting = true);
    try {
      await action();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      if (mounted) _showMessage(_authMessage(error));
    } catch (_) {
      if (mounted) _showMessage('Sign-in failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
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
  bool _submitting = false;

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
          PrimaryButton(
            label: _submitting ? 'Creating...' : 'Register',
            onPressed: _submitting ? null : _submit,
          ),
          const SizedBox(height: 25),
          FutureBuilder<AppRemoteConfig>(
            future: AdminRepository.instance.loadPublicAppConfig(),
            builder: (context, snapshot) {
              final config = snapshot.data ?? const AppRemoteConfig();
              return SocialButtons(
                onGoogleTap: _submitting || !config.googleLoginEnabled
                    ? null
                    : _signInWithGoogle,
                onPhoneTap: _submitting || !config.phoneLoginEnabled
                    ? null
                    : () => Navigator.pushNamed(context, AppRoutes.phoneAuth),
              );
            },
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await _runAuthAction(() {
      return AuthService.instance.registerWithEmail(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    });
  }

  Future<void> _signInWithGoogle() {
    return _runAuthAction(AuthService.instance.signInWithGoogle);
  }

  Future<void> _runAuthAction(Future<void> Function() action) async {
    setState(() => _submitting = true);
    try {
      await action();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      if (mounted) _showMessage(_authMessage(error));
    } catch (_) {
      if (mounted) _showMessage('Registration failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
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
  bool _submitting = false;
  String? _requestedEmail;

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
          PrimaryButton(
            label: _submitting
                ? 'Requesting...'
                : (_requestedEmail == null ? 'Send reset link' : 'Send again'),
            onPressed: _submitting ? null : _submit,
          ),
          if (_requestedEmail != null) ...[
            const SizedBox(height: 20),
            Text(
              'Request accepted for $_requestedEmail. If an eligible account '
              'exists, Firebase will email a reset link. Delivery can take a '
              'few minutes; also check Spam or Junk. Google-only accounts can '
              'continue with Google or set a password from Profile after login.',
              textAlign: TextAlign.center,
              style: AppTextStyles.normal,
            ),
          ],
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _submitting = true);
    try {
      await AuthService.instance.sendPasswordResetEmail(_emailController.text);
      if (!mounted) return;
      setState(() => _requestedEmail = _emailController.text.trim());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Reset request accepted')));
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_authMessage(error))));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not request a reset link. Try again.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }
}

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String? _verificationId;
  String? _verificationPhoneNumber;
  int? _resendToken;
  bool _sendingCode = false;
  bool _verifyingCode = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codeSent = _verificationId != null;
    return _AuthScaffold(
      child: AuthPanel(
        title: codeSent ? 'Enter OTP' : 'Phone sign in',
        children: [
          Form(
            key: _phoneFormKey,
            child: AuthTextField(
              label: 'Phone number',
              hint: '+923001234567',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              validator: _validatePhone,
              onSubmitted: (_) => _sendCode(),
            ),
          ),
          if (codeSent) ...[
            const SizedBox(height: 25),
            Form(
              key: _codeFormKey,
              child: AuthTextField(
                label: 'Verification code',
                hint: '123456',
                controller: _codeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validator: _validateCode,
                onSubmitted: (_) => _verifyCode(),
              ),
            ),
          ],
          const SizedBox(height: 50),
          PrimaryButton(
            label: codeSent
                ? (_verifyingCode ? 'Verifying...' : 'Verify code')
                : (_sendingCode ? 'Sending...' : 'Send code'),
            onPressed: _sendingCode || _verifyingCode
                ? null
                : (codeSent ? _verifyCode : _sendCode),
          ),
          if (codeSent) ...[
            const SizedBox(height: 18),
            Text(
              'Firebase accepted the code request for '
              '${_verificationPhoneNumber ?? _phoneController.text.trim()}. '
              'SMS delivery can take a minute. Firebase test numbers do not '
              'receive SMS; use the test code configured in Firebase.',
              textAlign: TextAlign.center,
              style: AppTextStyles.normal,
            ),
            const SizedBox(height: 8),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: _sendingCode ? null : _sendCode,
                    child: Text(
                      'Resend code',
                      style: AppTextStyles.normal.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _sendingCode ? null : _changePhoneNumber,
                    child: Text(
                      'Change number',
                      style: AppTextStyles.normal.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 22),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              child: Text(
                'Back to login',
                style: AppTextStyles.normal.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) {
      return 'Phone number is required';
    }
    if (!phone.startsWith('+') || phone.length < 10) {
      return 'Use international format, for example +923001234567';
    }
    return null;
  }

  String? _validateCode(String? value) {
    final code = value?.trim() ?? '';
    if (code.length < 6) {
      return 'Enter the 6 digit code';
    }
    return null;
  }

  Future<void> _sendCode() async {
    if (!_phoneFormKey.currentState!.validate()) {
      return;
    }

    setState(() => _sendingCode = true);
    final phoneNumber = _phoneController.text.trim();
    final resendToken = phoneNumber == _verificationPhoneNumber
        ? _resendToken
        : null;
    try {
      await AuthService.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: resendToken,
        verificationCompleted: (credential) async {
          await _completePhoneSignIn(
            AuthService.instance.signInWithPhoneCredential(credential),
          );
        },
        verificationFailed: (error) {
          if (!mounted) return;
          setState(() => _sendingCode = false);
          _showMessage(_authMessage(error));
        },
        codeSent: (verificationId, newResendToken) {
          if (!mounted) return;
          setState(() {
            _verificationId = verificationId;
            _verificationPhoneNumber = phoneNumber;
            _resendToken = newResendToken;
            _sendingCode = false;
          });
          _showMessage(
            'Code request accepted. Wait a minute, then use Resend if needed.',
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          if (!mounted) return;
          setState(() {
            _verificationId = verificationId;
            _verificationPhoneNumber = phoneNumber;
            _sendingCode = false;
          });
        },
      );
    } on FirebaseAuthException catch (error) {
      if (!mounted) return;
      setState(() => _sendingCode = false);
      _showMessage(_authMessage(error));
    } catch (_) {
      if (!mounted) return;
      setState(() => _sendingCode = false);
      _showMessage('Could not request a verification code. Try again.');
    }
  }

  void _changePhoneNumber() {
    setState(() {
      _verificationId = null;
      _verificationPhoneNumber = null;
      _resendToken = null;
      _codeController.clear();
    });
  }

  Future<void> _verifyCode() async {
    if (!_codeFormKey.currentState!.validate()) {
      return;
    }
    final verificationId = _verificationId;
    if (verificationId == null) {
      _showMessage('Request a verification code first');
      return;
    }

    setState(() => _verifyingCode = true);
    await _completePhoneSignIn(
      AuthService.instance.signInWithPhoneCode(
        verificationId: verificationId,
        smsCode: _codeController.text,
      ),
    );
  }

  Future<void> _completePhoneSignIn(Future<void> signInFuture) async {
    try {
      await signInFuture;
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      if (mounted) _showMessage(_authMessage(error));
    } catch (_) {
      if (mounted) _showMessage('Phone sign-in failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          _sendingCode = false;
          _verifyingCode = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

String _authMessage(FirebaseAuthException error) {
  return switch (error.code) {
    'invalid-email' => 'Enter a valid email address.',
    'user-disabled' => 'This account has been disabled.',
    'user-not-found' => 'No account was found for this email.',
    'wrong-password' ||
    'invalid-credential' => 'Email or password is incorrect.',
    'email-already-in-use' => 'An account already exists for this email.',
    'weak-password' => 'Password is too weak.',
    'network-request-failed' => 'Network error. Check your connection.',
    'google-sign-in-unavailable' => 'Google sign-in is not available here.',
    'missing-google-id-token' => 'Google sign-in could not be completed.',
    'invalid-verification-code' => 'The verification code is incorrect.',
    'invalid-phone-number' =>
      'Enter a valid phone number in international format.',
    'missing-client-identifier' || 'app-not-authorized' =>
      'This app is not authorized for phone verification.',
    'quota-exceeded' => 'The SMS quota has been reached. Try again later.',
    'session-expired' => 'The verification code expired. Request a new code.',
    'too-many-requests' => 'Too many attempts. Try again later.',
    _ => error.message ?? 'Authentication failed. Please try again.',
  };
}

class _AuthScaffold extends StatelessWidget {
  const _AuthScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(),
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
