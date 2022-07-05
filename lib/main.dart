import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';
import 'package:karaoke_request_client/configurations/api_configuration.dart';
import 'package:karaoke_request_client/configurations/app_theme.dart';
import 'package:karaoke_request_client/features/app_strings.dart';
import 'package:karaoke_request_client/features/home/home_bindings.dart';
import 'package:karaoke_request_client/features/home/home_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:karaoke_request_client/features/home/use_case/get_playlists_use_case.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const HomeView(), binding: HomeBindings()),
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
      title: 'Karaoke Request App',
      theme: AppTheme.themeDataFromFinnBlue,
      initialRoute: '/',
    );
  }
}

class _AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<KaraokeApiService>(KaraokeApiService(configuration: karaokeAPIConfiguration));
  }
}
