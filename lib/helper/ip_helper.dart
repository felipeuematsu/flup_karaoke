Uri? formatHost(String host) {
  if (host.isEmpty) {
    return null;
  }
  if (host.startsWith('http://') || host.startsWith('https://')) {
    return Uri.tryParse(host);
  }
  return Uri.tryParse('http://$host');
}
