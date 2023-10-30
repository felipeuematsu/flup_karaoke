import 'package:flup_karaoke/configuration/app_locales.dart';
import 'package:flup_karaoke/database/database.dart';
import 'package:flup_karaoke/main.dart';
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
      onChanged: (locale) => appDb.setLocale(FlupKApp.of(context).locale.value = locale),
      items: appLocales.entries.map((e) => DropdownMenuItem(value: e.value, child: SizedBox.square(dimension: 24, child: Text(e.key)))).toList(),
    );
  }
}
