import 'package:flup_karaoke/app_imports.dart';
import 'package:flup_karaoke/features/settings/setting_key.dart';
import 'package:flup_karaoke/main.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.settingsTitle.tr(context))),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppStrings.language.tr(context)),
            trailing: DropdownButton(
              hint: Text(AppStrings.language.tr(context)),
              value: Languages.get(context),
              items: const [
                DropdownMenuItem(value: Locale('pt', 'BR'), child: Text('Português (Brasil)')),
                DropdownMenuItem(value: Locale('en', 'US'), child: Text('English (US)')),
              ],
              onChanged: (Locale? locale) {
                if (locale != null) {
                  MyApp.of(context)?.locale = locale;
                }
              },
            ),
          ),
          // ListTile(
          //   title: Text(AppStrings.theme.tr(context)),
          //   trailing: DropdownButton(
          //     value: context.themeMode,
          //     items: [
          //       DropdownMenuItem(value: ThemeMode.system, child: Text(AppStrings.system.tr(context))),
          //       DropdownMenuItem(value: ThemeMode.light, child: Text(AppStrings.light.tr(context))),
          //       DropdownMenuItem(value: ThemeMode.dark, child: Text(AppStrings.dark.tr(context))),
          //     ],
          //     onChanged: (ThemeMode? themeMode) {
          //       if (themeMode != null) context.setThemeMode(themeMode);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
