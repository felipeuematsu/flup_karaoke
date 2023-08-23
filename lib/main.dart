import 'package:dynamic_color/dynamic_color.dart';
import 'package:flup_karaoke/features/login/view/login_view.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/themes/color_schemes.g.dart';
import 'package:flup_karaoke/themes/custom_color.g.dart';
import 'package:flup_karaoke/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

        return MaterialApp(
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FlupS.delegate,
          ],
          theme: ThemeData(
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
          home: const LoginView(),
        );
      },
    );
  }
}
