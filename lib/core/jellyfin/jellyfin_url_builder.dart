import 'jellyfin_config.dart';

class JellyfinUrlBuilder {
  const JellyfinUrlBuilder();

  Uri home(Uri baseUri) {
    return baseUri.resolve('/web/');
  }

  Uri itemDetail(Uri baseUri, String itemId) {
    return baseUri
        .resolve('/web/index.html')
        .replace(fragment: '!/details?id=${Uri.encodeQueryComponent(itemId)}');
  }

  bool isAllowedHttpHost(Uri baseUri, String host) {
    return baseUri.scheme == 'http' &&
        baseUri.host.toLowerCase() == host.toLowerCase() &&
        isAllowedPrivateHttpHost(host);
  }
}
