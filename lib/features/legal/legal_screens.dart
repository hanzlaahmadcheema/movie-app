import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/app_theme.dart';
import '../../core/constants/app_legal.dart';
import '../../widgets/app_chrome.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LegalPageScreen(
      title: 'Contact',
      children: [
        Text(
          'Need help with your account, watchlist, activity, or catalog browsing? Contact MovieApp support.',
          style: AppTextStyles.normal,
        ),
        const SizedBox(height: 18),
        SelectableText(AppLegal.supportEmail, style: AppTextStyles.medium),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () async {
            await Clipboard.setData(
              const ClipboardData(text: AppLegal.supportEmail),
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Support email copied')),
              );
            }
          },
          icon: const Icon(Icons.copy),
          label: const Text('Copy support email'),
        ),
      ],
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPageScreen(
      title: 'Terms of Service',
      paragraphs: [
        'MovieApp provides catalog browsing, account, watchlist, activity, and embedded playback navigation features. MovieApp does not host movie or series files.',
        'Metadata, posters, backdrops, cast information, trailers, and similar content are provided through TMDB where available. This product uses the TMDB API but is not endorsed or certified by TMDB.',
        'Streaming playback is provided through third-party embedded providers configured in the app. Availability can change, and a server may not have a requested title.',
        'You are responsible for using the app only where you have the right to access the content. Do not misuse accounts, attempt to bypass provider restrictions, or interfere with app services.',
        'Account features use Firebase Authentication and Firestore. You are responsible for keeping your account credentials secure.',
        'To the maximum extent allowed by applicable law, MovieApp is provided as-is without guarantees of uninterrupted availability, exact resume playback, or provider content availability.',
        'For questions, contact support using the Contact page. This text is a product placeholder and should be reviewed by qualified legal counsel before production release.',
      ],
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LegalPageScreen(
      title: 'Privacy Policy',
      paragraphs: [
        'MovieApp uses Firebase Authentication to manage sign-in state, account identifiers, email or phone login data where enabled, and provider metadata returned by Firebase.',
        'Firestore stores user-scoped app data such as watchlist records, reactions, selected provider/server metadata, selected TV season and episode, and Continue Watching activity.',
        'Embedded WebView players do not safely expose exact playback timestamps across provider origins. Continue Watching may record content identity, selected provider, and last opened time, but exact resume time is unavailable unless a provider exposes it safely.',
        'TMDB metadata is requested to display catalog, detail, cast, trailer, genre, country, and production information. MovieApp does not send Firebase account secrets to TMDB.',
        'Debug diagnostics may record provider names, URL hosts, timing, and failure reasons for troubleshooting. Full provider URLs, tokens, and secrets should not be logged in production.',
        'MovieApp does not sell personal data in this implementation. If production policies change, this notice must be updated before release.',
        'You can contact support through the Contact page for privacy questions or account-data requests. This policy text should be reviewed before production release.',
      ],
    );
  }
}

class LegalPageScreen extends StatelessWidget {
  const LegalPageScreen({
    required this.title,
    this.paragraphs = const [],
    this.children = const [],
    super.key,
  });

  final String title;
  final List<String> paragraphs;
  final List<Widget> children;

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
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final paragraph in paragraphs) ...[
                  Text(paragraph, style: AppTextStyles.normal),
                  const SizedBox(height: 14),
                ],
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
