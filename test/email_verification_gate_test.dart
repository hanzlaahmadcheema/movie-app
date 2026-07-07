import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/app/app_routes.dart';
import 'package:movie_app/core/services/auth_service.dart';

void main() {
  group('email verification gate', () {
    test('blocks unverified email password users', () {
      expect(
        AuthService.requiresEmailVerificationForProviderIds(
          providerIds: [EmailAuthProvider.PROVIDER_ID],
          emailVerified: false,
        ),
        isTrue,
      );
    });

    test('allows verified email password users', () {
      expect(
        AuthService.requiresEmailVerificationForProviderIds(
          providerIds: [EmailAuthProvider.PROVIDER_ID],
          emailVerified: true,
        ),
        isFalse,
      );
    });

    test('allows google and phone users regardless of email verification', () {
      expect(
        AuthService.requiresEmailVerificationForProviderIds(
          providerIds: [
            GoogleAuthProvider.PROVIDER_ID,
            PhoneAuthProvider.PROVIDER_ID,
          ],
          emailVerified: false,
        ),
        isFalse,
      );
    });

    testWidgets('verify email route renders verification screen', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.verifyEmail,
        ),
      );

      await tester.pump();

      expect(find.text('Verify your email'), findsOneWidget);
      expect(find.text('I verified, refresh'), findsOneWidget);
      expect(find.text('Resend email'), findsOneWidget);
      expect(find.text('Sign out'), findsOneWidget);
    });
  });
}
