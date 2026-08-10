import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app_theme.dart';
import '../../core/auth/user_role_service.dart';
import '../../core/services/admin_repository.dart';
import '../../widgets/state_views.dart';

class PaymentVerificationScreen extends StatelessWidget {
  const PaymentVerificationScreen({super.key});

  Future<void> _launchWhatsApp(String link) async {
    final uri = Uri.tryParse(link);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserRoleService.instance.watchCurrentUserRole(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isVerified) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
        }
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Verification Required'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: FutureBuilder<AppRemoteConfig>(
            future: AdminRepository.instance.loadPublicAppConfig(),
            builder: (context, configSnapshot) {
              if (configSnapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (configSnapshot.hasError || configSnapshot.data == null) {
                return const AppErrorView(
                  title: 'Error loading configuration',
                  message: 'Could not load the payment configuration.',
                );
              }
              
              final link = configSnapshot.data!.paymentWhatsappLink;
              
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_outline, size: 80, color: AppColors.primary),
                      const SizedBox(height: 24),
                      const Text(
                        'Premium Content',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'To watch movies and series, a 1-time payment is required to verify your account. Once payment is made and verified by an admin, this screen will automatically dismiss and you can continue watching.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.normal.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (link.trim().isNotEmpty)
                        ElevatedButton.icon(
                          onPressed: () => _launchWhatsApp(link),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Make Payment via WhatsApp'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                        )
                      else
                        Text(
                          'Payment link is not configured.',
                          style: TextStyle(color: Colors.red.withValues(alpha: 0.8)),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
