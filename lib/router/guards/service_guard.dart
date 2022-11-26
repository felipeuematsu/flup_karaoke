import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

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
