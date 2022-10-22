Uri? testHosts(List<String?> hosts) {
  for (final host in hosts) {
    print('host: $host');
    if (host != null && host.isNotEmpty) {
      final uri = Uri.tryParse(host);
      if (uri != null && uri.host.isNotEmpty) {
        return uri;
      }
    }
  }
  return null;
}
