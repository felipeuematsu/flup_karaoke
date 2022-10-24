import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/router/app_router.dart';

class ServiceGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (GetIt.I.isRegistered<KaraokeApiService>()) {
      resolver.next();
    } else {
      router.replaceAll([ServerSelectViewRoute()]);
    }
  }
}
