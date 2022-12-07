import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/database/database_keys.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

class ServiceGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (GetIt.I.isRegistered<KaraokeApiService>()) {
      resolver.next();
    } else {
      final databaseHost = await DatabaseKeys.host.readPersistent<String?>();
      if (databaseHost != null) {
        final service = KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: databaseHost));
        GetIt.I.registerLazySingleton(() => service);
        resolver.next();
      } else {
        router.replaceAll([ServerSelectViewRoute()]);
      }
    }
  }
}
