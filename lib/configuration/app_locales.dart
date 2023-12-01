import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/widgets.dart';

final appLocales = [
  const Locale('en', 'US'),
  const Locale('pt', 'BR'),
];

String appLocaleText(Locale locale) => switch (locale.languageCode) {
      'en' => '🇺🇸 ${FlupS.current.english}',
      'pt' => '🇧🇷 ${FlupS.current.portuguese}',
      _ => '',
    };

Future<void> updateAppLocale(Locale locale, BuildContext context) async {
  final load = FlupS.load(locale);
  final setLocale = AppDB.get().setLocale(locale);
  await Future.wait([load, setLocale]);
  final appState = FlupKApp.of(context);
  appState.rebuildAllChildren(appState.context);
}
