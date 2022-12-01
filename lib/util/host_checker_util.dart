import 'package:flutter/foundation.dart';

Uri? testHttpsHost(String? host) {
  if (kIsWeb && Uri.base.scheme == 'https') {
    return null;
  }

  if (host != null && host.isNotEmpty) {
    var uri = Uri.tryParse(host);
    if (uri != null && uri.host.isNotEmpty) {
      return uri;
    }
    uri = Uri.tryParse('http://$host');
    if (uri != null && uri.host.isNotEmpty) {
      return uri;
    }
  }

  return null;
}

Uri? testHttpHost(String? host) {
  if (host != null && host.isNotEmpty) {
    var uri = Uri.tryParse(host);
    if (uri != null && uri.host.isNotEmpty) {
      return uri;
    }
    uri = Uri.tryParse('https://$host');
    if (uri != null && uri.host.isNotEmpty) {
      return uri;
    }
  }

  return null;
}
