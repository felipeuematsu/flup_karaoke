import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/configurations/api_configuration.dart';
import 'package:karaoke_request_client/configurations/app_theme.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/home_bindings.dart';
import 'package:karaoke_request_client/features/home/home_view.dart';
import 'package:karaoke_request_client/features/menu/menu_view.dart';
import 'package:karaoke_request_client/features/queue/queue_view.dart';
import 'package:karaoke_request_client/features/search/components/search_view.dart';
import 'package:karaoke_request_client/features/singers/singers_view.dart';
import 'package:karaoke_request_client/features/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:karaoke_request_client/features/widgets/main_view.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final KaraokeApiService service = KaraokeApiService(configuration: karaokeAPIConfiguration);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: NavigationRoutes.home.route,
          page: () => MainView(
            children: [
              const HomeView(),
              SearchView(service: service),
              QueueView(service: service),
              MenuView(service: service),
            ],
          ),
          bindings: [HomeBindings()],
        ),
        GetPage(name: NavigationRoutes.singers.route, page: () => SingersView(service: service)),
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
  void dependencies() {
    Get.put<KaraokeApiService>(KaraokeApiService(configuration: karaokeAPIConfiguration));
  }
}
