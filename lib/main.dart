import 'package:auto_route/auto_route.dart';
import 'package:auto_route/src/router/controller/routing_controller.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flup_karaoke/configuration/app_locales.dart';
import 'package:flup_karaoke/configuration/app_router.dart';
import 'package:flup_karaoke/configuration/app_router.gr.dart';
import 'package:flup_karaoke/configuration/constants.dart';
import 'package:flup_karaoke/configuration/dependencies.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/features/login/controller/login_controller.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/helper/fish_assets.dart';
import 'package:flup_karaoke/helper/ip_helper.dart';
import 'package:flup_karaoke/mock/karaoke_api_service_mock.dart';
import 'package:flup_karaoke/themes/color_schemes.g.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flup_karaoke/themes/text_themes.dart';
import 'package:flup_karaoke/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:karaoke_request_api/karaoke_request_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  GetIt.I.allowReassignment = true;
  final appDB = AppDB.get();
  runApp(FlupKApp(initialDarkModeState: appDB.darkMode, initialLocale: appDB.locale));
}

class FlupKApp extends StatefulWidget {
  const FlupKApp({Key? key, required this.initialDarkModeState, required this.initialLocale}) : super(key: key);

  final bool initialDarkModeState;
  final Locale? initialLocale;

  static _FlupKAppState of(BuildContext context) => context.findAncestorStateOfType<_FlupKAppState>()!;

  @override
  State<FlupKApp> createState() => _FlupKAppState();
}

class _FlupKAppState extends State<FlupKApp> {
  late final darkMode = ValueNotifier(widget.initialDarkModeState);
  late final locale = ValueNotifier(widget.initialLocale);
  final List<FishAssets> randomFishes = (FishAssets.values.toList()..shuffle());
  late final currentFish = ValueNotifier(randomFishes.first);

  void setNextFish() {
    final index = randomFishes.indexOf(currentFish.value);
    if (index == randomFishes.length - 1) {
      currentFish.value = randomFishes.first;
    } else {
      currentFish.value = randomFishes[index + 1];
    }
  }

  final router = AppRouter();

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        return ValueListenableBuilder(
          valueListenable: currentFish,
          builder: (context, fish, child) => ValueListenableBuilder(
            valueListenable: darkMode,
            builder: (context, isDarkMode, child) => ValueListenableBuilder(
              valueListenable: locale,
              builder: (context, locale, child) => MaterialApp.router(
                routerConfig: router.config(
                  deepLinkBuilder: (deepLink) async {
                    if (AppDB.get().currentServer?.ip case final ip) {
                      if (ip == null) {
                        return const DeepLink([LoginRoute()]);
                      }

                      final loginController = GetIt.I<LoginController>();
                      final testHost = await loginController.testHost(ip);
                      if (!testHost) return const DeepLink([LoginRoute()]);

                      final service = isMockOn
                          ? KaraokeApiServiceMock()
                          : KaraokeApiService(configuration: KaraokeAPIConfiguration(baseUrl: formatHost(ip)?.toString() ?? ip));
                      GetIt.I.registerSingleton<KaraokeApiService>(service);
                    }
                    if (!deepLink.matches.contains(const HomeRoute()) && deepLink.initial) {
                      final route = router.buildPageRoute(deepLink.path);
                      return DeepLink([const HomeRoute(), if (route != null) route]);
                    }
                    return deepLink;
                  },
                ),
                locale: locale,
                supportedLocales: appLocales,
                localizationsDelegates: const [
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  FlupS.delegate,
                ],
                themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                theme: createWithCustomizations(
                  textTheme: lightTextTheme,
                  colorScheme: fish.colorScheme(context, lightScheme, lightCustomColors),
                  extensions: [lightCustomColors],
                ),
                darkTheme: createWithCustomizations(
                  textTheme: darkTextTheme,
                  colorScheme: fish.colorScheme(context, darkScheme, darkCustomColors),
                  extensions: [darkCustomColors],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
