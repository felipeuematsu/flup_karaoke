Uri? testHosts(List<String?> hosts) {
  for (final host in hosts) {
    print('host: $host');
    if (host != null && host.isNotEmpty) {
      var uri = Uri.tryParse(host);
      print('uri: {host: ${uri?.host}, port: ${uri?.port}, scheme: ${uri?.scheme}, path: ${uri?.path}}');
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
