import 'package:flup_karaoke/configuration/app_locales.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flutter/material.dart';

class SelectLocaleDropdown extends StatefulWidget {
  const SelectLocaleDropdown({super.key});

  @override
  State<SelectLocaleDropdown> createState() => _SelectLocaleDropdownState();
}

class _SelectLocaleDropdownState extends State<SelectLocaleDropdown> {
  final appDb = AppDB.get();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      value: Localizations.localeOf(context),
      onChanged: (locale) => locale != null ? updateAppLocale(locale, context) : null,
      items: appLocales.map((e) => DropdownMenuItem(value: e, child: SizedBox.square(dimension: 24, child: Text(appLocaleText(e))))).toList(),
    );
  }
}
