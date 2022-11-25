import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/configurations/app_theme.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/database_keys.dart';
import 'package:flup_karaoke/dependency_injection/initial.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:flup_karaoke/router/guards/service_guard.dart';
import 'package:flup_karaoke/util/host_checker_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_strategy/url_strategy.dart';

bool _initialUriIsHandled = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  setPathUrlStrategy();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('pt', 'BR')],
      path: 'none',
      fallbackLocale: const Locale('en', 'US'),
      assetLoader: AppCustomLoader(),
      startLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter(serviceGuard: ServiceGuard());
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) => Scaffold(body: child),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'FLUP Karaoke',
      theme: themeDataFromFinnBlue.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
    );
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? uri) async {
        if (!mounted) return;

        if (_appRouter.current.route.name == ServerSelectViewRoute.name) {
          final databaseHost = await Database().readPersistent<String?>(DatabaseKeys.host.name);
          final hosts = [
            testHttpsHost(uri?.queryParameters['host']),
            testHttpHost(uri?.queryParameters['host']),
            testHttpsHost(databaseHost),
            testHttpHost(databaseHost),
            if (kIsWeb) testHttpsHost(Uri.base.host),
            if (kIsWeb) testHttpHost(Uri.base.host),
          ];
          for (final host in hosts) {
            if (host == null) {
              _appRouter.replaceAll([ServerSelectViewRoute()]);
            } else {
              final configuration = KaraokeAPIConfiguration(baseUrl: '${host.scheme}${host.host}');
              final service = KaraokeApiService(configuration: configuration);

              service.getQueue().then((_) {
                GetIt.I.registerLazySingleton(() => service);
                injectInitialDependencies();
                return _appRouter.replaceAll([const MainViewRoute()]);
              }).onError((error, stackTrace) {
                print(error);
              });
            }
          }
        }
      }, onError: (Object err) {
        if (!mounted) return;
        _appRouter.replaceAll([ServerSelectViewRoute()]);
      });
    }
  }

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();

        final databaseHost = await Database().readPersistent<String?>(DatabaseKeys.host.name);
        final hosts = [
          testHttpsHost(uri?.queryParameters['host']),
          testHttpHost(uri?.queryParameters['host']),
          testHttpsHost(databaseHost),
          testHttpHost(databaseHost),
          if (kIsWeb) testHttpsHost(Uri.base.host),
          if (kIsWeb) testHttpHost(Uri.base.host),
        ];
        for (final host in hosts) {
          if (host == null) {
            _appRouter.replaceAll([ServerSelectViewRoute()]);
          } else {
            final configuration = KaraokeAPIConfiguration(baseUrl: 'https://${host.host}');
            final service = KaraokeApiService(configuration: configuration);

            service.getQueue().then((_) {
              GetIt.I.registerLazySingleton(() => service);
              injectInitialDependencies();
              _appRouter.replaceAll([const MainViewRoute()]);
            }).onError((error, stackTrace) {
              print(error);
            });
          }
        }
        if (!mounted) return;
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
      } on FormatException {
        if (!mounted) return;
      }
      _appRouter.replaceAll([ServerSelectViewRoute()]);
    }
  }
}
