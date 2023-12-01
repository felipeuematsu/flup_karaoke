import 'package:auto_route/auto_route.dart';
import 'package:flup_karaoke/configuration/app_locales.dart';
import 'package:flup_karaoke/generated/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LanguageSelectView extends StatelessWidget {
  const LanguageSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(FlupS.of(context).language)),
      body: SafeArea(
        child: ListView.builder(
          itemCount: appLocales.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(appLocaleText(appLocales[index])),
            onTap: () => updateAppLocale(appLocales[index], context).then((value) => AutoRouter.of(context).pop()),
          ),
        ),
      ),
    );
  }
}
