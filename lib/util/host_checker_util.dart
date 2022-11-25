Uri? testHttpsHosts(List<String?> hosts) {
  for (final host in hosts) {
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
  }
  return null;
}

Uri? testHttpHosts(List<String?> hosts) {
  for (final host in hosts) {
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
  }
  return null;
}
