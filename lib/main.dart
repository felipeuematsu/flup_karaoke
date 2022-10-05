import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/configurations/app_theme.dart';
import 'package:karaoke_request_client/database/database.dart';
import 'package:karaoke_request_client/database/database_keys.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/home_bindings.dart';
import 'package:karaoke_request_client/features/login/login_view.dart';
import 'package:karaoke_request_client/features/singers/singers_view.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:karaoke_request_client/features/widgets/main_view.dart';
import 'package:karaoke_request_client/features/youtube_search/youtube_search_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: NavigationRoutes.login.route, page: () => const LoginView()),
        GetPage(name: NavigationRoutes.home.route, page: () {
          try {
            final KaraokeApiService service = Get.find();
            return MainView(service: Get.find());
          } catch (e) {
            return const LoginView();
          }
        }, bindings: [HomeBindings()]),
        GetPage(name: NavigationRoutes.singers.route, page: () => SingersView(service: Get.find())),
        GetPage(name: NavigationRoutes.youtubeSearch.route, page: () => YoutubeSearchView(service: Get.find())),
      ],
      initialBinding: _AppBindings(),
      fallbackLocale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      translations: AppTranslations(),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      locale: const Locale('pt', 'BR'),
      title: 'Karaoke',
      theme: AppTheme.themeDataFromFinnBlue.copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: NavigationRoutes.home.route,
    );
  }
}

class _AppBindings extends Bindings {
  @override
  Future<void> dependencies()  async {
    await Database().readPersistent(DatabaseKeys.host.name).then((value) {
      final host = value ?? 'localhost';
      Get.lazyPut<KaraokeApiService>(() => KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: host, port: 8159)));
    });
  }
}
