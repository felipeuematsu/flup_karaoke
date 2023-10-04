import 'package:dynamic_color/dynamic_color.dart';
import 'package:flup_karaoke/configuration/dependencies.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/features/login/view/login_view.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/themes/color_schemes.g.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flup_karaoke/themes/text_themes.dart';
import 'package:flup_karaoke/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase();
  await setupDependencies();

  final darkMode = await isDarkMode();
  runApp(FlupKApp(initialDarkModeState: darkMode));
}

class FlupKApp extends StatefulWidget {
  const FlupKApp({Key? key, required this.initialDarkModeState}) : super(key: key);

  final bool initialDarkModeState;

  static _FlupKAppState of(BuildContext context) => context.findAncestorStateOfType<_FlupKAppState>()!;

  @override
  State<FlupKApp> createState() => _FlupKAppState();
}

class _FlupKAppState extends State<FlupKApp> {
  late final isDarkMode = ValueNotifier(widget.initialDarkModeState);

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
          valueListenable: isDarkMode,
          builder: (context, isDarkMode, child) {
            return MaterialApp(
              localizationsDelegates: const [
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                FlupS.delegate,
              ],
              theme: ThemeData(
                textTheme: lightTextTheme,
                cardTheme: cardTheme,
                dialogTheme: dialogTheme,
                elevatedButtonTheme: const ElevatedButtonThemeData(style: buttonStyle),
                filledButtonTheme: const FilledButtonThemeData(style: buttonStyle),
                outlinedButtonTheme: const OutlinedButtonThemeData(style: buttonStyle),
                textButtonTheme: const TextButtonThemeData(style: buttonStyle),
                useMaterial3: true,
                colorScheme: lightScheme,
                extensions: [lightCustomColors],
              ),
              darkTheme: ThemeData(
                textTheme: darkTextTheme,
                cardTheme: cardTheme,
                dialogTheme: dialogTheme,
                elevatedButtonTheme: const ElevatedButtonThemeData(style: buttonStyle),
                filledButtonTheme: const FilledButtonThemeData(style: buttonStyle),
                outlinedButtonTheme: const OutlinedButtonThemeData(style: buttonStyle),
                textButtonTheme: const TextButtonThemeData(style: buttonStyle),
                useMaterial3: true,
                colorScheme: darkScheme,
                extensions: [darkCustomColors],
              ),
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: const LoginView(),
            );
          },
        );
      },
    );
  }
}
