import 'ad_domain_blocklist.dart';

class StreamingNavigationDecision {
  const StreamingNavigationDecision._({
    required this.allowed,
    this.reason,
    this.causesFallback = false,
  });

  const StreamingNavigationDecision.allow() : this._(allowed: true);

  const StreamingNavigationDecision.block(
    String reason, {
    bool causesFallback = false,
  }) : this._(allowed: false, reason: reason, causesFallback: causesFallback);

  final bool allowed;
  final String? reason;
  final bool causesFallback;
}

class StreamingNavigationPolicy {
  const StreamingNavigationPolicy();

  StreamingNavigationDecision evaluate({
    required Uri? uri,
    required bool isMainFrame,
    required bool Function(String host) isAllowedHost,
    bool Function(String host)? isHttpAllowedHost,
  }) {
    if (uri == null) {
      return const StreamingNavigationDecision.block(
        'Malformed provider URL',
        causesFallback: true,
      );
    }

    // Network Domain Blocker: Check against known ad/popup domain blocklist
    if (AdDomainBlocklist.isAdUrl(uri)) {
      return StreamingNavigationDecision.block(
        'Blocked ad domain request: ${uri.host}',
        causesFallback: false,
      );
    }

    const blockedSchemes = {
      'intent',
      'market',
      'javascript',
      'whatsapp',
      'tg',
      'telegram',
      'mailto',
      'tel',
      'sms',
    };
    if (blockedSchemes.contains(uri.scheme.toLowerCase())) {
      return StreamingNavigationDecision.block(
        'Blocked unsupported/external scheme: ${uri.scheme}',
      );
    }

    const passiveSchemes = {'about', 'data', 'blob'};
    if (passiveSchemes.contains(uri.scheme.toLowerCase())) {
      return const StreamingNavigationDecision.allow();
    }

    if (!isMainFrame) {
      if (uri.scheme == 'http' || uri.scheme == 'https') {
        return const StreamingNavigationDecision.allow();
      }
      return StreamingNavigationDecision.block(
        'Blocked non-web subframe scheme: ${uri.scheme}',
      );
    }

    if (uri.scheme == 'http' && isHttpAllowedHost?.call(uri.host) == true) {
      if (!isAllowedHost(uri.host)) {
        return StreamingNavigationDecision.block(
          'Private provider redirected outside allowed hosts: ${uri.host}',
          causesFallback: true,
        );
      }
      return const StreamingNavigationDecision.allow();
    }

    if (uri.scheme != 'https') {
      return StreamingNavigationDecision.block(
        'Blocked top-level non-HTTPS navigation: ${uri.scheme}',
        causesFallback: true,
      );
    }

    if (!isAllowedHost(uri.host)) {
      return StreamingNavigationDecision.block(
        'Provider redirected outside allowed hosts: ${uri.host}',
        causesFallback: true,
      );
    }

    return const StreamingNavigationDecision.allow();
  }
}
