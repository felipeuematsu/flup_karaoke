import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/app_imports.dart';
import 'package:karaoke_request_client/configurations/app_theme.dart';
import 'package:karaoke_request_client/database/database.dart';
import 'package:karaoke_request_client/database/database_keys.dart';
import 'package:karaoke_request_client/dependency_injection/initial.dart';
import 'package:karaoke_request_client/router/app_router.dart';
import 'package:karaoke_request_client/util/host_checker_util.dart';
import 'package:uni_links/uni_links.dart';

bool _initialUriIsHandled = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _appRouter = AppRouter();
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
      builder: (context, child) => Scaffold(key: _scaffoldKey, body: child),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'Flup Karaoke',
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

        final databaseHost = await Database().readPersistent<String?>(DatabaseKeys.host.name);
        final host = testHosts([(uri?.queryParameters['host']), databaseHost, if (kIsWeb) Uri.base.host]);

        if (host == null) {
          _appRouter.replaceAll([ServerSelectViewRoute()]);
        } else {
          final configuration = KaraokeAPIConfiguration(baseUrl: 'https://${host.host}');
          final service = KaraokeApiService(configuration: configuration);

          service.getQueue().then((_) {
            GetIt.I.registerLazySingleton(() => service);
            injectInitialDependencies();
            _appRouter.replaceAll([MainViewRoute()]);
          }).onError((error, stackTrace) {
            context.replaceRoute(ServerSelectViewRoute());
          });
        }
      }, onError: (Object err) {
        if (!mounted) return;
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
      _showSnackBar('_handleInitialUri called');
      try {
        final uri = await getInitialUri();

        final databaseHost = await Database().readPersistent<String?>(DatabaseKeys.host.name);
        final host = testHosts([uri?.queryParameters['host'], databaseHost, if (kIsWeb) Uri.base.host]);

        if (host == null) {
          _appRouter.replaceAll([ServerSelectViewRoute()]);
        } else {
          final configuration = KaraokeAPIConfiguration(baseUrl: 'https://${host.host}');
          final service = KaraokeApiService(configuration: configuration);

          service.getQueue().then((_) {
            GetIt.I.registerLazySingleton(() => service);
            injectInitialDependencies();
            _appRouter.replaceAll([MainViewRoute()]);
          }).onError((error, stackTrace) {
            context.replaceRoute(ServerSelectViewRoute());
          });
        }
        if (!mounted) return;
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
      } on FormatException catch (err) {
        if (!mounted) return;
      }
    }
  }

  void _showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(msg),
      ));
    });
  }
}
