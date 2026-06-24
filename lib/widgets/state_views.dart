import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import '../app/app_theme.dart';
import '../core/services/tmdb_api_client.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({
    required this.title,
    required this.message,
    this.icon = Icons.error_outline,
    this.onRetry,
    this.onBack,
    this.onHome,
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;
  final VoidCallback? onHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: AppColors.primary),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.normal,
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                if (onRetry != null)
                  OutlinedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                if (onBack != null)
                  OutlinedButton.icon(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                if (onHome != null)
                  FilledButton.icon(
                    onPressed: onHome,
                    icon: const Icon(Icons.home_outlined),
                    label: const Text('Go Home'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 44, color: AppColors.primary),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.normal,
            ),
            if (onAction != null) ...[
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.refresh),
                label: Text(actionLabel ?? 'Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String userMessageForError(Object? error) {
  if (error is TimeoutException) {
    return 'Request timed out. Check your connection and try again.';
  }
  if (error is SocketException) {
    return 'No internet connection. Check your network and try again.';
  }
  if (error is FirebaseException) {
    return switch (error.code) {
      'permission-denied' =>
        'You do not have permission to view this data. Login again and retry.',
      'unavailable' || 'deadline-exceeded' =>
        'No internet connection or Firebase is temporarily unavailable.',
      _ => 'Could not load your account data. Try again.',
    };
  }
  if (error is TmdbApiException) {
    return switch (error.statusCode) {
      401 || 403 => 'Movie data service is not configured correctly.',
      404 => 'This content was not found.',
      429 => 'Too many requests. Try again shortly.',
      int status when status >= 500 =>
        'Movie data service is temporarily unavailable.',
      _ when error.message.toLowerCase().contains('token') =>
        'Movie data service is not configured correctly.',
      _ => 'Could not load movie data. Try again.',
    };
  }

  if (kDebugMode && error != null) {
    debugPrint('Mapped generic error: $error');
  }
  return 'Something went wrong. Try again.';
}

class InvalidRouteScreen extends StatelessWidget {
  const InvalidRouteScreen({
    this.message = 'This page is missing required information.',
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppErrorView(
        title: 'Invalid route',
        message: message,
        icon: Icons.route_outlined,
        onBack: () => Navigator.maybePop(context),
        onHome: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({this.routeName, super.key});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppErrorView(
        title: 'Page not found',
        message: routeName == null
            ? 'The requested page does not exist.'
            : 'No route exists for "$routeName".',
        icon: Icons.search_off_outlined,
        onBack: () => Navigator.maybePop(context),
        onHome: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        ),
      ),
    );
  }
}

class AccessDeniedScreen extends StatelessWidget {
  const AccessDeniedScreen({
    this.message = 'You do not have permission to open this page.',
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppErrorView(
        title: 'Access denied',
        message: message,
        icon: Icons.lock_outline,
        onBack: () => Navigator.maybePop(context),
        onHome: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        ),
      ),
    );
  }
}
