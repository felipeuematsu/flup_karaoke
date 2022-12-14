import 'package:flup_karaoke/main.dart';
import 'package:flutter/material.dart';

enum SettingKey {
  language,
  ;

  String get key => toString();
}

enum Languages {
  en,
  pt,
  ;

  String get string {
    switch (this) {
      case Languages.en:
        return 'English';
      case Languages.pt:
        return 'Português';
    }
  }

  Locale get locale => Locale(name);

  static Locale get(BuildContext context) => MyApp.of(context)!.locale!;
}
