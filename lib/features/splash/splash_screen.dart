import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../app/app_theme.dart';
import '../../core/auth/user_role_service.dart';
import '../../core/constants/app_assets.dart';
import '../../core/navigation/navigation_state_repository.dart';
import '../../core/services/admin_repository.dart';
import '../../core/services/auth_service.dart';
import '../../widgets/network_art.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      debugPrint('SplashScreen init');
    }
    _timer = Timer(Duration.zero, _continueToApp);
  }

  @override
  void dispose() {
    if (kDebugMode) {
      debugPrint('SplashScreen dispose');
    }
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _continueToApp() async {
    if (!mounted) return;
    final user = AuthService.instance.currentUser;
    if (user == null) {
      if (kDebugMode) {
        debugPrint('SplashScreen bootstrap target: ${AppRoutes.login}');
      }
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }
    final role = await UserRoleService.instance.loadRole(user);
    await AdminRepository.instance.loadPublicAppConfig();
    if (!mounted) return;
    final target = await NavigationStateRepository.instance.buildRestoreTarget(
      role: role,
    );
    if (!mounted) return;
    if (kDebugMode) {
      debugPrint('SplashScreen bootstrap target: ${target.route}');
    }
    Navigator.pushReplacementNamed(
      context,
      target.route,
      arguments: target.arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      debugPrint('SplashScreen build');
    }
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NetworkArt(
                url: AppAssets.logo,
                width: 132,
                height: 132,
                borderRadius: BorderRadius.all(Radius.circular(66)),
              ),
              SizedBox(height: 22),
              Text(
                'HA MovieApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 18),
              SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 2.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
