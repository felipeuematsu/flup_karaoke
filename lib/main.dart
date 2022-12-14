import 'dart:async';

import 'package:flup_karaoke/configurations/app_theme.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/database/database_keys.dart';
import 'package:flup_karaoke/dependency_injection/initial.dart';
import 'package:flup_karaoke/localizations/flup_localizations.dart';
import 'package:flup_karaoke/router/app_router.dart';
import 'package:flup_karaoke/router/guards/service_guard.dart';
import 'package:flup_karaoke/util/host_checker_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:uni_links/uni_links.dart';
import 'package:universal_html/html.dart';
import 'package:url_strategy/url_strategy.dart';

bool _initialUriIsHandled = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Database().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  late Locale? _locale = _database.readPersistent(DatabaseKeys.language.name) ?? const Locale('en', 'US');

  final _database = Database();
  final _appRouter = AppRouter(serviceGuard: ServiceGuard());
  StreamSubscription? _sub;
  String? host;

  Locale? get locale => _locale;

  set locale(Locale? locale) => setState(() => _locale = locale);

  @override
  void initState() {
    super.initState();
    host ??= DatabaseKeys.host.readPersistent<String?>();

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
      locale: locale ??= _database.readPersistent(DatabaseKeys.language.name),
      builder: (context, child) => Scaffold(body: child),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: const [
        FlupLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('pt', 'BR')],
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
          if (GetIt.I.isRegistered<KaraokeApiService>()) GetIt.I.unregister<KaraokeApiService>();
          final databaseHost = DatabaseKeys.host.readPersistent<String?>();
          final hosts = [
            testHttpHost(uri?.queryParameters['host']),
            testHttpsHost(uri?.queryParameters['host']),
            testHttpHost(databaseHost),
            testHttpsHost(databaseHost),
            if (kIsWeb) testHttpHost(Uri.base.host),
            if (kIsWeb) testHttpsHost(Uri.base.host),
          ];
          for (final host in hosts) {
            if (host == null) continue;
            final configuration = KaraokeAPIConfiguration(baseUrl: host.toString());
            final service = KaraokeApiService(configuration: configuration);

            final serverFound = await service.health();
            if (!serverFound) continue;
            if (kIsWeb && Uri.base.host != host.host) {
              // ignore: unsafe_html
              window.open(host.toString(), '_self');
              return;
            }
            GetIt.I.registerLazySingleton(() => service);
            DatabaseKeys.host.writePersistent(host.toString());
            injectInitialDependencies();
            return _appRouter.replaceAll([const MainViewRoute()]);
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

        final databaseHost = DatabaseKeys.host.readPersistent<String?>();
        final hosts = [
          testHttpHost(uri?.queryParameters['host']),
          testHttpsHost(uri?.queryParameters['host']),
          testHttpHost(databaseHost),
          testHttpsHost(databaseHost),
          if (kIsWeb) testHttpHost(Uri.base.host),
          if (kIsWeb) testHttpsHost(Uri.base.host),
        ];
        for (final host in hosts) {
          if (host == null) continue;
          final configuration = KaraokeAPIConfiguration(baseUrl: host.toString());
          final service = KaraokeApiService(configuration: configuration);

          final serverFound = await service.health();
          if (!serverFound) continue;
          if (kIsWeb && Uri.base.host != host.host) {
            // ignore: unsafe_html
            window.open(host.toString(), '_self');
            return;
          }
          if (GetIt.I.isRegistered<KaraokeApiService>()) GetIt.I.unregister<KaraokeApiService>();
          GetIt.I.registerLazySingleton(() => service);
          DatabaseKeys.host.writePersistent(host.toString());
          injectInitialDependencies();
          return _appRouter.replaceAll([const MainViewRoute()]);
        }
        _appRouter.replaceAll([ServerSelectViewRoute()]);
        if (!mounted) return;
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
      } on FormatException {
        if (!mounted) return;
      }
    }
  }
}
