class AdDomainBlocklist {
  const AdDomainBlocklist._();

  static const Set<String> blockedDomainsAndKeywords = {
    'exoclick.com',
    'popcash.net',
    'popads.net',
    'adsterra.com',
    'propellerads.com',
    'juicyads.com',
    'doubleclick.net',
    'googlesyndication.com',
    'adnxs.com',
    'clck.ru',
    'mngbtt.com',
    'hqq.tv',
    'bet365',
    '1xbet',
    'melbet',
    'parimatch',
    'mostbet',
    'stake.com',
    'bc.game',
    'adtraffic',
    'adservice',
    'popunder',
    'clickthrough',
    'syndication',
    'betting',
    'casino',
  };

  static bool isAdUrl(Uri? uri) {
    if (uri == null) return false;
    final host = uri.host.toLowerCase();
    final path = uri.path.toLowerCase();

    for (final kw in blockedDomainsAndKeywords) {
      if (host.contains(kw)) {
        return true;
      }
    }

    if (path.contains('/ad/') ||
        path.contains('/pop/') ||
        path.contains('/banner/') ||
        path.contains('popunder') ||
        path.contains('clickthrough')) {
      return true;
    }

    return false;
  }

  static const String easyListCosmeticCss = '''
    iframe[style*="position: fixed"], iframe[style*="2147483"], iframe[style*="z-index"],
    div[style*="2147483"], div[style*="z-index: 214748364"],
    iframe[src*="ad"], iframe[src*="pop"], iframe[src*="bet"], iframe[src*="casino"],
    div[id*="pop"], div[id*="ad-"], div[class*="ad-"], div[class*="pop"], div[class*="banner"],
    div[style*="z-index: 999999"], div[style*="z-index: 2147483647"],
    a[href*="bet"], a[href*="casino"], a[href*="1xbet"], a[target="_blank"] {
      display: none !important;
      visibility: hidden !important;
      opacity: 0 !important;
      pointer-events: none !important;
      width: 0px !important;
      height: 0px !important;
    }
  ''';
}
