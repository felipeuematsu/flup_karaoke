import 'package:karaoke_request_api/karaoke_request_api.dart';

class LoginController {
  LoginController();

  Future<bool> testHost(String host) {
    final uri = Uri.http(host);
    final testService = KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: 'http://${uri.host}', port: uri.port == 0 ? null : uri.port));
    return testService.health();
  }
}
